# PitchDocs

Generate high-quality public-facing repository documentation with a marketing edge. PitchDocs is a Claude Code plugin (pure Markdown, zero runtime dependencies) with 15 skills, 4 agents (3 pipeline + 1 per-project), 3 auto-loaded rules (1 global + 2 installed), 2 installable rule templates, 16 slash commands (14 active + 2 stubs), 1 opt-in hook, and 24 eval test cases. This repo also has ContextDocs installed, which adds the `context-updater` agent and `context-quality.md` rule.

## Project Architecture

This is a **100% Markdown-based plugin** — no JavaScript, no Python, no build step. All knowledge lives in structured YAML+Markdown files:

```
.claude-plugin/plugin.json      → Plugin manifest (name, version, keywords)
.claude/skills/*/SKILL.md       → 16 reference knowledge modules (loaded on-demand)
.claude/agents/docs-writer.md   → Orchestration agent (coordinates researcher → write → reviewer pipeline)
.claude/agents/docs-researcher.md → Codebase discovery and feature extraction agent
.claude/agents/docs-reviewer.md → Post-generation quality validation agent
.claude/agents/context-updater.md → AI context file updater agent (from ContextDocs, not PitchDocs)
.claude/agents/docs-freshness.md → Installed freshness checker (auto-loaded locally; source: agents/docs-freshness.md)
.claude/rules/content-filter.md → Content filter quick reference (auto-loaded; Claude Code only)
.claude/rules/context-quality.md → AI context file quality standards (from ContextDocs, auto-loaded; Claude Code only)
.claude/rules/doc-standards.md → Installed quality standards (auto-loaded locally; source: rules/doc-standards.md)
.claude/rules/docs-awareness.md → Installed documentation trigger map (auto-loaded locally; source: rules/docs-awareness.md)
rules/doc-standards.md          → Quality standards (installed per-project by /pitchdocs:activate)
rules/docs-awareness.md         → Documentation trigger map (installed per-project by /pitchdocs:activate)
agents/docs-freshness.md        → Freshness checker agent (installed per-project by /pitchdocs:activate)
commands/*.md                   → 16 slash command definitions (14 active + 2 stubs redirecting to ContextDocs)
hooks/*.sh                      → 1 opt-in hook script (Claude Code only, installed by /pitchdocs:activate install strict)
```

## Conventions

- **Australian English**: realise, colour, behaviour, licence (noun), license (verb)
- **Conventional Commits**: `feat:`, `fix:`, `docs:`, `chore:` — release-please automates versioning
- **Benefit-driven language**: Every feature claim traces to actual code. Pattern: `[Feature] so you can [outcome] — [evidence]`

## Key Files

| File | Purpose |
|------|---------|
| `plugin.json` | Version, description, keywords — update on every release |
| `content-filter.md` | Content filter quick reference rule — risk levels, fetch commands, chunked writing guidance (auto-loaded globally; Claude Code only) |
| `rules/doc-standards.md` | Quality standards template — installed per-project by `/pitchdocs:activate`. Core standards for tone, benefits, badges |
| `rules/docs-awareness.md` | Documentation trigger map template — installed per-project by `/pitchdocs:activate`. Suggests PitchDocs commands at documentation moments |
| `agents/docs-freshness.md` | Freshness checker agent template — installed per-project by `/pitchdocs:activate`. Read-only checks with command suggestions |
| `docs-writer.md` | Orchestrator agent — lightweight inline research for small projects (< 20 files), full sub-agent research for larger projects, conditional reviewer (skipped for new READMEs), content filter mitigations |
| `docs-researcher.md` | Codebase discovery agent — platform detection, feature extraction, security signals, lobby split planning. Only spawned for projects with 20+ files. |
| `docs-reviewer.md` | Quality validation agent — checklist, banned phrases scan, GEO scoring, 6-dimension quality rubric. Skipped for new READMEs; runs for updates or with `--review`. |
| `hooks/*.sh` | Content filter write guard (Claude Code only, installed by `/pitchdocs:activate install strict`) |
| `upstream-versions.json` | Tracks 7 pinned spec versions — checked monthly by GitHub Action |
| `llms.txt` | AI-readable content index — must be updated when files are added/removed |
| `AGENTS.md` | Cross-tool AI context (Codex CLI format) — must stay in sync with skills/commands |
| `docs/faq/index.md` | **Protected** — source for marketing-site FAQPage JSON-LD on `https://littlebearapps.com/help/pitchdocs/`. The site's docs-sync (`scripts/docs-sync.config.ts` in `littlebearapps/littlebearapps.com`) hard-fails if this directory is missing. Keep ≥7 question-shaped H2 headings (`##`); update entries in place — never delete. See [Protected Documentation Files](AGENTS.md#protected-documentation-files) in AGENTS.md. |
| `tests/evaluations.json` | 24 command routing test scenarios — used by skill-creator evals |

