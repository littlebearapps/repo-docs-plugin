---
name: pitchdocs
description: Generate marketing-quality repository documentation from codebase analysis. Scans 10 signal categories, extracts features with file-level evidence, and produces README, CHANGELOG, ROADMAP, AI context files, and 15+ more docs. Zero runtime dependencies.
version: "1.15.0"
author: Little Bear Apps
tags:
  - documentation
  - readme
  - changelog
  - marketing
  - ai-context
  - quality-scoring
  - claude-code-plugin
---

# PitchDocs — AI Documentation Plugin

## Overview

PitchDocs is a pure Markdown Claude Code plugin that scans any codebase and generates professional, marketing-ready repository documentation. Every feature claim traces to an actual file path — no hallucinated marketing copy.

15 skills, 13 slash commands, 1 orchestration agent, 4 quality rules, 5 opt-in hooks. 100% Markdown, zero runtime dependencies, MIT licensed.

## When to Use

- Starting a new open-source project and need professional docs fast
- Overhauling an existing README that undersells your project
- Preparing for a public launch or Product Hunt submission
- Generating AI context files (AGENTS.md, CLAUDE.md, .cursorrules, copilot-instructions.md, .windsurfrules, .clinerules, GEMINI.md) for your project
- Auditing documentation completeness across 20+ files
- Creating changelogs, roadmaps, or user guides from existing code and git history

## Instructions

1. Install the plugin:
   ```
   /plugin marketplace add littlebearapps/lba-plugins
   /plugin install pitchdocs@lba-plugins
   ```

2. Navigate to any project repository

3. Run commands:
   - `/pitchdocs:readme` — Generate a marketing-quality README
   - `/pitchdocs:docs-audit` — Audit documentation completeness (20+ file checklist)
   - `/pitchdocs:features` — Extract features with file-level evidence
   - `/pitchdocs:changelog` — Generate CHANGELOG from git history
   - `/pitchdocs:ai-context` — Generate AI context files for 7 tools
   - `/pitchdocs:llms-txt` — Generate llms.txt for AI discoverability
   - `/pitchdocs:docs-verify` — Quality scoring (0-100) with link checking
   - `/pitchdocs:roadmap` — Generate ROADMAP from GitHub milestones
   - `/pitchdocs:user-guide` — Generate task-oriented user guides
   - `/pitchdocs:launch` — Generate launch and promotion content
   - `/pitchdocs:doc-refresh` — Refresh all docs after version bumps
   - `/pitchdocs:platform` — Detect hosting platform feature support
   - `/pitchdocs:context-guard` — Install context freshness hooks

## Output Format

Each command produces Markdown files written directly to the repository. The orchestration agent follows a 4-step workflow:

1. **Discover** — Scan codebase across 10 signal categories
2. **Extract** — Identify features with file-level evidence, classify by tier (Hero/Core/Supporting)
3. **Write** — Generate documentation with benefit-driven language and GEO-optimised structure
4. **Validate** — Check quality against the 4-question test and doc standards

## Examples

**Feature extraction output:**
```
Hero Feature: Evidence-based feature extraction
  Evidence: .claude/skills/feature-benefits/SKILL.md
  Benefit: Every feature claim traces to actual code — no hallucinated marketing copy
  Category: Confidence gained
```

**README generation produces:**
- Hero section with one-liner + badges
- "Why [Project]?" with problem/solution table
- Quick start with Time to Hello World target
- Features with emoji+bold+em-dash bullets
- Comparison table vs alternatives
- Documentation links and contributing CTA

## Notes

- Works with 9 AI tools: Claude Code, OpenCode, Codex CLI, Cursor, Windsurf, Cline, Gemini CLI, Aider, Goose
- Cross-platform: GitHub, GitLab, and Bitbucket
- GEO-optimised for AI citation (ChatGPT, Perplexity, Google AI Overviews)
- Content filter mitigation built in for CODE_OF_CONDUCT, LICENSE, and SECURITY files
- All knowledge stored as structured YAML+Markdown — no JavaScript, no Python, no build step
