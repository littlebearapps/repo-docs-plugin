# Roadmap

**Mission:** Turn any codebase into professional, marketing-ready repository documentation — powered by AI coding assistants.

PitchDocs is a pure Markdown plugin with 16 skills, 4 agents (3 pipeline + 1 per-project freshness checker), 1 auto-loaded rule + 2 installable rules, 16 commands (14 active + 2 stubs), and 21 evaluation test cases. This roadmap outlines completed work, current priorities, and future directions.

---

## 🎯 Current Focus

### Context Token Optimisation

We're reducing context overhead to improve performance for all users — especially those running PitchDocs alongside other plugins.

- **Auto-loaded rules overspend** ([#36](https://github.com/littlebearapps/pitchdocs/issues/36)) — ✅ Resolved in v2.0.0: moved `doc-standards.md` and `docs-awareness.md` to per-project installable rules via `/pitchdocs:activate`. Only `content-filter.md` remains auto-loaded (~500 tokens)
- **Skills exceed individual budgets** ([#37](https://github.com/littlebearapps/pitchdocs/issues/37)) — ✅ Partially resolved: 4 of 6 skills split into companion reference files (`docs-verify`, `package-registry`, `pitchdocs-suite`, `user-guides`). Remaining 2 (`doc-refresh` ~2,453, `launch-artifacts` ~2,286) accepted as near-budget

### Upstream Specification Drift

**Contributor Covenant** ([#12](https://github.com/littlebearapps/pitchdocs/issues/12)) — pinned v3.0, latest is v2.1. Needs review and re-pinning in `upstream-versions.json`.

---

## ✅ Recently Completed

### v2.0.0 (2026-03-11)
- **Breaking**: Split AI context management into [ContextDocs](https://github.com/littlebearapps/contextdocs) — stub redirects remain for `/pitchdocs:ai-context` and `/pitchdocs:context-guard`
- Added 6 automated CI checks (spell check, frontmatter validation, llms.txt consistency, banned phrases, orphan detection, token budgets)
- Added skill activation eval framework with 21 test cases — 95.2% accuracy on Haiku
- Added per-project activation (`/pitchdocs:activate`) for advisory features (rules, freshness agent, content filter hook)
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

## 🔮 Future Directions

### Documentation Quality

- [ ] Enhance GEO optimisation patterns for AI citation across more doc types
- [ ] Add per-tool AI context guides for platforms beyond Claude Code, OpenCode, and Codex
- [ ] Expand user benefits extraction to support industry-specific personas (DevOps, data science, ML ops)

### Feature Coverage

- [ ] Support for generating GitHub discussion templates
- [ ] Issue template generation with auto-categorisation (bug, feature, docs)
- [ ] PR review checklist generation from CONTRIBUTING.md
- [ ] API reference documentation generation (TypeDoc, Sphinx, godoc, rustdoc integration)

### Platform Expansion

- [ ] Gitea support (self-hosted Git alternative)
- [ ] Forgejo support (community-driven Gitea fork)
- [ ] Sourcehut support (minimalist Git forge)

### Testing & Validation

- [ ] Expand skill evaluation test suite (currently 24 scenarios, 95.2% on Haiku)
- [ ] Add integration tests for multi-tool compatibility (Cursor, Windsurf, Cline, Gemini CLI, Aider, Goose)
- [ ] Benchmark quality improvements from v1.18 context reduction on larger codebases

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
| Auto-loaded context | ~500 tokens | ~1,500 tokens |
| Skills exceeding 2k token limit | 2 | 0 |
| Supported platforms | 3 (GitHub, GitLab, Bitbucket) | 6+ |
| AI tool compatibility | 9 | 12+ |
| Generated doc types | 20+ | 25+ |

---

## 📞 Questions?

- **Getting started:** See [Getting Started Guide](docs/guides/getting-started.md)
- **Troubleshooting:** See [Troubleshooting Guide](docs/guides/troubleshooting.md)
- **Support:** See [SUPPORT.md](SUPPORT.md)

Last updated: 2026-03-12