## When Modifying This Plugin

1. **Adding a skill**: Create `.claude/skills/<name>/SKILL.md`, add a corresponding command in `commands/<name>.md`, update the features list in `README.md`, skills table in `AGENTS.md`, and `llms.txt`
2. **Adding a command**: Create `commands/<name>.md` with YAML frontmatter, update commands tables in `README.md`, `AGENTS.md`, and `llms.txt`
3. **Changing quality standards**: Edit `rules/doc-standards.md` — this propagates to all projects that have activated PitchDocs
4. **Updating upstream specs**: Edit `upstream-versions.json` and the corresponding skill content
5. **Adding platform support**: Update the `platform-profiles` skill for new platform equivalents. Existing skills reference it via cross-link.
6. **Bumping version**: Handled automatically by release-please from conventional commit messages
7. **Before merging a release PR**: Run activation evals from GitHub Actions (`Actions → Activation Evals → Run workflow`) to confirm skill activation hasn't regressed. Target: 80%+.
8. **Updating `docs/faq/index.md`**: Edit answers in place when content drifts; keep ≥7 question-shaped H2 headings (`##`). **Do not delete or move the file** — the marketing-site sync pipeline hard-fails without it. See [Protected Documentation Files](AGENTS.md#protected-documentation-files).

## Testing & Validation

PitchDocs includes static validation in CI and supports runtime skill evaluation via the [skill-creator](https://github.com/anthropics/claude-plugins-official/tree/main/plugins/skill-creator) plugin.

| Test | What It Checks | How to Run |
|------|---------------|------------|
| Frontmatter validation | YAML metadata in skills, commands, agents | `python tests/validate-frontmatter.py` |
| Token budgets | Skill/rule/agent file sizes within limits | `bash tests/check-token-budgets.sh` |
| llms.txt consistency | All referenced files exist, no orphans | `bash tests/validate-llms-txt.sh` |
| Command routing evals | Skills activate for correct prompts | `tests/evaluations.json` via skill-creator |
| Skill quality benchmarks | Output quality with/without plugin | skill-creator A/B comparison |

Install skill-creator: `/plugin marketplace add anthropics/claude-plugins-official` then `/plugin install skill-creator`

## Per-Project Activation

PitchDocs commands work globally, but advisory features (quality standards, documentation nudges, freshness checking) are opt-in per-project via `/pitchdocs:activate`. This prevents noise in private repos that don't need marketing-grade docs.

| Tier | Command | What's Installed |
|------|---------|-----------------|
| None (default) | Plugin only | Commands available, `content-filter.md` rule auto-loaded |
| Standard | `/pitchdocs:activate install` | + `doc-standards.md` rule, `docs-awareness.md` rule, `docs-freshness.md` agent |
| Strict | `/pitchdocs:activate install strict` | + `content-filter-guard.sh` hook (blocks risky file writes) |

Source templates live in `rules/`, `agents/`, and `hooks/` at the plugin root. The activate command copies them into the project's `.claude/` directory.

## Relationship to ContextDocs

AI context file management (AGENTS.md, CLAUDE.md, .cursorrules, etc.) has moved to [ContextDocs](https://github.com/littlebearapps/contextdocs). PitchDocs retains `/pitchdocs:ai-context` and `/pitchdocs:context-guard` as stub commands that redirect users to install ContextDocs. The `doc-refresh` skill delegates Step 5 to ContextDocs if installed. The `docs-verify` skill uses a lightweight context health check; full scoring requires ContextDocs.

## Promotion

Listing and promotion drafts, status tracking, and submission content live in `docs/promotion/`. This includes awesome list PR content, Reddit post drafts, directory submission templates, and a `STATUS.md` tracking all listings and their current state. Refer to these files when preparing new submissions or checking on existing ones.
