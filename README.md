<p align="center">
  <img src="docs/assets/pitchdocs-logo-full.svg" height="200" alt="PitchDocs" />
</p>

<p align="center">
  <strong>Turn any codebase into professional, marketing-ready repository documentation — powered by AI coding assistants.</strong>
</p>

<p align="center">
  Give your AI the knowledge to map out any codebase, extract a features-and-benefits summary, then create, enhance, and maintain professional public-facing repository docs — works with GitHub, GitLab, and Bitbucket. 100% Markdown, zero runtime dependencies — use with Claude Code, OpenCode, Codex CLI, Cursor, Gemini CLI, and more. SEO and GEO ready with llms.txt (including external documentation sites), and npm/PyPI registry compatible.
</p>

<p align="center">
  <a href="CHANGELOG.md"><img src="https://img.shields.io/static/v1?label=version&message=1.17.0&color=blue" alt="Version" /></a> <!-- x-release-please-version -->
  <a href="LICENSE"><img src="https://img.shields.io/github/license/littlebearapps/pitchdocs" alt="License" /></a>
  <a href="https://code.claude.com/docs/en/plugins"><img src="https://img.shields.io/badge/Claude_Code-Plugin-D97757?logo=claude&logoColor=white" alt="Claude Code Plugin" /></a>
  <a href="https://opencode.ai/"><img src="https://img.shields.io/badge/OpenCode-Compatible-22c55e" alt="OpenCode Compatible" /></a>
  <a href="https://www.npmjs.com/"><img src="https://img.shields.io/badge/npm_%26_PyPI-Ready-cb3837" alt="npm & PyPI Ready" /></a>
  <a href="https://github.com/littlebearapps/pitchdocs/stargazers"><img src="https://img.shields.io/github/stars/littlebearapps/pitchdocs?style=flat&color=yellow" alt="GitHub Stars" /></a>
  <a href="https://github.com/littlebearapps/pitchdocs/graphs/contributors"><img src="https://img.shields.io/github/contributors/littlebearapps/pitchdocs?color=blue" alt="Contributors" /></a>
</p>

<p align="center">
  <a href="#-get-started">Get Started</a> · <a href="#-features">Features</a> · <a href="#%EF%B8%8F-how-pitchdocs-compares">How It Compares</a> · <a href="#-commands">Commands</a> · <a href="#-use-with-other-ai-tools">Other AI Tools</a> · <a href="CONTRIBUTING.md">Contributing</a>
</p>

---

## ⚡ Get Started

Get your first generated README in under 60 seconds.

### Prerequisites

