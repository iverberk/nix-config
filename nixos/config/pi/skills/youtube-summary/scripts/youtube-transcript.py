#!/usr/bin/env python3
"""Extract a YouTube transcript using yt-dlp captions first and whisper.cpp fallback."""

from __future__ import annotations

import argparse
import glob
import html
import json
import os
import re
import shutil
import subprocess
import sys
from pathlib import Path
from typing import Iterable


def run(cmd: list[str], cwd: Path | None = None, check: bool = True) -> subprocess.CompletedProcess[str]:
    return subprocess.run(cmd, cwd=cwd, text=True, stdout=subprocess.PIPE, stderr=subprocess.PIPE, check=check)


def require(command: str) -> str:
    path = shutil.which(command)
    if not path:
        raise SystemExit(f"Missing required command: {command}")
    return path


def safe_name(value: str) -> str:
    value = re.sub(r"[^a-zA-Z0-9._-]+", "-", value.strip())
    return value.strip("-._") or "video"


def get_metadata(url: str) -> dict:
    require("yt-dlp")
    proc = run(["yt-dlp", "--dump-single-json", "--skip-download", url])
    return json.loads(proc.stdout)


def download_captions(url: str, video_dir: Path, lang: str) -> list[Path]:
    # Try manual subtitles and auto captions. yt-dlp exits non-zero when no requested
    # subtitles exist, so do not check here.
    outtmpl = str(video_dir / "%(id)s.%(ext)s")
    cmd = [
        "yt-dlp",
        "--skip-download",
        "--write-subs",
        "--write-auto-subs",
        "--sub-langs",
        f"{lang}.*,{lang}",
        "--sub-format",
        "vtt",
        "--convert-subs",
        "vtt",
        "-o",
        outtmpl,
        url,
    ]
    run(cmd, check=False)
    return sorted(video_dir.glob("*.vtt"))


def parse_vtt_timestamp(value: str) -> float:
    parts = value.replace(",", ".").split(":")
    seconds = float(parts[-1])
    minutes = int(parts[-2]) if len(parts) >= 2 else 0
    hours = int(parts[-3]) if len(parts) >= 3 else 0
    return hours * 3600 + minutes * 60 + seconds


def format_timestamp(seconds: float) -> str:
    total = int(seconds)
    hours = total // 3600
    minutes = (total % 3600) // 60
    secs = total % 60
    return f"{hours:02d}:{minutes:02d}:{secs:02d}"


def clean_caption_text(lines: list[str]) -> str:
    text = " ".join(line.strip() for line in lines if line.strip())
    text = re.sub(r"<[^>]+>", "", text)
    text = html.unescape(text)
    text = re.sub(r"\[(?:music|applause|laughter|noise|silence)\]", "", text, flags=re.IGNORECASE)
    text = re.sub(r"\s+", " ", text).strip()
    return text


def normalized_words(text: str) -> list[str]:
    # Keep hyphenated words as one token so normalized token indexes stay close
    # to text.split() indexes when selecting the non-overlapping suffix.
    return re.findall(r"[a-z0-9'][a-z0-9'-]*", text.lower())


def is_contained_in_recent(words: list[str], recent_words: list[str]) -> bool:
    if not words:
        return True
    if len(words) > len(recent_words):
        return False
    haystack = " " + " ".join(recent_words[-120:]) + " "
    needle = " " + " ".join(words) + " "
    return needle in haystack


def overlap_prefix_length(words: list[str], recent_words: list[str], max_overlap: int = 40) -> int:
    limit = min(len(words), len(recent_words), max_overlap)
    for size in range(limit, 0, -1):
        if recent_words[-size:] == words[:size]:
            return size
    return 0


