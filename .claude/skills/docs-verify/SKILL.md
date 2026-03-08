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

Check heading hierarchy and structural consistency across all documentation files.

```bash
# Find all documentation Markdown files
find . -name "*.md" -not -path "./.git/*" -not -path "./node_modules/*" | sort
```

For each file, verify:

- **Heading hierarchy** — H1 > H2 > H3 without skipping levels (no H1 > H3). Critical for RAG chunking and GEO.
- **Single H1** — Only one H1 per document (the title)
- **Consistent formatting** — No trailing whitespace, consistent list markers, blank lines around headings
- **No bare URLs** — Links should use `[text](url)` format, not raw URLs in prose

Report format:
```
Markdown Lint:
  ✓ README.md — 0 issues
  ⚠ docs/guides/configuration.md:45 — heading level skipped (H2 → H4)
  ⚠ CONTRIBUTING.md:23 — trailing whitespace
```

### 2. Link Validation

Check all internal and external links in documentation files.

**Internal links (relative paths and anchors):**

```bash
# Extract relative links from Markdown files
grep -roE '\[([^\]]*)\]\(([^)]+)\)' docs/ README.md CONTRIBUTING.md CHANGELOG.md 2>/dev/null
```

For each relative link:
- Verify the target file exists on disk
- Verify anchor links (`#section-name`) match an actual heading in the target file
- Check for case-sensitivity issues (common on Linux, invisible on macOS)

**External links (URLs):**

For each external URL found in documentation:
- Check HTTP status code (200 OK, 301 redirect, 404 not found)
- Timeout after 10 seconds per URL
- Skip URLs behind authentication (GitHub private repos, paywalled content)
- Flag any 404s or 5xx errors

Report format:
```
Link Validation:
  Checked: 45 links (32 internal, 13 external)
  ✓ 42 valid
  ✗ README.md:89 — docs/guides/migration.md (file not found)
  ✗ CONTRIBUTING.md:34 — #setup-instructions (anchor not found, did you mean #development-setup?)
  ⚠ README.md:12 — https://example.com/old-docs (301 redirect → https://example.com/docs)
```

Enhanced detection patterns for case-sensitivity, fragment anchors, redirect chains, and nested relative links are available in `SKILL-extended.md` — load it when deeper link analysis is needed.

### 3. llms.txt Sync Check

Verify that `llms.txt` references match actual files on disk.

```bash
# Extract file paths from llms.txt
grep -oE '\./[^ ]+\.md' llms.txt 2>/dev/null | while read -r path; do
  [ -f "$path" ] && echo "✓ $path" || echo "✗ $path (file not found)"
done
```

Also check:
- Every Markdown file in the repo is represented in llms.txt (no orphaned docs)
- Descriptions in llms.txt match the actual file content (first paragraph check)
- llms-full.txt (if present) is not stale — compare modification time against source files

Report format:
```
llms.txt Sync:
  ✓ 12/12 referenced files exist
  ⚠ docs/guides/deployment.md not listed in llms.txt (orphaned doc)
  ⚠ llms-full.txt is 14 days older than README.md — may need regeneration
```

### 4. Image Validation

Check that all referenced images exist and are properly formatted.

```bash
# Extract image references from Markdown files
grep -roE '!\[([^\]]*)\]\(([^)]+)\)' docs/ README.md 2>/dev/null
```

For each image reference:
- **File exists** — Verify the image file is on disk (for relative paths)
- **Alt text present** — Flag images with empty alt text (`![]()`)
- **Absolute URLs for registries** — If the project is published to npm/PyPI, images must use absolute URLs, not relative paths. URL pattern varies by platform: GitHub `raw.githubusercontent.com/...`, GitLab `gitlab.com/org/repo/-/raw/...`, Bitbucket `bitbucket.org/org/repo/raw/...`. Load `platform-profiles` for the full mapping.
- **File size** — Flag images over 1MB (GitHub has a 10MB file limit, but large images slow page load)

Report format:
```
Image Validation:
  ✓ docs/images/demo.gif — exists, alt text: "Quick start demo", 2.3MB
  ⚠ docs/images/architecture.svg — empty alt text
  ✗ README.md:15 — assets/screenshot.png (file not found)
  ⚠ README.md:15 — relative image path, will break on npm (use absolute URL)
```

