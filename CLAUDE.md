# PitchDocs

Generate high-quality public-facing repository documentation with a marketing edge. PitchDocs is a Claude Code plugin (pure Markdown, zero runtime dependencies) with 16 skills, 3 agents (adaptive researcher → writer → reviewer pipeline), 3 quality rules, 14 slash commands (+2 stubs redirecting to ContextDocs), 1 opt-in hook, and 20 evaluation test cases.

## Project Architecture

This is a **100% Markdown-based plugin** — no JavaScript, no Python, no build step. All knowledge lives in structured YAML+Markdown files:

```
.claude-plugin/plugin.json      → Plugin manifest (name, version, keywords)
.claude/skills/*/SKILL.md       → 16 reference knowledge modules (loaded on-demand)
.claude/agents/docs-writer.md   → Orchestration agent (coordinates researcher → write → reviewer pipeline)
.claude/agents/docs-researcher.md → Codebase discovery and feature extraction agent
.claude/agents/docs-reviewer.md → Post-generation quality validation agent
.claude/rules/doc-standards.md  → Quality standards (auto-loaded every session)
.claude/rules/content-filter.md → Content filter quick reference (auto-loaded; Claude Code only)
.claude/rules/docs-awareness.md → Documentation trigger map (auto-loaded; Claude Code only)
commands/*.md                   → 14 slash command definitions (+2 stubs redirecting to ContextDocs)
hooks/*.sh                      → 1 opt-in hook script (Claude Code only)
```

## Conventions

- **Australian English**: realise, colour, behaviour, licence (noun), license (verb)
- **Conventional Commits**: `feat:`, `fix:`, `docs:`, `chore:` — release-please automates versioning
- **Benefit-driven language**: Every feature claim traces to actual code. Pattern: `[Feature] so you can [outcome] — [evidence]`

## Key Files

| File | Purpose |
|------|---------|
| `plugin.json` | Version, description, keywords — update on every release |
| `doc-standards.md` | Quality rule auto-loaded in every session — core standards for tone, benefits, badges. Extended references in `visual-standards`, `geo-optimisation`, and `skill-authoring` skills |
| `content-filter.md` | Content filter quick reference rule — risk levels, fetch commands, chunked writing guidance (auto-loaded; Claude Code only) |
| `docs-awareness.md` | Documentation trigger map rule — suggests PitchDocs commands when documentation-relevant work is detected (auto-loaded; Claude Code only) |
| `docs-writer.md` | Orchestrator agent — lightweight inline research for small projects (< 20 files), full sub-agent research for larger projects, conditional reviewer (skipped for new READMEs), content filter mitigations |
| `docs-researcher.md` | Codebase discovery agent — platform detection, feature extraction, security signals, lobby split planning. Only spawned for projects with 20+ files. |
| `docs-reviewer.md` | Quality validation agent — checklist, banned phrases scan, GEO scoring, 6-dimension quality rubric. Skipped for new READMEs; runs for updates or with `--review`. |
| `hooks/*.sh` | Content filter write guard (Claude Code only, opt-in) |
| `upstream-versions.json` | Tracks 7 pinned spec versions — checked monthly by GitHub Action |
| `llms.txt` | AI-readable content index — must be updated when files are added/removed |
| `AGENTS.md` | Cross-tool AI context (Codex CLI format) — must stay in sync with skills/commands |
| `tests/evaluations.json` | 20 command routing test scenarios — used by skill-creator evals |

## When Modifying This Plugin

1. **Adding a skill**: Create `.claude/skills/<name>/SKILL.md`, add a corresponding command in `commands/<name>.md`, update the features list in `README.md`, skills table in `AGENTS.md`, and `llms.txt`
2. **Adding a command**: Create `commands/<name>.md` with YAML frontmatter, update commands tables in `README.md`, `AGENTS.md`, and `llms.txt`
3. **Changing quality standards**: Edit `.claude/rules/doc-standards.md` — this propagates to all generated docs automatically
4. **Updating upstream specs**: Edit `upstream-versions.json` and the corresponding skill content
5. **Adding platform support**: Update the `platform-profiles` skill for new platform equivalents. Existing skills reference it via cross-link.
6. **Bumping version**: Handled automatically by release-please from conventional commit messages

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

## Relationship to ContextDocs

AI context file management (AGENTS.md, CLAUDE.md, .cursorrules, etc.) has moved to [ContextDocs](https://github.com/littlebearapps/contextdocs). PitchDocs retains `/pitchdocs:ai-context` and `/pitchdocs:context-guard` as stub commands that redirect users to install ContextDocs. The `doc-refresh` skill delegates Step 5 to ContextDocs if installed. The `docs-verify` skill uses a lightweight context health check; full scoring requires ContextDocs.

## Promotion

Listing and promotion drafts, status tracking, and submission content live in `docs/promotion/`. This includes awesome list PR content, Reddit post drafts, directory submission templates, and a `STATUS.md` tracking all listings and their current state. Refer to these files when preparing new submissions or checking on existing ones.
