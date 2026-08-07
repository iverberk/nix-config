---
name: youtube-summary
description: Summarize YouTube videos from URLs using yt-dlp captions first, whisper-cpp transcription fallback, and Pi's active chat model for summarization. Use when the user asks to summarize, extract notes from, or analyze a YouTube video.
---

# YouTube Summary

Use this skill to summarize YouTube videos from a URL using a free CLI-first workflow.

Important model note:
- Do **not** require a local LLM for summarization.
- Use Pi's currently selected chat model to perform the summary in the conversation.
- A ChatGPT Plus/Pro web subscription does not normally expose a CLI/API. If the user has configured Pi to use OpenAI/API models, use that active Pi model. Otherwise, just use whatever model Pi is currently running.
- `whisper-cpp` is only for speech-to-text when YouTube captions are unavailable.

## Workflow

1. Extract a transcript:
   - Prefer official/manual YouTube subtitles.
   - Fall back to auto-captions.
   - Only if captions are missing, download audio and use `whisper-cpp`.
2. Read the generated transcript file.
3. Summarize with Pi's current model.
4. Save or present the result as Markdown if the user asks for a file.

## Helper script

Run the helper from the skill directory:

```bash
python3 scripts/youtube-transcript.py "<youtube-url>"
```

Useful options:

```bash
python3 scripts/youtube-transcript.py "<url>" --lang en --output-dir ~/.cache/pi/youtube-summary
python3 scripts/youtube-transcript.py "<url>" --force-whisper
python3 scripts/youtube-transcript.py "<url>" --whisper-model ~/.cache/whisper.cpp/ggml-base.en.bin
```

The script prints paths and writes:

```text
<output-dir>/<video-id>/
  metadata.json
  transcript.txt
  transcript.source
  *.vtt              # when captions are available
  audio.wav          # when whisper fallback is used

Caption transcripts are cleaned with rolling-caption deduplication: exact repeats are removed, overlapping auto-caption fragments are collapsed, and coarse timestamps are retained for navigation.
```

If whisper fallback is required, the script needs a whisper.cpp model file. It checks, in order:

1. `--whisper-model <path>`
2. `$WHISPER_CPP_MODEL`
3. `~/.cache/whisper.cpp/ggml-*.bin`

If no model exists, ask the user whether they want help downloading one, for example a small English model into `~/.cache/whisper.cpp/`.

## Summarization instructions

After extracting `transcript.txt`, inspect enough of it to determine length and structure. For long transcripts, summarize in chunks rather than pasting the entire transcript at once.

Use this output format by default:

```markdown
# <video title if known>

## TL;DR
- ...

## Main points
- ...

## Important details
- ...

## Tools, links, or resources mentioned
- ...

## Action items / takeaways
- ...

## Caveats
- Note transcript quality issues, missing captions, or uncertainty here.
```

When timestamps are present, preserve useful timestamps in the summary. Do not invent claims, links, quotes, or timestamps that are not in the transcript.

## Chunking strategy

For transcripts that are too large for one response:

1. Split into logical chunks, preferably around timestamp boundaries.
2. Summarize each chunk with emphasis on concrete claims, examples, named tools, decisions, and timestamps.
3. Merge the chunk summaries into the final Markdown summary.
4. If the user asks for detail, include a section-by-section or timestamped outline.

## Dependency checks

Before running the helper, verify the needed tools are available:

```bash
command -v yt-dlp
command -v python3
```

For audio fallback, also verify:

```bash
command -v ffmpeg
command -v whisper-cli || command -v whisper-cpp || command -v main
```

If a dependency is missing, explain which Nix package provides it. In this repo, `yt-dlp`, `ffmpeg`, and `whisper-cpp` are expected to be installed via Home Manager.
