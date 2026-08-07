---
name: ketch
description: Search the web, fetch online pages as clean markdown, search library documentation, and search public code using the ketch CLI. Use when current online information, documentation, URLs, or examples are needed.
---

# Ketch

Use the `ketch` CLI through the `bash` tool when you need online search or page extraction.

## Common commands

```bash
ketch search "query" --backend exa --limit 5 --minimal
ketch search "query" --backend ddg --limit 5 --minimal
ketch search "query" --backend exa --limit 3 --scrape --max-chars 12000
ketch scrape https://example.com --max-chars 12000
ketch docs "library or topic" --limit 5
ketch code "query" --lang go --limit 5
ketch doctor
```

## Guidance

- Prefer `ketch search ... --minimal` first to identify relevant sources.
- Use `ketch scrape <url> --max-chars <n>` to fetch selected pages as markdown.
- Use `ketch search ... --scrape --max-chars <n>` only when a small number of results should be fetched immediately.
- Prefer `--backend exa` for general web search; use `--backend ddg` as a fallback unless Brave is configured with an API key.
- Use `ketch docs` for library/framework documentation and `ketch code` for public source examples.
- Cite URLs from search/scrape results in the final answer when relying on online content.
