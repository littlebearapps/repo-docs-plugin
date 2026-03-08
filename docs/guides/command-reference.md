---
title: "Command Reference"
description: "All 13 PitchDocs commands with arguments, generated files, and examples."
type: reference
last_verified: "1.14.0"
related:
  - guides/getting-started.md
  - guides/workflows.md
order: 3
---

# Command Reference

> **Summary**: All 13 PitchDocs commands with arguments, generated files, and examples.

**Note:** When installed as a plugin, all commands use the `pitchdocs:` prefix (e.g., `/pitchdocs:readme`). The short form `/readme` only works inside the pitchdocs source directory.

## Using commands in other AI tools

Slash commands are a Claude Code / OpenCode feature. If you're using Codex CLI, Cursor, Windsurf, Cline, Gemini CLI, Aider, or Goose, invoke commands as natural-language prompts that reference the underlying skill:

```
Using the public-readme skill from PitchDocs, generate a README for this project
```

Each command maps to a skill file in `.claude/skills/`. The mapping:

| Command | Skill file |
|---------|-----------|
| `/pitchdocs:readme` | `.claude/skills/public-readme/SKILL.md` |
| `/pitchdocs:features` | `.claude/skills/feature-benefits/SKILL.md` |
| `/pitchdocs:docs-audit` | `.claude/skills/pitchdocs-suite/SKILL.md` |
| `/pitchdocs:docs-verify` | `.claude/skills/docs-verify/SKILL.md` |
| `/pitchdocs:changelog` | `.claude/skills/changelog/SKILL.md` |
| `/pitchdocs:roadmap` | `.claude/skills/roadmap/SKILL.md` |
| `/pitchdocs:user-guide` | `.claude/skills/user-guides/SKILL.md` |
| `/pitchdocs:llms-txt` | `.claude/skills/llms-txt/SKILL.md` |
| `/pitchdocs:ai-context` | `.claude/skills/ai-context/SKILL.md` |
| `/pitchdocs:doc-refresh` | `.claude/skills/doc-refresh/SKILL.md` |
| `/pitchdocs:launch` | `.claude/skills/launch-artifacts/SKILL.md` |
| `/pitchdocs:platform` | `.claude/skills/platform-profiles/SKILL.md` |
| `/pitchdocs:context-guard` | `.claude/skills/context-guard/SKILL.md` (Claude Code only) |

See the [Other AI Tools guide](other-ai-tools.md) for full per-tool setup instructions.

---

## `/pitchdocs:readme`

Generate or update a marketing-friendly README.md.

| Detail | Value |
|--------|-------|
| Arguments | `[project-path or description of focus]` |
| Generates | `README.md` |
| Cross-tool | Yes |

**Examples:**
```
/pitchdocs:readme                              # Generate for current project
/pitchdocs:readme packages/api                 # Generate for a specific package
/pitchdocs:readme focus on the comparison table # Steer output to a specific section
```

If a README.md already exists, PitchDocs reads it first and improves it rather than replacing from scratch.

---

## `/pitchdocs:features`

Extract features from code and translate to benefits.

| Detail | Value |
|--------|-------|
| Arguments | `[project-path]`, `table`, `bullets`, `benefits`, `audit` |
| Generates | Output to chat only (no files written) |
| Cross-tool | Yes |

**Examples:**
```
/pitchdocs:features                # Full inventory (Hero / Core / Supporting tiers)
/pitchdocs:features table          # Markdown table format
/pitchdocs:features bullets        # Emoji+bold+em-dash bullet format
/pitchdocs:features benefits       # User benefits for "Why?" section (auto-scan or conversational)
/pitchdocs:features audit          # Compare extracted vs documented features
```

---

## `/pitchdocs:docs-audit`

Audit documentation completeness against a 20+ file checklist.

| Detail | Value |
|--------|-------|
| Arguments | `[project-path]`, `fix` |
| Generates | Report to chat; `fix` auto-generates missing files |
| Cross-tool | Yes |

