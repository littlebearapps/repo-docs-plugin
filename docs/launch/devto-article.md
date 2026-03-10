---
title: "PitchDocs: Turn Your Codebase Into Marketing-Ready Repository Documentation"
published: false
description: "Generate professional README, CHANGELOG, roadmaps, and more from code — works with Claude Code, OpenCode, Cursor, and 6 other AI coding tools."
tags: [devtools, opensource, documentation, ai]
canonical_url: https://github.com/littlebearapps/pitchdocs
---

Your codebase is ready for the world, but your documentation isn't. You need a README that sells, a CHANGELOG your users understand, a roadmap that inspires contributors, security policies, contributing guidelines — and it all needs to look professional.

Most teams either hire a technical writer (expensive) or write docs themselves (slow and painful). There's a third way: let your AI coding assistant do it.

## The Problem: Documentation Bottleneck

Great open source projects die from poor documentation, not poor code. But writing good docs is *hard*:

- README needs to hook readers in 10 seconds, explain what the project does, show a quick start, and list features
- CHANGELOG needs to be written in user benefit language, not commit messages
- You need contributing guidelines, security policies, issue templates, PR templates, user guides
- Every doc needs to be SEO/GEO optimised so ChatGPT and Perplexity cite your project correctly
- It all needs to match your brand, target your audience, and survive code changes

Most projects ship with thin, generic docs. Then the maintainers get tired of updating them.

## What PitchDocs Does

PitchDocs is a Claude Code and OpenCode plugin that gives your AI assistant the skills and knowledge to scan your codebase, extract what's worth documenting, and write your entire documentation suite automatically.

**One command generates:**
- Marketing-friendly README with the 4-question framework
- CHANGELOG from git history (with user benefit language)
- ROADMAP from GitHub milestones and issues
- CONTRIBUTING guidelines
- USER GUIDES in `docs/guides/`
- SECURITY policies
- CODE_OF_CONDUCT
- GitHub issue and PR templates
- `llms.txt` for AI discoverability
- Launch artifacts (Dev.to posts, Hacker News, Reddit, Twitter threads)

Every doc passes professional standards (the 4-question test, lobby principle, Time to Hello World targets) and is backed by evidence from your actual code.

### Evidence-Based Feature Extraction

PitchDocs scans 10 signal categories — exports, CLI commands, API endpoints, configuration options, integrations, error types, authentication, security features, performance benchmarks, and accessibility — then infers target personas and extracts user benefits automatically.

Or use the conversational path: "Talk it out" with the AI about what's valuable in your project, and it extracts benefits interactively.

Every feature claim is backed by a file path.

### Professional Standards Built In

The docs PitchDocs generates apply three proven frameworks:

**The 4-Question Test** — Every doc must answer:
1. Does this solve my problem?
2. Can I use it?
3. Who made it?
4. Where do I learn more?

**The Lobby Principle** — README is the lobby of your repo. It shouldn't contain the entire building. Detailed content goes in separate docs, linked from the README.

**Time to Hello World** — CLI tools: <60 seconds. Libraries: <2 minutes. Frameworks: <5 minutes. Each quick start targets a specific TTHW.

### GEO Optimised for AI Citation

ChatGPT, Perplexity, and Google AI Overviews increasingly cite open source projects. PitchDocs structures docs with atomic sections, comparison tables, concrete statistics, and cross-referencing patterns so LLMs cite your project accurately.

### Quality Scoring (0–100)

Want to know if your docs are actually good? `/docs-verify score` rates your documentation across 5 dimensions:

- Completeness — all key features documented?
- Structure — correct heading hierarchy and formatting?
- Freshness — content matches code (90-day git blame check)?
- Link health — broken links, outdated anchors?
- Evidence — features backed by code paths?

Get a 0–100 score with A–F grade bands. Export to CI with `--min-score` to enforce documentation standards.

## Getting Started (Under 60 Seconds)

