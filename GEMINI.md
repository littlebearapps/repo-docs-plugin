# PitchDocs

A Claude Code plugin that generates marketing-quality repository documentation — READMEs, changelogs, and 15+ more doc types for any codebase. For AI context file management, see [ContextDocs](https://github.com/littlebearapps/contextdocs).

## Tech Stack

Markdown, YAML frontmatter, Claude Code plugin system

## Commands

No build, test, or deploy commands — this is a pure Markdown plugin. Lint with `npx markdownlint-cli2 "**/*.md"`.

## Conventions

- Australian English (realise, colour, behaviour, licence/license)
- Conventional Commits (feat:, fix:, docs:, chore:)
- Benefit-driven language: every feature claim traces to code evidence
- 4-question test: problem solved? usable? credible? linked?
- GEO-optimised structure for AI citation

## Key Paths

- `.claude/skills/*/SKILL.md`: 16 reference knowledge modules
- `.claude/agents/*.md`: 3 pipeline agents (docs-writer, docs-researcher, docs-reviewer)
- `.claude/rules/content-filter.md`: 1 globally auto-loaded rule; `.claude/rules/doc-standards.md`, `.claude/rules/docs-awareness.md`: 2 installed auto-loaded rules
- `rules/*.md`: 2 installable rules (doc-standards, docs-awareness — installed per-project by `/pitchdocs:activate`)
- `agents/docs-freshness.md`: 1 installable agent (freshness checker — installed per-project by `/pitchdocs:activate`)
- `commands/*.md`: 16 command definitions (14 active + 2 stubs)
- `hooks/content-filter-guard.sh`: content filter write guard (Claude Code only, installed by `/pitchdocs:activate install strict`)
- `.claude-plugin/plugin.json`: plugin manifest
- `upstream-versions.json`: pinned upstream spec versions

## Protected Files

- `docs/faq/index.md` — load-bearing source for the marketing-site `FAQPage` JSON-LD on `https://littlebearapps.com/help/pitchdocs/`. The docs-sync pipeline (`scripts/docs-sync.config.ts` in `littlebearapps/littlebearapps.com`, mapped under `pitchdocs` with `category: faq`) hard-fails if the directory is missing. Keep ≥7 question-shaped H2 headings (`##`); update entries in place; never delete. See [Protected Documentation Files](AGENTS.md#protected-documentation-files) in `AGENTS.md`.
