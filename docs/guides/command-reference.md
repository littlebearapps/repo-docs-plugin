# Command Reference

All 12 PitchDocs commands with arguments, generated files, and examples.

---

## `/readme`

Generate or update a marketing-friendly README.md.

| Detail | Value |
|--------|-------|
| Arguments | `[project-path or description of focus]` |
| Generates | `README.md` |
| Cross-tool | Yes |

**Examples:**
```
/readme                              # Generate for current project
/readme packages/api                 # Generate for a specific package
/readme focus on the comparison table # Steer output to a specific section
```

If a README.md already exists, PitchDocs reads it first and improves it rather than replacing from scratch.

---

## `/features`

Extract features from code and translate to benefits.

| Detail | Value |
|--------|-------|
| Arguments | `[project-path]`, `table`, `bullets`, `audit` |
| Generates | Output to chat only (no files written) |
| Cross-tool | Yes |

**Examples:**
```
/features                # Full inventory (Hero / Core / Supporting tiers)
/features table          # Markdown table format
/features bullets        # Emoji+bold+em-dash bullet format
/features audit          # Compare extracted vs documented features
```

---

## `/docs-audit`

Audit documentation completeness against a 20+ file checklist.

| Detail | Value |
|--------|-------|
| Arguments | `[project-path]`, `fix` |
| Generates | Report to chat; `fix` auto-generates missing files |
| Cross-tool | Yes |

**Examples:**
```
/docs-audit              # Report what's missing
/docs-audit fix          # Auto-generate all missing docs
/docs-audit packages/ui  # Audit a specific directory
```

Checks across 3 priority tiers: Tier 1 (README, LICENSE, CONTRIBUTING), Tier 2 (CHANGELOG, SECURITY, CODE_OF_CONDUCT), and Tier 3 (llms.txt, AGENTS.md, templates).

---

## `/docs-verify`

Verify documentation quality, links, freshness, and consistency.

| Detail | Value |
|--------|-------|
| Arguments | `links`, `freshness`, `ci`, `score`, `--min-score N` |
| Generates | Report to chat (read-only, no files modified) |
| Cross-tool | Yes |

**Examples:**
```
/docs-verify             # Run all 9 checks
/docs-verify links       # Link validation only
/docs-verify score       # Quality score only (0–100)
/docs-verify ci          # CI-friendly format (exit codes)
/docs-verify ci --min-score 70  # Fail if score below 70
```

Runs 9 checks: markdown lint, link validation, llms.txt sync, image validation, freshness, feature coverage, badge URLs, token audit, and security scan.

---

## `/changelog`

Generate CHANGELOG.md from git history using conventional commits.

| Detail | Value |
|--------|-------|
| Arguments | `[version]`, `full` |
| Generates | `CHANGELOG.md` |
| Cross-tool | Yes |

**Examples:**
```
/changelog               # Update [Unreleased] section only
/changelog v1.5.0        # Generate entry for a specific version
/changelog full          # Regenerate entire changelog from all tags
```

**Note:** CHANGELOG.md has medium content filter risk. PitchDocs uses chunked writing automatically.

---

## `/roadmap`

Generate ROADMAP.md from GitHub milestones and issues.

| Detail | Value |
|--------|-------|
| Arguments | `[milestone name]`, `full` |
| Generates | `ROADMAP.md` |
| Cross-tool | Yes (GitHub MCP enhances results) |

**Examples:**
```
/roadmap                 # Generate from all milestones and issues
/roadmap "v2.0"          # Focus on a specific milestone
/roadmap full            # Regenerate from scratch
```

Uses GitHub milestones, issues labelled `enhancement`/`feature`, and git tags for completed versions.

---

## `/user-guide`

Generate task-oriented user guides in `docs/guides/`.

| Detail | Value |
|--------|-------|
| Arguments | `[topic]`, `all`, `hub` |
| Generates | `docs/guides/*.md`, `docs/README.md` hub |
| Cross-tool | Yes |

**Examples:**
```
/user-guide              # Auto-detect and generate most-needed guides
/user-guide deployment   # Generate a specific guide
/user-guide all          # Full guide suite
/user-guide hub          # Hub page only (docs/README.md)
```

---

## `/llms-txt`

Generate llms.txt and llms-full.txt for AI discoverability.

| Detail | Value |
|--------|-------|
| Arguments | `[path]`, `full` |
| Generates | `llms.txt`; `full` also generates `llms-full.txt` |
| Cross-tool | Yes |

**Examples:**
```
/llms-txt                # Generate llms.txt only
/llms-txt full           # Generate both llms.txt and llms-full.txt
```

Follows the [llmstxt.org](https://llmstxt.org/) specification.

---

## `/ai-context`

Generate AI IDE context files for 7 tools.

| Detail | Value |
|--------|-------|
| Arguments | `claude`, `agents`, `cursor`, `copilot`, `windsurf`, `cline`, `gemini`, `all`, `audit` |
| Generates | Up to 7 files (AGENTS.md, CLAUDE.md, .cursorrules, copilot-instructions.md, .windsurfrules, .clinerules, GEMINI.md) |
| Cross-tool | Yes |

**Examples:**
```
/ai-context              # Generate all 7 context files
/ai-context agents       # AGENTS.md only
/ai-context cursor       # .cursorrules only
/ai-context audit        # Check existing files for drift (no writes)
```

---

## `/doc-refresh`

Refresh documentation after version bumps, feature additions, or periodic maintenance.

| Detail | Value |
|--------|-------|
| Arguments | `[version]`, `[range]`, `plan`, `changelog`, `readme`, `guides`, `context`, `release-notes`, `full` |
| Generates | Updates affected docs selectively |
| Cross-tool | Yes |

**Examples:**
```
/doc-refresh             # Auto-detect latest tag, refresh what changed
/doc-refresh v1.7.0      # Refresh for a specific version
/doc-refresh v1.5.0..v1.7.0  # Refresh for a version range
/doc-refresh plan        # Dry run — report what needs refreshing
/doc-refresh changelog   # Only refresh CHANGELOG.md
/doc-refresh full        # Refresh everything regardless
```

---

## `/launch`

Generate platform-specific launch and promotion artifacts.

| Detail | Value |
|--------|-------|
| Arguments | `devto`, `hn`, `reddit`, `social`, `awesome` |
| Generates | Files in `docs/launch/` (review before posting) |
| Cross-tool | Yes |

**Examples:**
```
/launch                  # Generate all launch artifacts
/launch devto            # Dev.to article only
/launch hn               # Hacker News "Show HN" post
/launch reddit           # Reddit post templates
/launch social           # Twitter/X thread + social preview guide
/launch awesome          # Awesome list submission PR template
```

All artifacts are written to `docs/launch/` for human review — they are starting points, not copy-paste-ready.

---

## `/context-guard`

Install, uninstall, or check Context Guard hooks. **Claude Code only.**

| Detail | Value |
|--------|-------|
| Arguments | `install`, `uninstall`, `status` |
| Generates | `.claude/hooks/*.sh`, entries in `.claude/settings.json` |
| Cross-tool | **No — Claude Code only** |

**Examples:**
```
/context-guard install   # Install 3 hooks into the current project
/context-guard status    # Check installation state and run drift check
/context-guard uninstall # Remove hooks (preserves other hooks)
```

Installs 3 hooks: drift detection (warns after commits), structural change reminders (nudges on config changes), and content filter guard (prevents HTTP 400 on high-risk files).

---

**See also:** [Workflows](workflows.md) for step-by-step recipes, [Troubleshooting](troubleshooting.md) for common issues, [Getting Started](getting-started.md) for installation.