**Examples:**
```
/pitchdocs:docs-audit              # Report what's missing
/pitchdocs:docs-audit fix          # Auto-generate all missing docs
/pitchdocs:docs-audit packages/ui  # Audit a specific directory
```

Checks across 3 priority tiers: Tier 1 (README, LICENSE, CONTRIBUTING), Tier 2 (CHANGELOG, SECURITY, CODE_OF_CONDUCT), and Tier 3 (llms.txt, AGENTS.md, templates).

---

## `/pitchdocs:docs-verify`

Verify documentation quality, links, freshness, and consistency.

| Detail | Value |
|--------|-------|
| Arguments | `links`, `freshness`, `ci`, `score`, `--min-score N` |
| Generates | Report to chat (read-only, no files modified) |
| Cross-tool | Yes |

**Examples:**
```
/pitchdocs:docs-verify             # Run all 11 checks
/pitchdocs:docs-verify links       # Link validation only
/pitchdocs:docs-verify score       # Quality score only (0–100)
/pitchdocs:docs-verify ci          # CI-friendly format (exit codes)
/pitchdocs:docs-verify ci --min-score 70  # Fail if score below 70
```

Runs 11 checks: markdown lint, link validation, llms.txt sync, image validation, freshness, feature coverage, badge URLs, guide frontmatter, token audit, security scan, and AI context health.

---

## `/pitchdocs:changelog`

Generate CHANGELOG.md from git history using conventional commits.

| Detail | Value |
|--------|-------|
| Arguments | `[version]`, `full` |
| Generates | `CHANGELOG.md` |
| Cross-tool | Yes |

**Examples:**
```
/pitchdocs:changelog               # Update [Unreleased] section only
/pitchdocs:changelog v1.5.0        # Generate entry for a specific version
/pitchdocs:changelog full          # Regenerate entire changelog from all tags
```

**Note:** CHANGELOG.md has medium content filter risk. PitchDocs uses chunked writing automatically.

---

## `/pitchdocs:roadmap`

Generate ROADMAP.md from GitHub milestones and issues.

| Detail | Value |
|--------|-------|
| Arguments | `[milestone name]`, `full` |
| Generates | `ROADMAP.md` |
| Cross-tool | Yes (GitHub MCP enhances results) |

**Examples:**
```
/pitchdocs:roadmap                 # Generate from all milestones and issues
/pitchdocs:roadmap "v2.0"          # Focus on a specific milestone
/pitchdocs:roadmap full            # Regenerate from scratch
```

Uses GitHub milestones, issues labelled `enhancement`/`feature`, and git tags for completed versions.

---

## `/pitchdocs:user-guide`

Generate task-oriented user guides in `docs/guides/`.

| Detail | Value |
|--------|-------|
| Arguments | `[topic]`, `all`, `hub` |
| Generates | `docs/guides/*.md`, `docs/README.md` hub |
| Cross-tool | Yes |

**Examples:**
```
/pitchdocs:user-guide              # Auto-detect and generate most-needed guides
/pitchdocs:user-guide deployment   # Generate a specific guide
/pitchdocs:user-guide all          # Full guide suite
/pitchdocs:user-guide hub          # Hub page only (docs/README.md)
```

---

## `/pitchdocs:llms-txt`

Generate llms.txt and llms-full.txt for AI discoverability.

| Detail | Value |
|--------|-------|
| Arguments | `[path]`, `full` |
| Generates | `llms.txt`; `full` also generates `llms-full.txt` |
| Cross-tool | Yes |

**Examples:**
```
/pitchdocs:llms-txt                # Generate llms.txt only
/pitchdocs:llms-txt full           # Generate both llms.txt and llms-full.txt
```