def dedupe_rolling_captions(cues: list[tuple[float, str]]) -> str:
    """Collapse YouTube's rolling auto-caption fragments into readable text.

    Auto captions often emit overlapping cues such as "foo bar", then
    "foo bar baz", then "bar baz qux". This keeps only the newly introduced
    suffix for each cue while inserting coarse timestamps for navigation.
    """
    output: list[str] = []
    recent_words: list[str] = []
    last_marker_at = -9999.0
    previous_text = ""

    for start, text in cues:
        words = normalized_words(text)
        if not words or text == previous_text or is_contained_in_recent(words, recent_words):
            previous_text = text
            continue

        original_words = text.split()
        overlap = overlap_prefix_length(words, recent_words)
        addition = " ".join(original_words[overlap:]).strip()
        addition_words = normalized_words(addition)
        if not addition or is_contained_in_recent(addition_words, recent_words):
            previous_text = text
            continue

        if start - last_marker_at >= 30 or not output:
            if output and output[-1] != "":
                output.append("")
            output.append(f"[{format_timestamp(start)}]")
            last_marker_at = start

        output.append(addition)
        recent_words.extend(addition_words)
        recent_words = recent_words[-200:]
        previous_text = text

    blocks: list[str] = []
    marker: str | None = None
    text_parts: list[str] = []

    def flush_block() -> None:
        nonlocal marker, text_parts
        if marker and text_parts:
            paragraph = re.sub(r"\s+", " ", " ".join(text_parts)).strip()
            paragraph = re.sub(r"(?:>>\s*){2,}", ">> ", paragraph)
            paragraph = re.sub(r"\b([A-Za-z]{2,})([,.])\s+\1\2", r"\1\2", paragraph, flags=re.IGNORECASE)
            blocks.append(f"{marker}\n{paragraph}")
        marker = None
        text_parts = []

    for item in output:
        if not item:
            continue
        if re.fullmatch(r"\[\d\d:\d\d:\d\d\]", item):
            flush_block()
            marker = item
        else:
            text_parts.append(item)

    flush_block()
    return "\n\n".join(blocks).strip() + "\n"


def clean_vtt(path: Path) -> str:
    lines = path.read_text(encoding="utf-8", errors="replace").splitlines()
    cues: list[tuple[float, str]] = []
    current_start: float | None = None
    current_text: list[str] = []

    def flush_cue() -> None:
        nonlocal current_start, current_text
        if current_start is not None and current_text:
            text = clean_caption_text(current_text)
            if text:
                cues.append((current_start, text))
        current_start = None
        current_text = []

    for raw_line in lines:
        line = raw_line.strip()
        if not line or line == "WEBVTT" or line.startswith(("Kind:", "Language:", "NOTE")):
            if not line:
                flush_cue()
            continue
        if re.fullmatch(r"\d+", line):
            continue
        if "-->" in line:
            flush_cue()
            current_start = parse_vtt_timestamp(line.split("-->", 1)[0].strip())
            continue
        current_text.append(line)

    flush_cue()
    return dedupe_rolling_captions(cues)


def find_whisper_command() -> str | None:
    for candidate in ["whisper-cli", "whisper-cpp", "main"]:
        path = shutil.which(candidate)
        if path:
            return path
    return None


def find_whisper_model(explicit: str | None) -> Path | None:
    candidates: list[str] = []
    if explicit:
        candidates.append(explicit)
    if os.environ.get("WHISPER_CPP_MODEL"):
        candidates.append(os.environ["WHISPER_CPP_MODEL"])
    candidates.extend(glob.glob(str(Path.home() / ".cache" / "whisper.cpp" / "ggml-*.bin")))

    for candidate in candidates:
        path = Path(candidate).expanduser()
        if path.is_file():
            return path
    return None


def download_audio(url: str, video_dir: Path) -> Path:
    require("ffmpeg")
    outtmpl = str(video_dir / "audio.%(ext)s")
    cmd = [
        "yt-dlp",
        "-f",
        "bestaudio/best",
        "--extract-audio",
        "--audio-format",
        "wav",
        "--audio-quality",
        "0",
        "-o",
        outtmpl,
        url,
    ]
    run(cmd)
    audio = video_dir / "audio.wav"
    if not audio.exists():
        matches = sorted(video_dir.glob("audio.*"))
        if matches:
            return matches[0]
        raise SystemExit("Audio download completed but no audio file was found")
    return audio


