# Roadmap

**Mission:** Turn any codebase into professional, marketing-ready repository documentation — powered by AI coding assistants.

PitchDocs is a pure Markdown plugin with 16 skills, 3 adaptive agents, 3 auto-loaded quality rules, 14+ commands, and 20 evaluation test cases. This roadmap outlines completed work, current priorities, and future directions.

---

## 🎯 Current Focus

### Context Token Optimisation

We're reducing context overhead to improve performance for all users — especially those running PitchDocs alongside other plugins.

- **Auto-loaded rules overspend** ([#36](https://github.com/littlebearapps/pitchdocs/issues/36)) — 3 rules total ~2,613 tokens vs ~1,500 target. Plan: split `doc-standards.md` into auto-loaded summary + on-demand skill to bring overhead down to ~1,554 tokens
- **Skills exceed individual budgets** ([#37](https://github.com/littlebearapps/pitchdocs/issues/37)) — 6 skills exceed ~2,000-token limit: `user-guides` (~3,969), `docs-verify` (~3,850), `pitchdocs-suite` (~3,227), `package-registry` (~2,968), `doc-refresh` (~2,453), `launch-artifacts` (~2,286). Plan: delegate reference content to companion files, trim redundant examples, or split into core + extended modules

### Upstream Specification Drift

**Contributor Covenant** ([#12](https://github.com/littlebearapps/pitchdocs/issues/12)) — pinned v3.0, latest is v2.1. Needs review and re-pinning in `upstream-versions.json`.

---

## ✅ Recently Completed

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

- [ ] Expand skill evaluation test suite (currently 20 scenarios)
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
| Auto-loaded context | ~2,613 tokens | ~1,500 tokens |
| Skills exceeding 2k token limit | 6 | 0 |
| Supported platforms | 3 (GitHub, GitLab, Bitbucket) | 6+ |
| AI tool compatibility | 9 | 12+ |
| Generated doc types | 20+ | 25+ |

---

## 📞 Questions?

- **Getting started:** See [Getting Started Guide](docs/guides/getting-started.md)
- **Troubleshooting:** See [Troubleshooting Guide](docs/guides/troubleshooting.md)
- **Support:** See [SUPPORT.md](SUPPORT.md)

Last updated: 2026-03-10
