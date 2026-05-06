---
description: "Verify documentation quality, links, freshness, and consistency: $ARGUMENTS"
argument-hint: "[links|freshness|ci|score] or --min-score N"
allowed-tools:
  - Read
  - Glob
  - Grep
  - Bash
---

# /docs-verify

Validate that documentation remains accurate, linked, and fresh over time. Catches broken links, stale content, and llms.txt drift before they reach users.

## Behaviour

1. Load the `docs-verify` skill for the verification checks
2. Scan all Markdown files in the repository
3. Run the requested checks (or all checks if no arguments)
4. Report findings with severity levels

## Arguments

- **No arguments**: Run all checks and report findings
- `links`: Link validation only (internal + external)
- `freshness`: Staleness check only (git blame-based)
- `ci`: All checks, output in CI-friendly format (exit code 1 on errors, file:line format)
- `score`: Run all checks and output the quality score only
- `--min-score N`: Fail if the quality score falls below N (useful for CI gates)

## Checks Performed

| Check | What It Catches |
|-------|----------------|
| Markdown lint | Heading hierarchy skips, single H1 rule, formatting |
| Link validation | Broken relative paths, dead external URLs, missing anchors |
| llms.txt sync | Files referenced in llms.txt that no longer exist, orphaned docs |
| Image validation | Missing image files, empty alt text, relative URLs for npm/PyPI projects |
| Freshness | Docs not updated in 90+ days (configurable via git blame) |
| Feature coverage | README features vs actual code — undocumented and over-documented |
| Badge URLs | Shields.io badges returning errors or outdated formats |
| Token audit | Skill files exceeding recommended token budgets |
| Quality score | Numeric 0–100 score across 6 dimensions with grade band and actionable fix suggestions |

## Output Format

```
📋 Documentation Verification: [project-name]

Markdown Lint:       ✓ 12 files checked, 0 issues
Link Validation:     ⚠ 45 links checked, 2 warnings, 1 error
llms.txt Sync:       ✓ 12/12 references valid
Image Validation:    ⚠ 3 images checked, 1 warning
Freshness:           ⚠ 2 files stale (>90 days)
Feature Coverage:    ✓ 8/10 features documented (80%)
Badge URLs:          ✓ 5/5 badges valid

Errors (must fix):
  ✗ README.md:89 — broken link: docs/guides/migration.md (file not found)

Warnings (should fix):
  ⚠ docs/guides/deployment.md — stale: last updated 95 days ago
  ⚠ README.md:15 — relative image path, will break on npm

📊 Quality Score: 74/100 (C — Needs work)
   Top fix: README.md:89 broken link → fixes +5 points
```
