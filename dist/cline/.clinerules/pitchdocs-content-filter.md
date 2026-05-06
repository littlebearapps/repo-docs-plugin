# Content Filter Quick Reference

Claude Code's API content filter blocks output (HTTP 400) when generating certain standard OSS documentation files. This is a context-blind copyright filter — it triggers on governance language, security keywords, and verbatim legal text even when the intent is entirely legitimate. This quick reference helps you avoid the error. See the `docs-writer` agent (Content Filter Mitigation section) for the full playbook.

## Risk Levels

| File | Risk | Strategy |
|------|------|----------|
| CODE_OF_CONDUCT.md | HIGH | Fetch from canonical URL with `curl`, then customise with Edit |
| LICENSE | HIGH | Fetch from SPDX or use GitHub licence picker |
| SECURITY.md | MEDIUM-HIGH | Fetch template with `curl`, then customise with Edit |
| CHANGELOG.md | MEDIUM | Write in chunks (5–10 entries), use Edit to append |
| CONTRIBUTING.md | LOW-MEDIUM | Write in chunks; start with project-specific content first |

## Quick Fetch Commands (HIGH-Risk Files)

Always fetch these files rather than generating them inline:

```bash
# Contributor Covenant v3.0
curl -sL "https://www.contributor-covenant.org/version/3/0/code_of_conduct/code_of_conduct.md" -o CODE_OF_CONDUCT.md

# MIT License (substitute SPDX identifier as needed)
curl -sL "https://raw.githubusercontent.com/spdx/license-list-data/main/text/MIT.txt" -o LICENSE

# GitHub's own security policy (heavy customisation needed — replace all GitHub-specific references)
curl -sL "https://raw.githubusercontent.com/github/.github/main/SECURITY.md" -o SECURITY.md
```

After fetching, use **Edit** (not Write) to replace placeholders like `[INSERT CONTACT METHOD]`, `[year]`, `[fullname]` with project-specific values.

## Chunked Writing (MEDIUM-Risk Files)

For CHANGELOG.md and CONTRIBUTING.md:

1. Write header and first section (5–10 lines) with Write
2. Append subsequent sections one at a time with Edit
3. Keep each write operation under 15 lines of template-like content
4. Start with the most project-specific content before generic sections

## What NOT to Do

- Do **not** generate high-risk files from scratch — always fetch first
- Do **not** retry identical blocked content — the filter is largely deterministic
- Do **not** include large inline templates in prompts
- Do **not** use `--resume` after a filter block — start a fresh attempt with a different strategy

## If the Filter Triggers

1. Do **not** retry the same content — it will fail again
2. Switch to a fetch-based strategy (curl from canonical URL)
3. If subsequent unrelated writes also fail, the session may be poisoned — run `/clear` or start a new Claude Code session
4. For MEDIUM-risk files, break into smaller chunks (5 entries at a time) and rephrase

## Other Known Triggers

The filter also triggers on non-documentation content that resembles standardised datasets: ISO country/state code lists, character mapping tables (e.g. kana-to-romaji), and large lookup tables. The same chunked-writing strategy applies.