### 5. Freshness Check

Flag documentation files that haven't been updated recently. Uses `git log` to check the last modification date.

```bash
# Check last modification date for each doc file
for f in README.md CONTRIBUTING.md CHANGELOG.md docs/guides/*.md; do
  if [ -f "$f" ]; then
    last_modified=$(git log -1 --format="%ci" -- "$f" 2>/dev/null)
    echo "$f: $last_modified"
  fi
done
```

**Staleness thresholds (configurable):**

| File | Warning | Stale |
|------|---------|-------|
| README.md | 90 days | 180 days |
| CHANGELOG.md | 30 days (if releases exist) | 90 days |
| CONTRIBUTING.md | 180 days | 365 days |
| docs/guides/*.md | 90 days | 180 days |
| SECURITY.md | 180 days | 365 days |

Compare against latest commit date, not calendar date — a dormant project with no commits shouldn't trigger freshness warnings.

Report format:
```
Freshness Check:
  ✓ README.md — updated 12 days ago
  ⚠ docs/guides/deployment.md — last updated 95 days ago (threshold: 90 days)
  ✗ CONTRIBUTING.md — last updated 14 months ago (stale)
  · CHANGELOG.md — 2 releases since last update (v1.3.0, v1.4.0)
```

### 6. Feature Coverage Sync

Compare features mentioned in README against actual code. Reuses the `feature-benefits` skill's extraction workflow.

1. Load `feature-benefits` skill and run the feature extraction
2. Parse README.md features section for listed features
3. Cross-reference:
   - **Undocumented features** — code evidence exists, but not in README
   - **Over-documented features** — claimed in README, but no code evidence

Report format:
```
Feature Coverage: 8 documented / 10 detected (80%)
  Missing from README:
    - WebSocket support — found in src/ws.ts
    - Rate limiting — found in src/middleware/ratelimit.ts
  Over-documented:
    - "AI-powered suggestions" — no code evidence found
```

### 7. Badge URL Validation

Verify that shields.io badges in README return valid responses.

```bash
# Extract badge URLs from README
grep -oE 'https://img\.shields\.io/[^)]+' README.md 2>/dev/null
```

For each badge URL:
- Fetch the URL and check for HTTP 200
- Flag badges that return error SVGs (e.g., "invalid" or "not found")
- Check that badge links point to valid destinations

Report format:
```
Badge Validation:
  ✓ build status — 200 OK (passing)
  ✓ npm version — 200 OK (1.4.1)
  ✗ coverage — 200 OK but shows "unknown" (codecov may not be configured)
  ⚠ downloads — 301 redirect (badge URL format may be outdated)
```

## Quality Score

After running all verification checks, calculate a numeric quality score. The score gives users a single number to track and improve — modelled on the grading approach used in documentation quality tooling across the ecosystem.

### Scoring Dimensions

| Dimension | Max | Deductions |
|-----------|-----|-----------|
| Completeness | 30 | -5 per missing Tier 1 file (README, LICENSE, CONTRIBUTING, issue templates, PR template), -3 per missing Tier 2 file (CHANGELOG, SECURITY, CODE_OF_CONDUCT, llms.txt, AGENTS.md), -1 per missing Tier 3 file (ROADMAP, CITATION.cff, .cursorrules) |
| Structure | 20 | -5 if heading hierarchy skipped anywhere, -5 if hero missing required parts (one-liner + explanatory sentence + badges), -5 if no 4-question framework evident, -5 if single H1 rule violated |
| Freshness | 15 | -5 per stale file (>180 days since last update), -3 per warning file (>90 days) |
| Link Health | 20 | -5 per broken internal link (file not found), -3 per broken external link (404/5xx), -2 per broken anchor |
| Evidence | 15 | -5 if feature coverage below 70%, -5 per over-documented feature (claims without code evidence), -3 per missing benefit translation in features section |

### Score Calculation

```
score = 100
for each check result:
  apply deductions from the table above
score = max(0, score)
grade = lookup(score)
```

### Grade Bands

| Score | Grade | Label |
|-------|-------|-------|
| 90–100 | A | Ship-ready |
| 80–89 | B | Minor fixes needed |
| 70–79 | C | Needs work |
| 60–69 | D | Significant gaps |
| <60 | F | Not ready |

### Report Format

Append the score to the standard verification report:

```
📊 Documentation Quality Score: 74/100 (C — Needs work)

Breakdown:
  Completeness:   22/30  (-5 SECURITY.md missing, -3 ROADMAP.md missing)
  Structure:      20/20  ✓
  Freshness:      12/15  (-3 docs/guides/deployment.md stale)
  Link Health:    15/20  (-5 README.md:89 broken internal link)
  Evidence:        5/15  (-5 feature coverage 62%, -5 "AI-powered" claim without code evidence)

To reach grade B (80+): Fix the broken link (+5) and add SECURITY.md (+5).
```

Always include the actionable "To reach next grade" suggestion showing the 1–2 highest-impact fixes.

### CI Integration

When run with `ci` argument, export the score for pipeline use:

```bash
# GitHub Actions
echo "PITCHDOCS_SCORE=74" >> "$GITHUB_OUTPUT"
echo "PITCHDOCS_GRADE=C" >> "$GITHUB_OUTPUT"

# GitLab CI — write to dotenv artifact instead
echo "PITCHDOCS_SCORE=74" >> metrics.env
echo "PITCHDOCS_GRADE=C" >> metrics.env
```

Accept `--min-score N` to fail the CI job if the score falls below a threshold:

```
/docs-verify ci --min-score 70
```

### 8. Guide Frontmatter Validation

Verify that documentation files in `docs/` have valid YAML frontmatter following the standard defined in the `user-guides` skill.

```bash
# Check for frontmatter presence in all guide files
for f in docs/guides/*.md docs/tutorials/*.md docs/reference/*.md docs/explanation/*.md; do
  [ -f "$f" ] || continue
  head -1 "$f" | grep -q "^---" && echo "✓ $f — has frontmatter" || echo "✗ $f — missing frontmatter"
done
```

For each file with frontmatter, validate:
- **Required fields**: `title`, `description`, `type` must be present
- **Type value**: must be one of `tutorial`, `how-to`, `reference`, `explanation`
- **Title matches H1**: the `title` field should match the first H1 heading in the document
- **Related paths exist**: each path in `related:` must point to a file that exists on disk (relative to `docs/`)

Report format:
```
Guide Frontmatter:
  ✓ docs/guides/getting-started.md — valid (how-to, 8 fields)
  ⚠ docs/guides/workflows.md — missing optional: difficulty, time_to_complete
  ✗ docs/guides/old-guide.md — missing required: type
  ✗ docs/guides/broken.md — related path not found: guides/nonexistent.md
```

**Scoring**: Deduct -2 per guide missing required frontmatter fields under the Structure dimension.

### 9. Token Audit

Estimate token cost for all skill files in `.claude/skills/` using `wc -w` × 1.3. Flag skills over 3,000 tokens (reference) or 5,000 tokens (combined). Full audit script and thresholds in `SKILL-extended.md`.

### 10. Security Scan

Scan generated documentation for content that should never appear in public repos. AI-generated docs can accidentally surface internal paths, credentials, or proprietary configuration.

```bash
# Scan all docs for common credential patterns
grep -rn -E "(api[_-]?key|secret[_-]?key|password|token|bearer|private[_-]?key)" \
  README.md CONTRIBUTING.md CHANGELOG.md docs/ AGENTS.md CLAUDE.md \
  --include="*.md" -i 2>/dev/null
```

For each match, classify as:
- **Placeholder** (e.g., `YOUR_API_KEY`, `<your-token>`) — acceptable
- **Env var reference** (e.g., `$API_KEY`, `process.env.SECRET`) — acceptable
- **Real credential value** — block immediately, do not write to file, inform user

Additional checks:
- **Internal paths** — absolute paths like `/Users/`, `/home/`, `C:\Users\` suggest a dev machine path leaked in
- **Internal hostnames** — IP addresses like `192.168.`, `10.0.`, `172.16.`, `localhost:PORT` outside a code example context
- **Package names that don't exist** — if the README references a package name, verify it exists on the relevant registry to avoid dependency confusion vectors

Report format:
```
Security Scan:
  ✓ No credential patterns detected
  ⚠ README.md:45 — internal path: /Users/developer/projects/... (likely leaked from codebase scan)
  ✗ CLAUDE.md:12 — credential pattern: "token: ghp_abc123..." — review immediately
```

### 11. AI Context Health

Score the signal-to-noise ratio and freshness of AI context files (CLAUDE.md, AGENTS.md, .cursorrules, copilot-instructions.md, .windsurfrules, .clinerules, GEMINI.md). Research shows overstuffed context files reduce AI task success (ETH Zurich, 2026).

**Checks:**

1. **Line count** — context files over budget consume tokens without adding value:

```bash
# Check line counts against budgets
for f in CLAUDE.md AGENTS.md .cursorrules .github/copilot-instructions.md .windsurfrules .clinerules GEMINI.md; do
  [ -f "$f" ] && echo "$f: $(wc -l < "$f") lines"
done
```

| File | Warning | Deduction |
|------|---------|-----------|
| CLAUDE.md | >80 lines | -2 warning, -5 if >120 |
| AGENTS.md | >120 lines | -2 warning, -5 if >160 |
| Other context files | >60 lines | -1 warning, -3 if >100 |

2. **Discoverable content** — directory listings, file trees, and dependency lists waste tokens because agents discover these on their own:

```bash
# Grep for file tree characters and common discoverable patterns
grep -c -E '(├──|└──|│   |src/.*—|tests/.*—)' CLAUDE.md AGENTS.md 2>/dev/null
```

Deduct -1 per instance of discoverable content (max -5). Flag with specific line numbers.

3. **Stale paths** — every backtick-quoted path in a context file must exist on disk:

```bash
# Extract backtick-quoted paths and verify
grep -oE '`[^`]*\.[a-z]+`' CLAUDE.md AGENTS.md 2>/dev/null | tr -d '`' | while read -r p; do
  [ -f "$p" ] || echo "STALE: $p"
done
```

Deduct -2 per stale path (max -10).

4. **Cross-file consistency** — key commands (test, build, deploy) must match across all context files:

Compare command strings extracted from each context file. Deduct -3 if test/build/deploy commands differ between CLAUDE.md and AGENTS.md.

5. **MEMORY.md drift** — if a MEMORY.md exists for this project, check whether it contains conventions not yet promoted to CLAUDE.md:

```bash
# Locate project MEMORY.md
find ~/.claude -name "MEMORY.md" -path "*$(basename $(pwd))*" 2>/dev/null
```

Deduct -2 if MEMORY.md contains convention-like patterns (lines starting with "Always", "Never", "Use") that don't appear in CLAUDE.md.

Report format:
```
AI Context Health:
  ✓ CLAUDE.md — 62 lines (within 80-line budget)
  ⚠ AGENTS.md — 145 lines (over 120-line budget, -2)
  ✗ CLAUDE.md:34 — stale path: `src/old-module.ts` not found (-2)
  ⚠ CLAUDE.md:12,18 — discoverable content: file tree listings (-2)
  ⚠ MEMORY.md — 2 conventions not yet promoted to CLAUDE.md (-2)
  ✓ Cross-file consistency — commands match across all context files
```

**Scoring**: Deductions apply to the Completeness dimension (context files are part of a complete, well-maintained documentation set).

## CI Integration

When run with `ci` argument, output machine-readable `ERROR:`/`WARN:` lines with file:line format and exit code 1 on errors. Supports `--min-score N` threshold. Full CI output format and GitHub Actions workflow template in `SKILL-extended.md`.

## Anti-Patterns

- **Don't ignore warnings** — a broken link today becomes a confused user tomorrow
- **Don't run external link checks on every commit** — run them on PRs and weekly schedules to avoid rate limiting
- **Don't fix docs in a separate PR from code changes** — docs updates should accompany the code that changes behaviour
- **Don't suppress freshness warnings without reviewing** — stale docs erode trust faster than missing docs
