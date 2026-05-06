---
description: "Generate or update CHANGELOG.md from git history: $ARGUMENTS"
argument-hint: "[version or 'full' for complete history]"
allowed-tools:
  - Read
  - Glob
  - Grep
  - Bash
  - Write
  - Edit
  - mcp__github__list_releases
  - mcp__github__list_commits
  - mcp__github__list_tags
  - mcp__github__list_pull_requests
---

# /changelog

Generate or update CHANGELOG.md using conventional commits and user-benefit language.

## Behaviour

1. Load the `changelog` skill for format and language rules
2. Load the `doc-standards` rule for tone
3. If GitHub MCP tools are unavailable (GitLab/Bitbucket), gather equivalent data via `glab` CLI, REST API, or git history. Load `platform-profiles` for compare URL patterns.
4. Analyse git history:
   - Parse conventional commit messages
   - Identify tagged releases
   - Map commits to issues/PRs
5. Classify changes into Keep a Changelog categories
6. Rewrite commit messages in user-benefit language
7. Generate or update CHANGELOG.md

## Arguments

- No arguments: generates/updates the `[Unreleased]` section only
- Version (e.g., `1.3.0`): generates entry for a specific version from tag
- `full`: regenerates the entire changelog from all tags

## Language Transformation

Input (git log):
```
feat: add marketing-friendly readme generation (#42)
fix: resolve badge URL encoding for special characters (#35)
refactor: extract template engine into separate module
```

Output (CHANGELOG.md):
```markdown
### Added
- You can now generate READMEs with marketing-friendly language (#42)

### Fixed
- Badge URLs no longer break when repos contain special characters (#35)
```

Note: The refactor is excluded — it's internal and doesn't affect users.

## Output

Writes directly to `CHANGELOG.md`. Preserves existing entries when updating.