- [Claude Code](https://code.claude.com/) or [OpenCode](https://opencode.ai/) installed

**Using a different AI tool?** PitchDocs skills are plain Markdown files — they work with [Codex CLI, Cursor, Windsurf, Cline, Gemini CLI, Aider, and Goose](docs/guides/other-ai-tools.md) too.

### Claude Code / OpenCode

```bash
# 1. Add the LBA plugin marketplace (once)
/plugin marketplace add littlebearapps/lba-plugins

# 2. Install PitchDocs
/plugin install pitchdocs@lba-plugins

# 3. Generate a README for any project
/pitchdocs:readme
```

**Note:** When installed as a plugin, all commands use the `pitchdocs:` prefix (e.g., `/pitchdocs:readme`). The short form `/readme` only works inside the pitchdocs source directory.

**Optional — install Context Guard hooks (Claude Code only):**

```bash
# 4. Install Context Guard hooks for AI context file freshness and content filter protection
/pitchdocs:context-guard install
```

Keeps your AI context files (AGENTS.md, CLAUDE.md, etc.) in sync as your project evolves, and prevents content filter errors when generating standard OSS files (CODE_OF_CONDUCT, LICENSE, SECURITY). Uninstall anytime with `/pitchdocs:context-guard uninstall`.

OpenCode reads `.claude/skills/` natively — the same install steps (1–3) work in both tools.

For other AI tools, see the [setup guide](docs/guides/other-ai-tools.md).

---

## 🚀 What PitchDocs Does

Your repo is ready to go public, but the docs aren't. You need a README that sells, a CHANGELOG that makes sense to users, a SECURITY policy, contributing guidelines, issue templates, PR templates — and it all needs to look professional.

PitchDocs gives your AI coding assistant the skills and knowledge to scan your codebase, find what's worth talking about, and write the whole documentation suite for you. README, CHANGELOG, CONTRIBUTING, ROADMAP, CODE_OF_CONDUCT, SECURITY, issue templates, PR templates, user guides, and `llms.txt` — all from slash commands like `/pitchdocs:readme` and `/pitchdocs:docs-audit fix`.

It also manages your AI context files — AGENTS.md, CLAUDE.md, .cursorrules, and 4 more — so every AI coding tool on your team understands your project's conventions from day one. Context files are generated using the Signal Gate principle: only what agents can't discover on their own, keeping them lean and effective. Bootstrap with `/pitchdocs:ai-context init`, patch drift with `update`, and promote Claude's auto-learned patterns to CLAUDE.md with `promote`.

Every generated doc is GEO and SEO optimised, npm and PyPI registry compatible, and backed by evidence from your actual code — with professional documentation standards (the 4-question test, lobby principle, and Time to Hello World targets) baked in automatically.

---

## 🎯 Features

- 🧠 **AI context file management** — generate, maintain, and audit AGENTS.md, CLAUDE.md, .cursorrules, copilot-instructions.md, and 3 more for 7 AI tools. Uses the Signal Gate principle to include only what agents can't discover on their own — leaner files, better AI performance. Bootstrap a new project with `init`, patch only what drifted with `update`, promote stable MEMORY.md patterns to CLAUDE.md with `promote`, and verify health with `audit`
- 🔍 **Evidence-based feature extraction** — scans 10 signal categories, infers target personas, and extracts user benefits via auto-scan or a conversational "talk it out" path — every claim backed by a file path
- 📋 **Full docs suite from one command** — README, CHANGELOG, CONTRIBUTING, ROADMAP, SECURITY, issue templates, and 15+ more files
- ✅ **Professional docs without documentation expertise** — every generated doc passes the 4-question test, applies the lobby principle for progressive disclosure, and targets measurable Time to Hello World
- 🔎 **GEO-optimised for AI citation** — structured so ChatGPT, Perplexity, and Google AI Overviews cite your project accurately
- 📊 **Quality scoring (0–100)** — grades docs on completeness, structure, freshness, link health, and AI context health — export to CI with `--min-score`
- 🔒 **Context Guard** — two-tier enforcement keeps AI context files in sync: a session-end nudge reminds you to update docs, and an optional pre-commit guard blocks commits with stale context files *(Claude Code only)*
- 🛡️ **Content filter protection** — automatically handles Claude Code's API filter for CODE_OF_CONDUCT, LICENSE, and SECURITY so you never hit HTTP 400 errors *(Claude Code only)*
- 🌐 **GitHub, GitLab, and Bitbucket** — auto-detects hosting platform and adapts badges, URLs, CI config, and Markdown rendering for each
- 🔌 **Works with 9 AI tools** — Claude Code, OpenCode, Codex CLI, Cursor, Windsurf, Cline, Gemini CLI, Aider, Goose

---

## ⚖️ How PitchDocs Compares

| Capability | PitchDocs | [readmeai](https://github.com/eli64s/readme-ai) | Generic AI Prompt |
|-----------|-----------|--------------------------------------------------|-------------------|
| Scans codebase for features | 10 signal categories with file-level evidence | Basic directory scan | Depends on prompt quality |
| Full docs suite (20+ files) | One command: `/pitchdocs:docs-audit fix` | README only | One file at a time |
| GEO / AI citation optimised | Atomic sections, comparison tables, concrete stats, llms.txt | No | No |
| AI context management | 7 file types with Signal Gate, init/update/promote lifecycle, drift audit | No | No |
| Quality scoring and verification | 0–100 score, broken links, freshness, heading hierarchy, badges | No | No |
| Cross-tool compatibility | 9 AI coding tools with documented setup | CLI only | Tool-specific |

---

## 🤖 Commands

| Command | What It Does | Why It Matters |
|---------|-------------|----------------|
| `/pitchdocs:readme` | Generate or update a marketing-friendly README.md | First impressions that convert browsers to users |
| `/pitchdocs:features` | Extract features and user benefits from code — output as inventory, table, bullets, or bold-outcome benefits (auto-scan or conversational) | Never miss a feature worth documenting |
| `/pitchdocs:changelog` | Generate CHANGELOG.md from git history with user-benefit language | Users see what changed for *them*, not your commit log |
| `/pitchdocs:roadmap` | Generate ROADMAP.md from GitHub milestones and issues | Show contributors where the project is heading |
| `/pitchdocs:docs-audit` | Audit docs completeness, quality, GitHub metadata, visual assets, AI context files, Diataxis coverage, and npm/PyPI registry config | Catch gaps in files, metadata, images, and package registry fields before you ship |
| `/pitchdocs:llms-txt` | Generate llms.txt and llms-full.txt for AI discoverability | AI coding assistants and search engines find and understand your docs |
| `/pitchdocs:user-guide` | Generate task-oriented user guides in `docs/guides/` with Diataxis classification | Readers find answers without reading your source code |
| `/pitchdocs:ai-context` | Generate lean AI context files using Signal Gate — `init` bootstraps, `update` patches drift, `promote` moves MEMORY.md patterns to CLAUDE.md | AI coding assistants understand your project's conventions from day one |
| `/pitchdocs:docs-verify` | Verify links, freshness, llms.txt sync, heading hierarchy, badge URLs, and AI context health | Catch documentation decay before it reaches users |
| `/pitchdocs:launch` | Generate Dev.to articles, HN posts, Reddit posts, Twitter threads, awesome list submissions | Transform docs into platform-specific launch content |
| `/pitchdocs:doc-refresh` | Refresh all docs after version bumps — CHANGELOG, README features, user guides, AI context, llms.txt | Never ship a release with stale documentation |
| `/pitchdocs:platform` | Detect hosting platform (GitHub, GitLab, Bitbucket) and report feature support | Know which PitchDocs features work on your platform before you start |
| `/pitchdocs:context-guard` | Install, uninstall, or check status of Context Guard hooks with tiered enforcement for AI context file freshness and content filter protection | Catch stale context files before they reach your repo |

**Note:** `/pitchdocs:context-guard` is **Claude Code only**. All other commands work across all supported AI tools.

### Quick Examples

```bash
/pitchdocs:readme                   # Generate a marketing-friendly README
/pitchdocs:features bullets         # Extract features as emoji+bold+em-dash bullets
/pitchdocs:features benefits        # Extract user benefits (auto-scan or "talk it out")
/pitchdocs:docs-audit fix           # Audit and auto-generate missing docs
/pitchdocs:changelog full           # Generate full changelog from all tags
/pitchdocs:ai-context init           # Bootstrap AI context for a new project
/pitchdocs:ai-context update         # Patch only what drifted
/pitchdocs:docs-verify              # Check for broken links and stale content
/pitchdocs:doc-refresh              # Refresh all docs for an upcoming release
```

---

## 🔀 Use with Other AI Tools

PitchDocs works natively with [Claude Code](https://code.claude.com/) and [OpenCode](https://opencode.ai/). It's also portable to [Codex CLI](https://codex.openai.com/), [Cursor](https://cursor.com/), [Windsurf](https://codeium.com/windsurf), [Cline](https://github.com/cline/cline), [Gemini CLI](https://github.com/google-gemini/gemini-cli), [Aider](https://aider.chat/), and [Goose](https://github.com/block/goose) — all knowledge is stored as plain Markdown files.

See the [Other AI Tools guide](docs/guides/other-ai-tools.md) for per-tool setup instructions and a full compatibility matrix.

---

## 📚 Documentation

- [Getting Started Guide](docs/guides/getting-started.md) — Installation, first README generation, and full command walkthrough
- [Workflows](docs/guides/workflows.md) — Recipes for public-ready repos, releases, launches, and ongoing maintenance
- [Troubleshooting](docs/guides/troubleshooting.md) — Content filter errors, quality scores, badge issues, and FAQ
- [Other AI Tools](docs/guides/other-ai-tools.md) — Setup for Codex CLI, Cursor, Windsurf, Cline, Gemini CLI, Aider, and Goose
- [Documentation Hub](docs/README.md) — All guides, command reference, and skills reference
- [Support](SUPPORT.md) — Getting help, common questions, and response times

---

## 🤝 Contributing

Found a way to make generated docs even better? We'd love your help — whether it's improving a template, fixing a language rule, or suggesting a new doc type entirely.

See our [Contributing Guide](CONTRIBUTING.md) to get started, or jump straight in:

**Roadmap:** See [open milestones](https://github.com/littlebearapps/pitchdocs/milestones) and [feature requests](https://github.com/littlebearapps/pitchdocs/issues?q=is:open+label:enhancement) for what's coming next.

- [Good First Issues](https://github.com/littlebearapps/pitchdocs/labels/good%20first%20issue) — Great starting points
- [Feature Requests](https://github.com/littlebearapps/pitchdocs/issues/new?template=feature_request.yml) — Suggest improvements
- [Open Issues](https://github.com/littlebearapps/pitchdocs/issues) — See what needs doing

---

## 📄 Licence

[MIT](LICENSE) — Made by [Little Bear Apps](https://littlebearapps.com) 🐶
