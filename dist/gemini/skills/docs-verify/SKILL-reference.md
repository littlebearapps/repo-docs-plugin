# Documentation Verifier — Reference Tables

Reference data for the `docs-verify` skill. Load this file when you need the full scoring rubric, grade bands, freshness thresholds, or image URL validation patterns.

## Scoring Dimensions

| Dimension | Max | Deductions |
|-----------|-----|-----------|
| Completeness | 25 | -5 per missing Tier 1 file (README, LICENSE, CONTRIBUTING, issue templates, PR template), -3 per missing Tier 2 file (CHANGELOG, SECURITY, CODE_OF_CONDUCT, llms.txt, AGENTS.md), -1 per missing Tier 3 file (ROADMAP, CITATION.cff, .cursorrules) |
| Structure | 20 | -5 if heading hierarchy skipped anywhere, -5 if hero missing required parts (one-liner + explanatory sentence + badges), -5 if no 4-question framework evident, -5 if single H1 rule violated |
| Freshness | 15 | -5 per stale file (>180 days since last update), -3 per warning file (>90 days) |
| Link Health | 15 | -5 per broken internal link (file not found), -3 per broken external link (404/5xx), -2 per broken anchor |
| Evidence | 15 | -5 if feature coverage below 70%, -5 per over-documented feature (claims without code evidence), -3 per missing benefit translation in features section |
| GEO & Citation Readiness | 10 | -3 if README missing crisp definition in first paragraph (not standalone-extractable), -2 if no comparison table present (for projects with known alternatives), -2 if no concrete statistics with evidence pointers in features section, -2 if H2 sections lack citation-ready opening capsules (40–60 word standalone passages), -1 if headings use generic names ("Config" instead of "TypeScript Configuration") |

## Grade Bands

| Score | Grade | Label |
|-------|-------|-------|
| 90–100 | A | Ship-ready |
| 80–89 | B | Minor fixes needed |
| 70–79 | C | Needs work |
| 60–69 | D | Significant gaps |
| <60 | F | Not ready |

## Freshness Thresholds

Staleness thresholds used in Check 5 (configurable per project):

