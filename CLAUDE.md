# PitchDocs

Generate high-quality public-facing repository documentation with a marketing edge. PitchDocs is a Claude Code plugin (pure Markdown, zero runtime dependencies) with 18 skills, 3 agents (researcher → writer → reviewer pipeline), 4 quality rules, 15 slash commands, and 5 opt-in hooks.

## Project Architecture

This is a **100% Markdown-based plugin** — no JavaScript, no Python, no build step. All knowledge lives in structured YAML+Markdown files:

```
.claude-plugin/plugin.json      → Plugin manifest (name, version, keywords)
.claude/skills/*/SKILL.md       → 18 reference knowledge modules (loaded on-demand)
.claude/agents/docs-writer.md   → Orchestration agent (coordinates researcher → write → reviewer pipeline)
.claude/agents/docs-researcher.md → Codebase discovery and feature extraction agent
.claude/agents/docs-reviewer.md → Post-generation quality validation agent
.claude/rules/doc-standards.md  → Quality standards (auto-loaded every session)
.claude/rules/context-quality.md → AI context file quality standards (auto-loaded; Claude Code only)
.claude/rules/content-filter.md → Content filter quick reference (auto-loaded; Claude Code only)
.claude/rules/docs-awareness.md → Documentation trigger map (auto-loaded; Claude Code only)
commands/*.md                   → 15 slash command definitions
hooks/*.sh                      → 5 opt-in hook scripts (Claude Code only)
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
| `context-quality.md` | AI context file quality rule — cross-file consistency, path verification, sync points (Claude Code only) |
| `content-filter.md` | Content filter quick reference rule — risk levels, fetch commands, chunked writing guidance (auto-loaded; Claude Code only) |
| `docs-awareness.md` | Documentation trigger map rule — suggests PitchDocs commands when documentation-relevant work is detected (auto-loaded; Claude Code only) |
| `docs-writer.md` | Orchestrator agent — coordinates docs-researcher → write → docs-reviewer pipeline with content filter mitigations |
| `docs-researcher.md` | Codebase discovery agent — platform detection, feature extraction, security signals, lobby split planning |
| `docs-reviewer.md` | Quality validation agent — checklist, banned phrases scan, GEO scoring, 6-dimension quality rubric |
| `hooks/*.sh` | Context Guard hooks — post-commit drift detection, structural change reminders, content filter write guard, session-end context nudge, and pre-commit context enforcement (Claude Code only, opt-in) |
| `upstream-versions.json` | Tracks 8 pinned spec versions — checked monthly by GitHub Action |
| `llms.txt` | AI-readable content index — must be updated when files are added/removed |
| `AGENTS.md` | Cross-tool AI context (Codex CLI format) — must stay in sync with skills/commands |

## When Modifying This Plugin

1. **Adding a skill**: Create `.claude/skills/<name>/SKILL.md`, add a corresponding command in `commands/<name>.md`, update the features list in `README.md`, skills table in `AGENTS.md`, and `llms.txt`
2. **Adding a command**: Create `commands/<name>.md` with YAML frontmatter, update commands tables in `README.md`, `AGENTS.md`, and `llms.txt`
3. **Changing quality standards**: Edit `.claude/rules/doc-standards.md` — this propagates to all generated docs automatically
4. **Updating upstream specs**: Edit `upstream-versions.json` and the corresponding skill content
5. **Adding platform support**: Update the `platform-profiles` skill for new platform equivalents. Existing skills reference it via cross-link.
6. **Bumping version**: Handled automatically by release-please from conventional commit messages

## Promotion

Listing and promotion drafts, status tracking, and submission content live in `docs/promotion/`. This includes awesome list PR content, Reddit post drafts, directory submission templates, and a `STATUS.md` tracking all listings and their current state. Refer to these files when preparing new submissions or checking on existing ones.
