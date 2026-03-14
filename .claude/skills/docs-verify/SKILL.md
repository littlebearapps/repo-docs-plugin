---
name: docs-verify
description: Validates documentation quality and freshness — checks for broken links, stale content, llms.txt sync, image issues, heading hierarchy, and badge URLs. Runs locally or in CI. Use to catch documentation decay before it reaches users.
version: "1.5.0"
---

# Documentation Verifier

## Philosophy

Generating documentation is a solved problem. **Preventing documentation decay** is not. This skill validates that generated docs remain accurate, linked, and fresh over time.

## Verification Checks

### 1. Markdown Lint

Check heading hierarchy and structural consistency across all `.md` files. Verify: heading hierarchy (no H1 > H3 skips — critical for RAG/GEO), single H1 per doc, consistent formatting (trailing whitespace, list markers, blank lines around headings), no bare URLs.

### 2. Link Validation

Check all internal and external links. **Internal**: verify target file exists, anchor links match headings, check case-sensitivity (Linux vs macOS). **External**: check HTTP status, timeout 10s, skip authenticated URLs, flag 404s/5xx. Enhanced detection patterns (case-sensitivity, fragments, redirect chains, nested relative links) in `SKILL-reference.md`.

### 3. llms.txt Sync Check

Verify `llms.txt` references match actual files on disk. Check for: missing files, orphaned docs not listed in llms.txt, description drift (first paragraph check), stale llms-full.txt.

### 4. Image Validation

Check all image references in Markdown. Verify: file exists on disk, alt text present (flag empty `![]()`), absolute URLs for registry-published packages (see `SKILL-reference.md` for platform URL patterns), file size under 1MB.

### 5. Freshness Check

Flag stale docs using `git log` last-modification dates. See `SKILL-reference.md` for per-file staleness thresholds. Compare against latest commit date, not calendar date — dormant projects with no commits shouldn't trigger warnings.

### 6. Feature Coverage Sync

Compare README features against actual code using `feature-benefits` skill extraction. Flag undocumented features (code evidence exists, not in README) and over-documented features (claimed but no code evidence).

### 7. Badge URL Validation

Verify shields.io badge URLs return valid responses (HTTP 200, not error SVGs). Flag broken badges and outdated URL formats.

## Quality Score

After running all verification checks, calculate a numeric quality score. The score gives users a single number to track and improve — modelled on the grading approach used in documentation quality tooling across the ecosystem.

See `SKILL-reference.md` for the 6-dimension scoring rubric (Completeness, Structure, Freshness, Link Health, Evidence, GEO & Citation Readiness) and grade bands (A through F).

### Score Calculation

```
score = 100
for each check result:
  apply deductions from SKILL-reference.md scoring dimensions
score = max(0, score)
grade = lookup(score)  // A: 90–100, B: 80–89, C: 70–79, D: 60–69, F: <60
```

Report: show per-dimension breakdown and always include an actionable "To reach next grade" suggestion with the 1-2 highest-impact fixes. See `SKILL-reference.md` for the full report format example.

Supports `ci` argument for pipeline use (`/docs-verify ci --min-score 70`) and `--min-score N` threshold. See `SKILL-reference.md` for CI score export snippets (GitHub Actions, GitLab CI).

### 8. Guide Frontmatter Validation

Verify `docs/` files have valid YAML frontmatter per the `user-guides` skill standard. Required fields: `title`, `description`, `type` (one of `tutorial`, `how-to`, `reference`, `explanation`). Also check: title matches H1, `related:` paths exist on disk. **Scoring**: -2 per guide missing required frontmatter (Structure dimension).

### 9. Token Audit

Estimate token cost for all skill files in `.claude/skills/` using `wc -w` × 1.3. Flag skills over 3,000 tokens (reference) or 5,000 tokens (combined). Full audit script and thresholds in `SKILL-reference.md`.

### 10. Security Scan

Scan docs for content that should never appear in public repos. Classify credential-pattern matches as: placeholder (acceptable), env var reference (acceptable), or real credential (block immediately). Also check for: leaked internal paths (`/Users/`, `/home/`, `C:\Users\`), internal hostnames/IPs (`192.168.`, `10.0.`), and non-existent package names (dependency confusion vectors).

### 11. AI Context Health (Lightweight)

Basic presence and staleness check for AI context files (CLAUDE.md, AGENTS.md, .cursorrules, etc.). **Scoring**: -2 per context file older than 90 days, -1 per missing file in the project's tool ecosystem. For full signal-gate scoring and line budget analysis, install [ContextDocs](https://github.com/littlebearapps/contextdocs).

## CI Integration

When run with `ci` argument, output machine-readable `ERROR:`/`WARN:` lines with file:line format and exit code 1 on errors. Supports `--min-score N` threshold. Full CI output format and GitHub Actions workflow template in `SKILL-reference.md`.

## Anti-Patterns

- **Don't ignore warnings** — a broken link today becomes a confused user tomorrow
- **Don't run external link checks on every commit** — run them on PRs and weekly schedules to avoid rate limiting
- **Don't fix docs in a separate PR from code changes** — docs updates should accompany the code that changes behaviour
- **Don't suppress freshness warnings without reviewing** — stale docs erode trust faster than missing docs
