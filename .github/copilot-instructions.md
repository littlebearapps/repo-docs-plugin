# PitchDocs — Copilot Instructions

PitchDocs is a Claude Code plugin that generates marketing-quality repository documentation. Pure Markdown, no runtime dependencies.

## Project Structure

- `.claude/skills/*/SKILL.md` — 14 reference knowledge modules (README, features, changelog, roadmap, docs suite, llms.txt, package registry, user guides, AI context, docs verify, launch artifacts, API reference, doc refresh, context guard)
- `.claude/agents/docs-writer.md` — orchestration agent (scan → extract → write → validate)
- `.claude/rules/doc-standards.md` — quality standards rule (auto-loaded, Claude Code only)
- `.claude/rules/context-quality.md` — AI context file quality rule (auto-loaded, Claude Code only)
- `.claude/rules/content-filter.md` — content filter quick reference rule (auto-loaded, Claude Code only)
- `commands/*.md` — 12 slash command definitions
- `hooks/*.sh` — 3 Context Guard hook scripts (Claude Code only, opt-in via `/pitchdocs:context-guard install`)
- `.claude-plugin/plugin.json` — plugin manifest

## Conventions

- Australian English spelling (realise, colour, behaviour, licence)
- Conventional Commits for git messages (feat:, fix:, docs:, chore:)
- Benefit-driven documentation: every feature claim traces to code evidence (with optional JTBD job mapping for richer benefits)
- 4-question framework: Does this solve my problem? Can I use it? Who made it? Where do I learn more?
- GEO-optimised structure for AI citation (crisp definitions, atomic sections, comparison tables)

## Sync Points

When modifying skills or commands, keep these files in sync: README.md, AGENTS.md, llms.txt, and the bug report template component dropdown.
