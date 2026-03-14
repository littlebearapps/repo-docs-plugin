# Roadmap

**Mission:** Turn any codebase into professional, marketing-ready repository documentation — powered by AI coding assistants.

PitchDocs is a pure Markdown plugin with 15 skills, 4 agents (3 pipeline + 1 per-project freshness checker), 1 auto-loaded rule + 2 installable rules, 16 commands (14 active + 2 stubs), and 21 evaluation test cases. This roadmap outlines completed work, current priorities, and future directions.

---

## 🎯 Current Milestone: v2.2 — Command Completeness & Upstream Stability

Target: Q1 2026

### In Progress

- **Add `/pitchdocs:api-reference` command** ([#41](https://github.com/littlebearapps/pitchdocs/issues/41)) — Direct slash command for TypeDoc, Sphinx, godoc, and rustdoc integration. Currently unreachable through primary `/pitchdocs:*` pattern. Needs command definition, 1–2 eval test cases, and skill cross-references to `user-guides` and `platform-profiles`
- **Resolve upstream spec version drift** ([#12](https://github.com/littlebearapps/pitchdocs/issues/12)) — Contributor Covenant v3.0 detected in monthly check (latest is v2.1). Update `upstream-versions.json` and refresh skill content

### Previous Focus — Context Token Optimisation (v2.0–v2.1) ✅

- ✅ Auto-loaded rules reduced to ~500 tokens (moved advisory features to per-project install)
- ✅ 4 of 6 over-budget skills split into companion reference files
- ✅ Per-project activation system (`/pitchdocs:activate`) for doc-standards, docs-awareness, docs-freshness agent, and optional content-filter hook
- ✅ Auto-loaded context reduced by 41%, `/readme` context overhead reduced by 72% for small projects

---

## ✅ Recently Completed

### v2.1.0 (2026-03-12)
- Completed per-project activation system (`/pitchdocs:activate install` / `install strict`)
- Installable rules: `doc-standards.md`, `docs-awareness.md` moved from `.claude/` to source templates
- Installable agent: `docs-freshness.md` read-only freshness checker (per-project)
- Strict tier: optional `content-filter-guard.sh` hook for Claude Code
- Fully backwards-compatible — all 15 commands work globally regardless of activation tier

### v2.0.0 (2026-03-11)
- **Breaking**: Split AI context management into [ContextDocs](https://github.com/littlebearapps/contextdocs) — stub redirects remain for `/pitchdocs:ai-context` and `/pitchdocs:context-guard`
- Added 6 automated CI checks (spell check, frontmatter validation, llms.txt consistency, banned phrases, orphan detection, token budgets)
- Added skill activation eval framework with 21 test cases — 95.2% accuracy on Haiku
- Split 4 over-budget skills into companion reference files for token budget compliance
- Added comprehensive documentation: getting-started tutorial, workflow guides, launch artifacts, ROADMAP

### v1.19.3 (2026-03-09)
- Integrated website notification into release-please workflow

### v1.19.2 (2026-03-09)
- Resolved Context Guard false positives and added Untether session detection
- Replaced demo screenshot TODO with showcase gallery
- Added website accuracy audit against v1.19.1

### v1.19.1 (2026-03-09)
- Reduced `/readme` context overhead by 72% for small projects
- Regenerated llms-full.txt with slimmed skills and reference files

### v1.19.0 (2026-03-09)
- Reduced auto-loaded context by 41% and fixed stale counts across docs
- Resolved false-positive broken path warnings in drift check hook

### v1.18.0 (2026-03-09)
- Added dark mode logo support and demo screenshot placeholder
- Extracted on-demand skills from auto-loaded rules for 56% context token reduction ([#28](https://github.com/littlebearapps/pitchdocs/issues/28))

### v1.17.0 (2026-03-08)
- Added Signal Gate principle, lifecycle commands, and context health scoring ([#25](https://github.com/littlebearapps/pitchdocs/issues/25))

### v1.16.0 (2026-03-07)
- Added auto-memory (MEMORY.md) accommodations to AI context guidance ([#24](https://github.com/littlebearapps/pitchdocs/issues/24))
- Added root-level SKILL.md for directory submissions

### v1.15.0 (2026-03-06)
- Added two-tier context doc enforcement to Context Guard
- Added user benefits extraction with persona inference and docs-awareness rule

### v1.14.0 (2026-03-05)
- Added GitLab and Bitbucket platform support

---

## 🔮 Upcoming Milestones

### v2.3 — Automation & Polish (Q2 2026)

- [ ] Auto-update docs on release — trigger `/pitchdocs:doc-refresh` when version tags are created
- [ ] GitHub Actions template for scheduled doc refreshes
- [ ] Enhanced content filter mitigation — reduce need for chunked writes on legal templates
- [ ] Skill quality benchmarking in CI — track A/B comparison scores over time

### v3.0 — Expansion (Q3 2026)

- [ ] Multi-language README support — generate localized docs for i18n projects
- [ ] Interactive README builder — REPL-style step-by-step Q&A for custom documentation
- [ ] Blog post generator — auto-extract Dev.to, Medium, Hashnode-ready content from README
- [ ] Jira / Linear integration — pull roadmap data from issue tracking platforms
- [ ] API reference direct integration — complete `/pitchdocs:api-reference` with API doc linking

### v4.0+ — Community Features (Beyond 2026)

- [ ] Gitea, Forgejo, and Sourcehut platform support
- [ ] GitHub discussion template generator
- [ ] Expand user benefits extraction to industry-specific personas (DevOps, ML ops, data science)
- [ ] Integration tests for all 9 supported AI tools (Claude Code, OpenCode, Codex, Cursor, Gemini, Windsurf, Cline, Aider, Goose)

---

## 🤝 How to Get Involved

### Report Issues

Found a bug or have a feature request? [Open an issue](https://github.com/littlebearapps/pitchdocs/issues) — all feedback is valuable.

### Start Small

Looking for your first contribution? Check out [good first issues](https://github.com/littlebearapps/pitchdocs/issues?q=is:open+label:good%20first%20issue) — these are scoped for new contributors and have clear acceptance criteria.

### Improve Documentation

- Help test PitchDocs on your own projects — report edge cases or improvements
- Contribute to [guides](docs/guides/) for other AI tools
- Improve examples in skills or commands

### Become a Maintainer

Interested in deeper involvement? See [CONTRIBUTING.md](CONTRIBUTING.md) for the full contributor guide, code review process, and commit conventions.

---

## 📊 Metrics

| Metric | Current | Target |
|--------|---------|--------|
| Plugin version | 2.1.0 | 3.0.0 (2026) |
| Auto-loaded context | ~500 tokens | <1,000 tokens |
| Skills exceeding 2k token limit | 2 | 0 |
| Supported platforms | 3 (GitHub, GitLab, Bitbucket) | 6+ by v4.0 |
| AI tool compatibility | 9 (including stubs) | 12+ |
| Activation eval test coverage | 21 scenarios (95.2% Haiku) | 30+ |
| Generated doc types | 20+ | 25+ |

---

## 📞 Questions?

- **Getting started:** See [Getting Started Guide](docs/guides/getting-started.md)
- **Troubleshooting:** See [Troubleshooting Guide](docs/guides/troubleshooting.md)
- **Contribution:** See [CONTRIBUTING.md](CONTRIBUTING.md)
- **Support:** See [SUPPORT.md](SUPPORT.md)

Last updated: 2026-03-14
