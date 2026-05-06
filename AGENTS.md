# PitchDocs

Generate high-quality public-facing repository documentation with a marketing edge. PitchDocs creates READMEs that sell, changelogs that communicate value, roadmaps from GitHub milestones, and audits your docs completeness — with GEO-optimised structure for AI citation and launch artifacts for promotion. For AI context file management, see [ContextDocs](https://github.com/littlebearapps/contextdocs).

## Documentation Standards

Australian English (realise, colour). Conventional commits. Benefit-driven language: `[Feature] so you can [outcome] — [evidence]`. 4-question test (problem? use? who? learn more?). Progressive disclosure (non-technical first paragraph, technical details deeper).

## Available Skills

Skills are loaded on-demand to provide deep reference knowledge. Each lives at `.claude/skills/<name>/SKILL.md` (or `.agents/skills/<name>/SKILL.md` if you've copied them for Codex CLI). There are 15 skills in total.

| Skill | What It Provides |
|-------|-----------------|
| `public-readme` | README structure with the Daytona/Banesullivan marketing framework — hero template, value proposition, quickstart with Time to Hello World targets, features with evidence-based benefits. Companion `SKILL-reference.md` has logo guidelines, registry badges, use-case framing, and visual element guidance (loaded on demand) |
| `feature-benefits` | 7-step codebase scanning workflow — extracts concrete features from code, translates to benefit-driven language across 5 categories (time saved, confidence gained, pain avoided, capability unlocked, cost reduced). Generates features and benefits sections, "Why [Project]?" content, and feature audit reports. Companion `SKILL-signals.md` has detailed signal category scan lists, JTBD mapping, persona inference, conversational path prompts, and per-ecosystem pattern libraries (loaded on demand) |
| `changelog` | Keep a Changelog format with language rules that rewrite conventional commits into user-facing benefit language. Maps `feat:` to Added, `fix:` to Fixed, etc. |
| `roadmap` | Roadmap structure from GitHub milestones with emoji status indicators, mission statement, and community involvement section |
| `pitchdocs-suite` | Full 20+ file inventory (README, CONTRIBUTING, CHANGELOG, CODE_OF_CONDUCT, SECURITY, AI context files, issue templates, PR templates, and more), GitHub metadata guidance, visual assets, licence selection framework, and ready-to-use templates |
| `llms-txt` | llmstxt.org specification reference for generating `llms.txt` and `llms-full.txt` — LLM-friendly content indices for AI coding assistants |
| `package-registry` | npm and PyPI metadata field auditing, cross-renderer README compatibility (GitHub vs npm vs PyPI), trusted publishing guidance, and registry-specific badges |
| `user-guides` | Task-oriented how-to documentation with Diataxis framework, guide frontmatter standard, title conventions, numbered steps, copy-paste-ready code, error recovery, and cross-linked hub pages. Companion file `SKILL-templates.md` provides tutorial, reference, and explanation templates. |
| `docs-verify` | Documentation validation — broken links, stale content, llms.txt sync, heading hierarchy, badge URLs, lightweight AI context health check, and CI-friendly output |
| `launch-artifacts` | Platform-specific launch content — Dev.to articles, HN posts, Reddit posts, Twitter threads, awesome list submissions |
| `api-reference` | API reference generator guidance — TypeDoc, Sphinx, godoc, rustdoc configuration templates and comment conventions |
| `doc-refresh` | Version-bump documentation orchestration — analyses git history, identifies affected docs, delegates AI context refresh to ContextDocs if installed |
| `visual-standards` | Visual formatting — emoji heading prefixes, horizontal rules, TOC anchors, callouts. Companion `SKILL-reference.md` has screenshot dimensions, HTML patterns, captions, shadows, image optimisation (loaded on demand) |
| `geo-optimisation` | GEO patterns for AI citation — citation capsules, crisp definitions, atomic sections, comparison tables, statistics, semantic scaffolding |

| `platform-profiles` | Platform detection and Markdown rendering compatibility matrix. Companion `SKILL-tables.md` has full lookup tables for GitLab/Bitbucket — template directories, badge URLs, CLI tools, CI/CD, and Bitbucket degradation (loaded on demand) |

## Agent Pipeline

PitchDocs uses an adaptive agent pipeline for documentation generation, plus utility agents:

| Agent | File | Role |
|-------|------|------|
| `docs-researcher` | `.claude/agents/docs-researcher.md` | Codebase discovery, platform detection, feature extraction (7-step workflow across 10 signal categories), security signal scanning, lobby split planning. Produces a structured research packet. **Only spawned for projects with 20+ files** — smaller projects use lightweight inline research. |
| `docs-writer` | `.claude/agents/docs-writer.md` | Orchestrator — chooses lightweight (inline) or full (sub-agent) research based on project size, writes documentation using the Daytona "4000 Stars" marketing framework with citation capsules and banned phrase avoidance, conditionally spawns reviewer. |
| `docs-reviewer` | `.claude/agents/docs-reviewer.md` | Post-generation quality validation — full checklist, banned phrases scan, citation capsule completeness, GEO readiness, 6-dimension quality scoring (100-point rubric). **Skipped for new README generation** — runs for updates, docs suites, or when explicitly requested (`--review`). |
| `context-updater` | `.claude/agents/context-updater.md` | Patches AI context files (AGENTS.md, CLAUDE.md, llms.txt, etc.) after structural project changes — updates counts, tables, and path references surgically. |
| `docs-freshness` | `agents/docs-freshness.md` | Read-only freshness checker — version alignment, changelog coverage, doc staleness, structural coverage. Installed per-project by `/pitchdocs:activate`. Suggests specific `/pitchdocs:*` commands to fix each finding. |

## Workflow Commands

These commands are defined in `commands/*.md` and can be invoked as slash commands in Claude Code and OpenCode, or as prompts in Codex CLI. Claude Code users: invoke as `/pitchdocs:command-name` (e.g., `/pitchdocs:readme`). Commands marked *(Claude Code only)* use features not available in other tools:

| Command | What It Does |
|---------|-------------|
| `readme` | Generate or update a marketing-friendly README.md. Supports `--review` (force review) and `--no-review` (skip review) flags |
| `features` | Extract features from code and translate to benefits |
| `changelog` | Generate CHANGELOG.md from git history with user-benefit language |
| `roadmap` | Generate ROADMAP.md from GitHub milestones and issues |
| `docs-audit` | Audit docs completeness, quality, GitHub metadata, AI context files, Diataxis coverage, and registry config |
| `llms-txt` | Generate llms.txt and llms-full.txt for AI discoverability |
| `user-guide` | Generate task-oriented user guides in `docs/guides/` with Diataxis classification |
| `ai-context` | **Stub** — redirects to [ContextDocs](https://github.com/littlebearapps/contextdocs) for AI context file management |
| `docs-verify` | Verify links, freshness, llms.txt sync, heading hierarchy, badge URLs, and lightweight AI context health |
| `launch` | Generate Dev.to articles, HN posts, Reddit posts, Twitter threads, awesome list submissions |
| `doc-refresh` | Refresh all docs after version bumps — CHANGELOG, README features, user guides, llms.txt (AI context delegated to ContextDocs) |
| `platform` | Detect hosting platform (GitHub/GitLab/Bitbucket) and report feature support |
| `visual-standards` | Load visual formatting standards for screenshots, emoji headings, and image specs |
| `geo` | Load GEO optimisation patterns for AI citation |
| `activate` | Install/uninstall per-project rules, agent, and hook — `install`, `install strict`, `uninstall`, `status` |
| `context-guard` | **Stub** — redirects to [ContextDocs](https://github.com/littlebearapps/contextdocs) for Context Guard hooks |

## Per-Project Activation (Claude Code Only)

PitchDocs commands work globally. Advisory features (quality standards, documentation nudges, freshness checking) are opt-in per-project via `/pitchdocs:activate`:

- **Auto-loaded** (globally): `.claude/rules/content-filter.md` (content filter quick reference — prevents HTTP 400 errors), `.claude/rules/context-quality.md` (AI context file quality standards)
- **Installed per-project** by `/pitchdocs:activate install`: `rules/doc-standards.md` (quality standards), `rules/docs-awareness.md` (documentation trigger map), `agents/docs-freshness.md` (freshness checker agent)
- **This repo** has Standard tier activated — `.claude/rules/doc-standards.md`, `.claude/rules/docs-awareness.md`, and `.claude/agents/docs-freshness.md` are auto-loaded locally
- **Installed per-project** by `/pitchdocs:activate install strict`: also adds `hooks/content-filter-guard.sh` (Write guard for high-risk OSS files)

## Protected Documentation Files

These files are **load-bearing** for downstream systems and must be retained — only edit them with succinct, focused updates when content genuinely needs to change. Do **not** delete them.

| File | Why It's Load-Bearing | Update Discipline |
|------|----------------------|-------------------|
| `docs/faq/index.md` | Source for the marketing-site FAQPage JSON-LD on `https://littlebearapps.com/help/pitchdocs/`. The site's docs-sync pipeline (`scripts/docs-sync.config.ts` in `littlebearapps/littlebearapps.com`, mapped under `pitchdocs` with `category: faq`) **hard-fails** if this directory is missing. Closes [#45](https://github.com/littlebearapps/pitchdocs/issues/45). | Keep ≥7 question-shaped H2 headings (`##`) (each ending `?`); preserve `title`/`description` frontmatter only — sync injects `category`, `tool`, dates. Update entries in place when answers drift; don't rewrite wholesale. |

## AI Context Files

This repository includes context files for multiple AI coding tools:

- `AGENTS.md` — Codex CLI (this file)
- `CLAUDE.md` — Claude Code project context
- `.cursorrules` — Cursor IDE project context
- `.github/copilot-instructions.md` — GitHub Copilot project context
- `.windsurfrules` — Windsurf (Cascade AI) project context
- `.clinerules` — Cline VS Code extension project context
- `GEMINI.md` — Gemini CLI project context
- `llms.txt` — LLM-friendly content index (llmstxt.org spec)
- `llms-full.txt` — Full concatenated documentation content for LLM ingestion (~58K tokens)
