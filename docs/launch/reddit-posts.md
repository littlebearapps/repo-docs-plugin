# Reddit Post Templates

## r/programming

**Post Type:** Link post

**Title:**
```
PitchDocs: Generate production documentation from your codebase with AI
```

**URL:**
```
https://github.com/littlebearapps/pitchdocs
```

**First Comment (author context):**
```
Author here. I built this because every project I shipped had solid code but mediocre docs — and writing professional README, CHANGELOG, CONTRIBUTING, and SECURITY files felt like a separate job.

PitchDocs does the heavy lifting: scans your codebase for what's worth documenting (10 signal categories), extracts features with evidence (every claim traces to code), and generates the entire docs suite in one command.

Key features:
- Evidence-based feature extraction — no hallucinations, every claim links to a file path
- Full docs suite (README, CHANGELOG, CONTRIBUTING, ROADMAP, SECURITY, issue templates, user guides, llms.txt) from one command
- GEO-optimised for AI systems (ChatGPT, Perplexity, Google AI) to cite accurately
- Quality scoring (0–100) to catch broken links, stale content, and missing evidence before shipping
- Works with 9 AI tools (Claude Code, OpenCode, Cursor, Windsurf, Gemini CLI, Cline, Codex CLI, Aider, Goose)
- Markdown-based — zero runtime dependencies, portable across tools
- Auto-detects GitHub, GitLab, or Bitbucket

Built with evidence extraction heuristics + professional doc standards (4-question framework, Lobby Principle, measurable Time to Hello World).

Feedback welcome, especially on the feature extraction accuracy or how we handle different project types (CLI, library, framework, web app, etc.).
```

**Posting strategy:** Post once, engage deeply in comments. Don't spam other subreddits immediately after.

---

## r/webdev

**Post Type:** Self-post

**Title:**
```
I built PitchDocs to automate professional documentation for my projects — now it's open source
```

**Body:**
```
# PitchDocs

[Problem] Every project I shipped had good code but mediocre documentation. Writing a professional README, CHANGELOG, contributing guidelines, and security policies felt like a full day of work — and often got cut for "later."

[Solution] PitchDocs is a Claude Code / OpenCode plugin that scans your codebase and generates the entire docs suite:

- README (marketing-friendly, with evidence-based features)
- CHANGELOG (from git history, with user-benefit language)
- CONTRIBUTING (templated with project-specific patterns)
- ROADMAP (from GitHub milestones)
- SECURITY.md (guided generation)
- Issue and PR templates
- User guides for the docs site
- llms.txt (for AI discoverability)

## How It Works

```bash
/pitchdocs:readme              # Generate marketing-friendly README
/pitchdocs:docs-audit fix      # Generate everything that's missing
```

Takes 60 seconds. Every feature claim is backed by code evidence.

## Key Features

- **Evidence-based** — every feature traces to actual code (file path, line number, etc.)
- **Multi-tool compatible** — Claude Code, OpenCode, Cursor, Windsurf, Gemini CLI, and more
- **Quality scoring** — automated checks for broken links, stale content, structure, completeness (0–100)
- **Platform support** — auto-detects GitHub, GitLab, or Bitbucket
- **AI-optimised** — structured for ChatGPT and Perplexity to cite accurately

Zero runtime dependencies. 100% Markdown.

## Try It

```bash
/plugin marketplace add littlebearapps/lba-plugins
/plugin install pitchdocs@lba-plugins
/pitchdocs:readme
```

Repo: https://github.com/littlebearapps/pitchdocs

Would love feedback, especially from folks who generate docs frequently or maintain multiple projects.
```

---

## r/opensource

**Post Type:** Self-post

**Title:**
```
PitchDocs – Open source plugin for AI-powered documentation generation [MIT, 9-tool compatible]
```

**Body:**
```
# PitchDocs

**What:** A Claude Code / OpenCode plugin that generates production-ready documentation suites from your codebase.

**Why:** Great code deserves great docs, but writing professional README, CHANGELOG, contributing guidelines, security policies, and guides is time-consuming boilerplate — and it often gets deprioritised.

**How:** Scan codebase → extract evidence-based features → generate docs following professional standards (4-question framework, Lobby Principle, GEO optimisation).

One command (`/pitchdocs:docs-audit fix`) generates:
- README with marketing-friendly copy
- CHANGELOG from git history (user-benefit language)
- CONTRIBUTING with project-specific patterns
- ROADMAP from GitHub milestones
- SECURITY.md
- Issue and PR templates
- User guides (Diataxis framework)
- llms.txt (AI discoverability)

## Features

- **Evidence-based** — every feature claim links to code
- **Multi-tool** — Claude Code, OpenCode, Cursor, Windsurf, Gemini CLI, Cline, Codex CLI, Aider, Goose
- **Quality-first** — automated scoring (0–100), broken link detection, freshness checks
- **Cross-platform** — GitHub, GitLab, Bitbucket (with platform-adapted badges, URLs, CI config)
- **Zero dependencies** — pure Markdown, portable

## Contribution Opportunities

We're looking for help with:
- **Feature signal detection** — improving heuristics for different project types (CLI, library, framework, web app)
- **Documentation standards** — refining the 4-question test and Lobby Principle for different ecosystems
- **Platform support** — extending to Gitea, Gitee, or other Git hosts
- **Multi-language support** — extending beyond English (Australian English currently supported)
- **Awesome list submissions** — drafting submission PRs for relevant directories

[Good First Issues](https://github.com/littlebearapps/pitchdocs/labels/good%20first%20issue) available for onboarding contributors.

**Repo:** https://github.com/littlebearapps/pitchdocs
**Docs:** https://github.com/littlebearapps/pitchdocs/blob/main/docs/
**ROADMAP:** https://github.com/littlebearapps/pitchdocs/blob/main/ROADMAP.md

Questions welcome — we're new and actively building!
```

---

## Reddit Posting Strategy

1. **Post r/programming first** (broader audience, more engagement)
2. **Wait 24 hours, post r/webdev** (different audience, different tone)
3. **Wait another 24 hours, post r/opensource** (emphasis on contribution opportunities)
4. **Don't post to multiple subreddits simultaneously** — it looks like spam and violates norm on most tech subreddits
5. **Engage genuinely in all comments** — answer questions, explain design decisions, accept critique
6. **Check subreddit rules before posting** — some ban self-promotion or require disclosures

