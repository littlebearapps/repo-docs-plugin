# PitchDocs

Generate high-quality public-facing repository documentation with a marketing edge. PitchDocs creates READMEs that sell, changelogs that communicate value, roadmaps from GitHub milestones, AI context files for coding assistants, and audits your docs completeness — with GEO-optimised structure for AI citation and launch artifacts for promotion.

## Documentation Standards

Australian English (realise, colour). Conventional commits. Benefit-driven language: `[Feature] so you can [outcome] — [evidence]`. 4-question test (problem? use? who? learn more?). Progressive disclosure (non-technical first paragraph, technical details deeper).

## Available Skills

Skills are loaded on-demand to provide deep reference knowledge. Each lives at `.claude/skills/<name>/SKILL.md` (or `.agents/skills/<name>/SKILL.md` if you've copied them for Codex CLI). There are 18 skills in total.

| Skill | What It Provides |
|-------|-----------------|
| `public-readme` | README structure with the Daytona/Banesullivan marketing framework — hero section, audience-segmented value proposition, quickstart with Time to Hello World targets, features with evidence-based benefits |
| `feature-benefits` | 7-step codebase scanning workflow across 10 signal categories with JTBD job mapping, persona inference (5 archetypes from code signals), and two-path user benefits extraction (auto-scan or conversational "talk it out"). Extracts concrete features with file/function evidence and translates them into benefits across 5 categories (time saved, confidence gained, pain avoided, capability unlocked, cost reduced) |
| `changelog` | Keep a Changelog format with language rules that rewrite conventional commits into user-facing benefit language. Maps `feat:` to Added, `fix:` to Fixed, etc. |
| `roadmap` | Roadmap structure from GitHub milestones with emoji status indicators, mission statement, and community involvement section |
| `pitchdocs-suite` | Full 20+ file inventory (README, CONTRIBUTING, CHANGELOG, CODE_OF_CONDUCT, SECURITY, AI context files, issue templates, PR templates, and more), GitHub metadata guidance, visual assets, licence selection framework, and ready-to-use templates |
| `llms-txt` | llmstxt.org specification reference for generating `llms.txt` and `llms-full.txt` — LLM-friendly content indices for AI coding assistants |
| `package-registry` | npm and PyPI metadata field auditing, cross-renderer README compatibility (GitHub vs npm vs PyPI), trusted publishing guidance, and registry-specific badges |
| `user-guides` | Task-oriented how-to documentation with Diataxis framework, guide frontmatter standard, title conventions, numbered steps, copy-paste-ready code, error recovery, and cross-linked hub pages. Companion file `SKILL-templates.md` provides tutorial, reference, and explanation templates. |
| `ai-context` | AI IDE context file generation with Signal Gate principle — AGENTS.md, CLAUDE.md, .cursorrules, copilot-instructions.md, .windsurfrules, .clinerules, GEMINI.md from codebase analysis. Includes init (bootstrap), update (incremental drift patching), promote (MEMORY.md → CLAUDE.md), and audit with Context Guard status |
| `docs-verify` | Documentation validation — broken links, stale content, llms.txt sync, heading hierarchy, badge URLs, AI context health scoring, and CI-friendly output |
| `launch-artifacts` | Platform-specific launch content — Dev.to articles, HN posts, Reddit posts, Twitter threads, awesome list submissions |
| `api-reference` | API reference generator guidance — TypeDoc, Sphinx, godoc, rustdoc configuration templates and comment conventions |
| `doc-refresh` | Version-bump documentation orchestration — analyses git history, identifies affected docs, and delegates to existing skills for selective refresh |
| `context-guard` | Context Guard installation reference — hook architecture, settings.json configuration, customisation, and troubleshooting *(Claude Code only)* |
| `visual-standards` | Visual formatting — emoji heading prefixes, horizontal rules, TOC anchors, callouts, screenshot dimensions, HTML patterns, captions, shadows, image optimisation |
| `geo-optimisation` | GEO patterns for AI citation — citation capsules, crisp definitions, atomic sections, comparison tables, statistics, semantic scaffolding |
| `skill-authoring` | Token budget guidelines for writing skills — budgets by type, metadata/activation limits, measuring cost, anti-patterns |
| `platform-profiles` | Platform-specific equivalents for GitLab and Bitbucket — template directory mapping, badge URL patterns, Markdown rendering compatibility matrix, CLI tool mapping, CI/CD alternatives, and Bitbucket graceful degradation guidance |

## Agent Pipeline

PitchDocs uses a 3-agent pipeline for documentation generation:

| Agent | File | Role |
|-------|------|------|
| `docs-researcher` | `.claude/agents/docs-researcher.md` | Codebase discovery, platform detection, feature extraction (7-step workflow across 10 signal categories), security signal scanning, lobby split planning. Produces a structured research packet. |
| `docs-writer` | `.claude/agents/docs-writer.md` | Orchestrator — spawns researcher, writes documentation using the Daytona "4000 Stars" marketing framework with citation capsules and banned phrase avoidance, then spawns reviewer. |
| `docs-reviewer` | `.claude/agents/docs-reviewer.md` | Post-generation quality validation — full checklist, banned phrases scan, citation capsule completeness, GEO readiness, 6-dimension quality scoring (100-point rubric). |

## Workflow Commands

These commands are defined in `commands/*.md` and can be invoked as slash commands in Claude Code and OpenCode, or as prompts in Codex CLI. Claude Code users: invoke as `/pitchdocs:command-name` (e.g., `/pitchdocs:readme`). Commands marked *(Claude Code only)* use features not available in other tools:

| Command | What It Does |
|---------|-------------|
| `readme` | Generate or update a marketing-friendly README.md |
| `features` | Extract features from code and translate to benefits |
| `changelog` | Generate CHANGELOG.md from git history with user-benefit language |
| `roadmap` | Generate ROADMAP.md from GitHub milestones and issues |
| `docs-audit` | Audit docs completeness, quality, GitHub metadata, AI context files, Diataxis coverage, and registry config |
| `llms-txt` | Generate llms.txt and llms-full.txt for AI discoverability |
| `user-guide` | Generate task-oriented user guides in `docs/guides/` with Diataxis classification |
| `ai-context` | Generate AI context files using Signal Gate — supports `all`, `claude`, `agents`, `cursor`, `copilot`, `windsurf`, `cline`, `gemini`, `init`, `update`, `promote`, `audit` |
| `docs-verify` | Verify links, freshness, llms.txt sync, heading hierarchy, badge URLs, and AI context health |
| `launch` | Generate Dev.to articles, HN posts, Reddit posts, Twitter threads, awesome list submissions |
| `doc-refresh` | Refresh all docs after version bumps — CHANGELOG, README features, user guides, AI context, llms.txt |
| `platform` | Detect hosting platform (GitHub/GitLab/Bitbucket) and report feature support |
| `visual-standards` | Load visual formatting standards for screenshots, emoji headings, and image specs |
| `geo` | Load GEO optimisation patterns for AI citation |
| `context-guard` | Install, uninstall, or check status of Context Guard hooks for AI context file freshness and content filter protection *(Claude Code only)* |

## Rules and Hooks (Claude Code Only)

PitchDocs includes features that are specific to Claude Code and do not work in OpenCode, Codex CLI, or other tools:

- **Rules** (4): `.claude/rules/doc-standards.md` (core quality standards — 4-question framework, benefits writing, badges; extended references in `visual-standards`, `geo-optimisation`, `skill-authoring` skills, auto-loaded), `.claude/rules/context-quality.md` (AI context file quality, auto-loaded), `.claude/rules/content-filter.md` (content filter quick reference, auto-loaded), and `.claude/rules/docs-awareness.md` (documentation trigger map — suggests PitchDocs commands when documentation-relevant work is detected, auto-loaded)
- **Hooks** (5): `hooks/context-drift-check.sh` (post-commit drift detection), `hooks/context-structural-change.sh` (structural change reminders), `hooks/content-filter-guard.sh` (Write guard for high-risk OSS files), `hooks/context-guard-stop.sh` (session-end context doc nudge — Tier 1), and `hooks/context-commit-guard.sh` (pre-commit context doc enforcement — Tier 2) — opt-in via `/pitchdocs:context-guard install` (Claude Code)

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