| File | Warning | Stale |
|------|---------|-------|
| README.md | 90 days | 180 days |
| CHANGELOG.md | 30 days (if releases exist) | 90 days |
| CONTRIBUTING.md | 180 days | 365 days |
| docs/guides/*.md | 90 days | 180 days |
| SECURITY.md | 180 days | 365 days |

## Image URL Validation Patterns

Platform-specific absolute URL patterns for registry-published packages (Check 4). Images using relative paths break when rendered on npm, PyPI, or other registries.

| Platform | Absolute URL Pattern |
|----------|---------------------|
| GitHub | `raw.githubusercontent.com/{owner}/{repo}/{branch}/...` |
| GitLab | `gitlab.com/{org}/{repo}/-/raw/{branch}/...` |
| Bitbucket | `bitbucket.org/{org}/{repo}/raw/{branch}/...` |

Load `platform-profiles` for the full mapping including CDN alternatives and dark-mode image variants.

## Report Format Examples

All checks use a consistent `✓`/`⚠`/`✗` format. Examples for each check:

### Markdown Lint
```
Markdown Lint:
  ✓ README.md — 0 issues
  ⚠ docs/guides/configuration.md:45 — heading level skipped (H2 → H4)
  ⚠ CONTRIBUTING.md:23 — trailing whitespace
```

### Link Validation
```
Link Validation:
  Checked: 45 links (32 internal, 13 external)
  ✓ 42 valid
  ✗ README.md:89 — docs/guides/migration.md (file not found)
  ✗ CONTRIBUTING.md:34 — #setup-instructions (anchor not found, did you mean #development-setup?)
  ⚠ README.md:12 — https://example.com/old-docs (301 redirect → https://example.com/docs)
```

### llms.txt Sync
```
llms.txt Sync:
  ✓ 12/12 referenced files exist
  ⚠ docs/guides/deployment.md not listed in llms.txt (orphaned doc)
  ⚠ llms-full.txt is 14 days older than README.md — may need regeneration
```

### Image Validation
```
Image Validation:
  ✓ docs/images/demo.gif — exists, alt text: "Quick start demo", 2.3MB
  ⚠ docs/images/architecture.svg — empty alt text
  ✗ README.md:15 — assets/screenshot.png (file not found)
  ⚠ README.md:15 — relative image path, will break on npm (use absolute URL)
```

### Freshness Check
```
Freshness Check:
  ✓ README.md — updated 12 days ago
  ⚠ docs/guides/deployment.md — last updated 95 days ago (threshold: 90 days)
  ✗ CONTRIBUTING.md — last updated 14 months ago (stale)
  · CHANGELOG.md — 2 releases since last update (v1.3.0, v1.4.0)
```

### Feature Coverage
```
Feature Coverage: 8 documented / 10 detected (80%)
  Missing from README:
    - WebSocket support — found in src/ws.ts
    - Rate limiting — found in src/middleware/ratelimit.ts
  Over-documented:
    - "AI-powered suggestions" — no code evidence found
```

### Badge Validation
```
Badge Validation:
  ✓ build status — 200 OK (passing)
  ✓ npm version — 200 OK (1.4.1)
  ✗ coverage — 200 OK but shows "unknown" (codecov may not be configured)
  ⚠ downloads — 301 redirect (badge URL format may be outdated)
```

### Quality Score
```
📊 Documentation Quality Score: 72/100 (C — Needs work)

Breakdown:
  Completeness:          20/25  (-5 SECURITY.md missing)
  Structure:             20/20  ✓
  Freshness:             12/15  (-3 docs/guides/deployment.md stale)
  Link Health:           12/15  (-3 README.md:89 broken external link)
  Evidence:              5/15   (-5 feature coverage 62%, -5 "AI-powered" claim without code evidence)
  GEO & Citation:        3/10   (-3 no crisp definition, -2 no comparison table, -2 no citation capsules)

To reach grade B (80+): Add crisp definition (+3), comparison table (+2), and fix stale guide (+3).
```

### Guide Frontmatter
```
Guide Frontmatter:
  ✓ docs/guides/getting-started.md — valid (how-to, 8 fields)
  ⚠ docs/guides/workflows.md — missing optional: difficulty, time_to_complete
  ✗ docs/guides/old-guide.md — missing required: type
  ✗ docs/guides/broken.md — related path not found: guides/nonexistent.md
```

### Security Scan
```
Security Scan:
  ✓ No credential patterns detected
  ⚠ README.md:45 — internal path: /Users/developer/projects/... (likely leaked from codebase scan)
  ✗ CLAUDE.md:12 — credential pattern: "token: ghp_abc123..." — review immediately
```

### AI Context Health
```
AI Context Health (lightweight):
  ✓ CLAUDE.md — present (12 days old)
  ✓ AGENTS.md — present (12 days old)
  ⚠ .cursorrules — present (95 days old — may be stale)
  · .windsurfrules — not present
  · .clinerules — not present
  ℹ For full context health scoring, install ContextDocs: /plugin install contextdocs@lba-plugins
```

## Bash Snippets

### Find documentation files
```bash
find . -name "*.md" -not -path "./.git/*" -not -path "./node_modules/*" | sort
```

### Extract links from Markdown
```bash
grep -roE '\[([^\]]*)\]\(([^)]+)\)' docs/ README.md CONTRIBUTING.md CHANGELOG.md 2>/dev/null
```

### Extract llms.txt paths
```bash
grep -oE '\./[^ ]+\.md' llms.txt 2>/dev/null | while read -r path; do
  [ -f "$path" ] && echo "✓ $path" || echo "✗ $path (file not found)"
done
```

### Extract image references
```bash
grep -roE '!\[([^\]]*)\]\(([^)]+)\)' docs/ README.md 2>/dev/null
```

### Check freshness via git log
```bash
for f in README.md CONTRIBUTING.md CHANGELOG.md docs/guides/*.md; do
  if [ -f "$f" ]; then
    last_modified=$(git log -1 --format="%ci" -- "$f" 2>/dev/null)
    echo "$f: $last_modified"
  fi
done
```

### Extract badge URLs
```bash
grep -oE 'https://img\.shields\.io/[^)]+' README.md 2>/dev/null
```

### Check guide frontmatter
```bash
for f in docs/guides/*.md docs/tutorials/*.md docs/reference/*.md docs/explanation/*.md; do
  [ -f "$f" ] || continue
  head -1 "$f" | grep -q "^---" && echo "✓ $f — has frontmatter" || echo "✗ $f — missing frontmatter"
done
```

### Scan for credential patterns
```bash
grep -rn -E "(api[_-]?key|secret[_-]?key|password|token|bearer|private[_-]?key)" \
  README.md CONTRIBUTING.md CHANGELOG.md docs/ AGENTS.md CLAUDE.md \
  --include="*.md" -i 2>/dev/null
```

### Check AI context file ages
```bash
for f in CLAUDE.md AGENTS.md .cursorrules .github/copilot-instructions.md .windsurfrules .clinerules GEMINI.md; do
  if [ -f "$f" ]; then
    DAYS_OLD=$(( ($(date +%s) - $(git log -1 --format=%ct -- "$f" 2>/dev/null || echo "0")) / 86400 ))
    echo "$f: exists ($DAYS_OLD days since last update)"
  else
    echo "$f: not present"
  fi
done
```

### CI score export
```bash
# GitHub Actions
echo "PITCHDOCS_SCORE=74" >> "$GITHUB_OUTPUT"
echo "PITCHDOCS_GRADE=C" >> "$GITHUB_OUTPUT"

# GitLab CI — write to dotenv artifact instead
echo "PITCHDOCS_SCORE=74" >> metrics.env
echo "PITCHDOCS_GRADE=C" >> metrics.env
```