Follows the [llmstxt.org](https://llmstxt.org/) specification.

---

## `/pitchdocs:ai-context`

Generate lean AI IDE context files using the Signal Gate principle — only what agents cannot discover on their own.

| Detail | Value |
|--------|-------|
| Arguments | **Generate:** `claude`, `agents`, `cursor`, `copilot`, `windsurf`, `cline`, `gemini`, `all` — **Lifecycle:** `init`, `update`, `promote`, `audit` |
| Generates | Up to 7 files (AGENTS.md, CLAUDE.md, .cursorrules, copilot-instructions.md, .windsurfrules, .clinerules, GEMINI.md) |
| Cross-tool | Yes |

**Examples:**
```
/pitchdocs:ai-context              # Generate all 7 context files
/pitchdocs:ai-context agents       # AGENTS.md only
/pitchdocs:ai-context cursor       # .cursorrules only
/pitchdocs:ai-context init         # Bootstrap: generate missing files, offer hooks, run audit
/pitchdocs:ai-context update       # Patch only what drifted (preserves human edits)
/pitchdocs:ai-context promote      # Scan MEMORY.md for patterns to promote to CLAUDE.md
/pitchdocs:ai-context audit        # Check for drift, stale paths, and Context Guard status
```

---

## `/pitchdocs:doc-refresh`

Refresh documentation after version bumps, feature additions, or periodic maintenance.

| Detail | Value |
|--------|-------|
| Arguments | `[version]`, `[range]`, `plan`, `changelog`, `readme`, `guides`, `context`, `release-notes`, `full` |
| Generates | Updates affected docs selectively |
| Cross-tool | Yes |

**Examples:**
```
/pitchdocs:doc-refresh             # Auto-detect latest tag, refresh what changed
/pitchdocs:doc-refresh v1.7.0      # Refresh for a specific version
/pitchdocs:doc-refresh v1.5.0..v1.7.0  # Refresh for a version range
/pitchdocs:doc-refresh plan        # Dry run — report what needs refreshing
/pitchdocs:doc-refresh changelog   # Only refresh CHANGELOG.md
/pitchdocs:doc-refresh full        # Refresh everything regardless
```

---

## `/pitchdocs:launch`

Generate platform-specific launch and promotion artifacts.

| Detail | Value |
|--------|-------|
| Arguments | `devto`, `hn`, `reddit`, `social`, `awesome` |
| Generates | Files in `docs/launch/` (review before posting) |
| Cross-tool | Yes |

**Examples:**
```
/pitchdocs:launch                  # Generate all launch artifacts
/pitchdocs:launch devto            # Dev.to article only
/pitchdocs:launch hn               # Hacker News "Show HN" post
/pitchdocs:launch reddit           # Reddit post templates
/pitchdocs:launch social           # Twitter/X thread + social preview guide
/pitchdocs:launch awesome          # Awesome list submission PR template
```

All artifacts are written to `docs/launch/` for human review — they are starting points, not copy-paste-ready.

---

## `/pitchdocs:platform`

Detect hosting platform and report PitchDocs feature support.

| Detail | Value |
|--------|-------|
| Arguments | `[github\|gitlab\|bitbucket]` or auto-detect |
| Generates | Report to chat (read-only, no files modified) |
| Cross-tool | Yes |

**Examples:**
```
/pitchdocs:platform                # Auto-detect from git remote and CI config
/pitchdocs:platform gitlab         # Force GitLab platform profile
/pitchdocs:platform bitbucket      # Force Bitbucket platform profile
```

Reports template paths, badge URL patterns, CI/CD equivalents, and rendering limitations for the detected platform.

---

## `/pitchdocs:context-guard`

Install, uninstall, or check Context Guard hooks. **Claude Code only.**

| Detail | Value |
|--------|-------|
| Arguments | `install`, `uninstall`, `status` |
| Generates | `.claude/hooks/*.sh`, entries in `.claude/settings.json` |
| Cross-tool | **No — Claude Code only** |

**Examples:**
```
/pitchdocs:context-guard install   # Install 3 hooks into the current project
/pitchdocs:context-guard status    # Check installation state and run drift check
/pitchdocs:context-guard uninstall # Remove hooks (preserves other hooks)
```

Installs 3 hooks: drift detection (warns after commits), structural change reminders (nudges on config changes), and content filter guard (prevents HTTP 400 on high-risk files).

---

**See also:** [Workflows](workflows.md) for step-by-step recipes, [Troubleshooting](troubleshooting.md) for common issues, [Getting Started](getting-started.md) for installation.