def transcribe_with_whisper(audio: Path, video_dir: Path, model: Path, lang: str | None) -> Path:
    whisper = find_whisper_command()
    if not whisper:
        raise SystemExit("Missing whisper.cpp command. Expected one of: whisper-cli, whisper-cpp, main")

    output_base = video_dir / "whisper"
    cmd = [whisper, "-m", str(model), "-f", str(audio), "-otxt", "-of", str(output_base)]
    if lang:
        cmd.extend(["-l", lang])
    run(cmd)

    transcript = output_base.with_suffix(".txt")
    if not transcript.exists():
        raise SystemExit("Whisper finished but did not create the expected transcript file")
    return transcript


def write_metadata(video_dir: Path, metadata: dict) -> None:
    useful = {
        "id": metadata.get("id"),
        "title": metadata.get("title"),
        "uploader": metadata.get("uploader"),
        "channel": metadata.get("channel"),
        "duration": metadata.get("duration"),
        "webpage_url": metadata.get("webpage_url"),
        "upload_date": metadata.get("upload_date"),
        "chapters": metadata.get("chapters"),
    }
    (video_dir / "metadata.json").write_text(json.dumps(useful, indent=2, ensure_ascii=False) + "\n", encoding="utf-8")


def main(argv: Iterable[str]) -> int:
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument("url", help="YouTube video URL")
    parser.add_argument("--lang", default="en", help="Subtitle/transcription language, default: en")
    parser.add_argument("--output-dir", default="~/.cache/pi/youtube-summary", help="Cache/output directory")
    parser.add_argument("--force-whisper", action="store_true", help="Skip captions and transcribe audio with whisper.cpp")
    parser.add_argument("--whisper-model", help="Path to a whisper.cpp ggml model")
    args = parser.parse_args(list(argv))

    metadata = get_metadata(args.url)
    video_id = safe_name(str(metadata.get("id") or "video"))
    title = str(metadata.get("title") or video_id)
    video_dir = Path(args.output_dir).expanduser() / video_id
    video_dir.mkdir(parents=True, exist_ok=True)
    write_metadata(video_dir, metadata)

    transcript_path = video_dir / "transcript.txt"
    source_path = video_dir / "transcript.source"

    if not args.force_whisper:
        captions = download_captions(args.url, video_dir, args.lang)
        if captions:
            # Prefer non-auto style names when available, otherwise use the first VTT.
            caption = sorted(captions, key=lambda p: ("auto" in p.name.lower(), len(p.name)))[0]
            transcript_path.write_text(clean_vtt(caption), encoding="utf-8")
            source_path.write_text(f"captions: {caption.name}\n", encoding="utf-8")
            print(f"Title: {title}")
            print(f"Source: captions")
            print(f"Directory: {video_dir}")
            print(f"Transcript: {transcript_path}")
            return 0

    model = find_whisper_model(args.whisper_model)
    if not model:
        raise SystemExit(
            "No whisper.cpp model found. Provide --whisper-model, set WHISPER_CPP_MODEL, "
            "or place ggml-*.bin in ~/.cache/whisper.cpp/."
        )

    audio = download_audio(args.url, video_dir)
    whisper_txt = transcribe_with_whisper(audio, video_dir, model, args.lang)
    transcript_path.write_text(whisper_txt.read_text(encoding="utf-8", errors="replace"), encoding="utf-8")
    source_path.write_text(f"whisper-cpp: {model}\n", encoding="utf-8")

    print(f"Title: {title}")
    print("Source: whisper-cpp")
    print(f"Directory: {video_dir}")
    print(f"Transcript: {transcript_path}")
    return 0


if __name__ == "__main__":
    raise SystemExit(main(sys.argv[1:]))