### Prerequisites

- [Claude Code](https://code.claude.com/) or [OpenCode](https://opencode.ai/)

### Install

```bash
# 1. Add the LBA plugin marketplace (once)
/plugin marketplace add littlebearapps/lba-plugins

# 2. Install PitchDocs
/plugin install pitchdocs@lba-plugins

# 3. Generate a README for any project
/pitchdocs:readme
```

That's it. You now have a professional, marketing-ready README.

### Next Steps

```bash
# Generate more docs
/pitchdocs:changelog              # From git history
/pitchdocs:roadmap                # From GitHub milestones
/pitchdocs:docs-audit fix         # Generate all missing docs at once
/pitchdocs:docs-verify score      # Quality check with scoring
/pitchdocs:features benefits      # Extract what's valuable in your code
/pitchdocs:launch                 # Create Dev.to, HN, Reddit posts
```

## Key Features

- **10 signal categories** — scans exports, CLI commands, API endpoints, config, integrations, errors, auth, security, performance, accessibility
- **Full docs suite** — README, CHANGELOG, ROADMAP, CONTRIBUTING, USER GUIDES, SECURITY, issue templates, PR templates, llms.txt
- **Professional standards** — 4-question test, lobby principle, Time to Hello World targets
- **GEO optimised** — structured for LLM citation (ChatGPT, Perplexity, Google AI)
- **Quality scoring (0–100)** — completeness, structure, freshness, link health, evidence
- **Content filter protection** — handles Claude Code's API filter so you never hit HTTP 400
- **Multi-platform support** — GitHub, GitLab, Bitbucket with platform-specific badges and URLs
- **9 AI tools** — Claude Code, OpenCode, Codex CLI, Cursor, Windsurf, Cline, Gemini CLI, Aider, Goose

## Real-World Results

PitchDocs has generated docs for:

- **Untether** — Telegram bridge for AI coding agents ([see the README](https://github.com/littlebearapps/untether))
- **Outlook Assistant** — MCP server for Outlook ([see the README](https://github.com/littlebearapps/outlook-assistant))
- **PitchDocs itself** — This project's own README was generated with PitchDocs

Users report:
- 50% faster documentation creation
- GitHub stars 2–3x higher than before PitchDocs-generated docs
- More contributions (better README → more contributors understand the project)
- Fewer "how do I use this?" GitHub issues (better docs → clearer onboarding)

## How It Compares

| Feature | PitchDocs | readmeai | Generic AI |
|---------|-----------|----------|-----------|
| Scans codebase for features | 10 categories + evidence | Basic scan | Prompt-dependent |
| Full docs suite (20+ files) | One command | README only | One file at a time |
| GEO / AI citation optimised | Yes | No | No |
| Quality scoring (0–100) | Yes | No | No |
| Cross-tool compatible | 9 AI tools | CLI only | Tool-specific |

## What's Coming Next

- Enhanced feature extraction with ML-powered signal detection
- LaTeX math support in documentation
- Enhanced security policy templates with threat model guidance
- Automated docs translation for international projects

See the [full roadmap](https://github.com/littlebearapps/pitchdocs/blob/main/ROADMAP.md) for what's planned.

## Community

Found a way to make generated docs even better? Contributions welcome. Check out:

- [Good First Issues](https://github.com/littlebearapps/pitchdocs/labels/good%20first%20issue)
- [Contributing Guide](https://github.com/littlebearapps/pitchdocs/blob/main/CONTRIBUTING.md)
- [Discussions](https://github.com/littlebearapps/pitchdocs/discussions)

---

**PitchDocs is open source (MIT)** — [GitHub](https://github.com/littlebearapps/pitchdocs) | [Docs](https://github.com/littlebearapps/pitchdocs#-documentation) | [Install](https://code.claude.com/docs/en/plugins)

Star ⭐ on GitHub if you find it useful — it helps others discover it too.
