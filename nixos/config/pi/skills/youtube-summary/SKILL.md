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

## Concise summary
- Compress the video into the fewest bullets needed to preserve the core message.

## Key claims / arguments
- List the speaker's main claims, arguments, conclusions, and supporting rationale.

## Concepts and definitions
- Define important terms, frameworks, distinctions, and assumptions needed to understand the video.

## Step-by-step instructions
- If the video teaches a process, extract the procedure as clear numbered steps.
- Omit this section or mark it as not applicable when the video is not instructional.

## Important examples
- Capture examples, demonstrations, case studies, analogies, or stories that materially improve understanding.

## Tools, links, or resources mentioned
- ...

## Action items / takeaways
- List concrete next actions, decisions, habits, checklists, or lessons the viewer can apply.

## Selected timestamp ranges worth watching
- Include timestamp ranges **only when watching the video adds information needed to properly understand the content that is not easily understood or derived from the transcript alone**.
- Do **not** use this section as a timestamped outline, chapter map, or list of where transcript topics occur. If the transcript captures the material adequately, omit the timestamp even if the section is important.
- The fewer selected timestamp ranges, the better, but do not omit any segment whose visual/non-text content is necessary for understanding.
- Strong reasons to include a segment:
  - on-screen prompts, code, slides, diagrams, documents, tables, UI flows, or other visual material that captions reference but do not reproduce;
  - visual demonstrations, screen shares, physical examples, before/after comparisons, or workflows where seeing the actions matters;
  - moments where tone, nuance, interaction, or delivery materially changes interpretation and cannot be captured well in text.
- Weak reasons that are **not sufficient** by themselves:
  - the segment introduces an important concept that the transcript explains clearly;
  - the segment corresponds to a major chapter or section;
  - the speaker gives a concise verbal explanation;
  - routine talking-head content, intros, sponsor reads, recaps, or mildly relevant material.
- Before adding a range, ask: "Would a reader who only has the transcript materially misunderstand or miss something necessary if they skipped the video here?" Include it only if the answer is yes.
- For each selected segment, include the shortest useful start/end range and a reason focused on the missing visual/non-transcript information.
- If no video segments are needed beyond the transcript, write `- None; the transcript is sufficient.`
- Make the start timestamp clickable as a Markdown link to the YouTube URL with the appropriate `t=` parameter, so the user can jump directly to the section. Use this format: `- [MM:SS–MM:SS](https://www.youtube.com/watch?v=<video-id>&t=<start-seconds>s) — reason`. For videos longer than one hour, use `HH:MM:SS–HH:MM:SS` while still using total seconds in the `t=` parameter.

## Caveats
- Note transcript quality issues, missing captions, or uncertainty here.
```

When timestamps are present, preserve useful timestamps in the summary and especially in `Selected timestamps worth watching`. Do not invent claims, links, quotes, or timestamps that are not in the transcript.

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
