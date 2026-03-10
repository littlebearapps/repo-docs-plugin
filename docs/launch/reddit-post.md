# Reddit Post Templates

## r/programming (Primary)

**Post type:** Link post (preferred on r/programming)

**Title:**
```
PitchDocs: Generate professional documentation from your codebase with AI
```

**URL:** `https://github.com/littlebearapps/pitchdocs`

**First comment (reply to your post immediately after submission):**

```
Author here. I built this because most open source projects ship with thin,
generic documentation that doesn't sell the project or help users get started.

PitchDocs scans your codebase (10 signal categories — exports, CLI commands,
API endpoints, config, integrations, etc.) and generates professional docs
automatically. One command generates a marketing-ready README. Another generates
all supporting docs — CHANGELOG, ROADMAP, CONTRIBUTING, user guides, security
policies.

Technical highlights:

- Evidence-based feature extraction (every claim traces to code)
- GEO optimised for LLM citation (ChatGPT, Perplexity will cite your project)
- Quality scoring (0–100) to verify doc completeness and freshness
- Works with 9 AI tools (Claude Code, OpenCode, Cursor, Codex, Windsurf, etc.)
- Pure Markdown plugin — zero runtime dependencies, 100% portable

Built as a Claude Code plugin. Feedback on the extraction patterns or quality
scoring welcome!

Repo: https://github.com/littlebearapps/pitchdocs
```

---

## r/webdev (Secondary)

**Post type:** Self-post (optional, can be text or link)

**Title:**
```
I built PitchDocs: AI-powered documentation generation for open source (and your projects)
```

**Body:**

```
TL;DR: PitchDocs is a Claude Code/OpenCode plugin that generates professional
README, CHANGELOG, contributing guides, and more by scanning your codebase.

The problem: Writing good documentation is *hard*. Most projects ship with thin,
generic docs. Great code dies from poor documentation.

The solution: PitchDocs uses an AI coding assistant (Claude, now integrated into
Claude Code and OpenCode) to scan your codebase and extract what's valuable. Then
it generates professional, marketing-friendly documentation that actually sells
your project.

Key features:

✅ Evidence-based feature extraction (10 signal categories)
✅ Professional doc standards built in (4-question test, lobby principle, Time to Hello World)
✅ GEO optimised for AI citation (ChatGPT will cite your project correctly)
✅ Quality scoring (0–100) to verify completeness and freshness
✅ Works with any AI tool (Claude Code, OpenCode, Cursor, Codex CLI, Windsurf, etc.)
✅ Pure Markdown plugin — portable, no runtime dependencies

One command generates a marketing-ready README:
```
/pitchdocs:readme
```

One command generates all docs:
```
/pitchdocs:docs-audit fix
```

Check out the repo to see examples of PitchDocs-generated docs on Untether,
Outlook Assistant, and PitchDocs itself:

https://github.com/littlebearapps/pitchdocs

Feedback welcome! Especially curious about the quality scoring system and
extraction patterns.
```

---

## r/opensource (Tertiary)

**Post type:** Self-post (focus on contribution opportunities and community)

**Title:**
```
PitchDocs: Help us build the ultimate AI-powered documentation plugin for open source
```

**Body:**

```
Hi r/opensource,

I'm building PitchDocs, a Claude Code and OpenCode plugin that helps open source
teams write professional documentation automatically.

The idea: Most maintainers are great at building software but dread writing docs.
PitchDocs changes that by letting an AI assistant scan your codebase, extract
what's valuable, and generate professional README, CHANGELOG, user guides, and
more in minutes instead of days.

Current features:

- Evidence-based feature extraction from 10 code signal categories
- README generation with the Banesullivan 4-question framework
- CHANGELOG generation from git history (user benefit language)
- ROADMAP generation from GitHub milestones and issues
- User guide generation with Diataxis classification
- Quality scoring (0–100) across completeness, freshness, and link health
- Platform support for GitHub, GitLab, and Bitbucket

We're looking for:

👥 Contributors to improve extraction patterns and doc templates
🔍 Feedback on the quality scoring system
📝 Ideas for new documentation types we should support
🧪 Testing on diverse project types (libraries, CLIs, web apps, APIs, plugins)

If you're interested in helping open source documentation get better, we'd love
to collaborate:

Repo: https://github.com/littlebearapps/pitchdocs
Good First Issues: https://github.com/littlebearapps/pitchdocs/labels/good%20first%20issue
Contributing Guide: https://github.com/littlebearapps/pitchdocs/blob/main/CONTRIBUTING.md

Thanks!
```

---

## Reddit Posting Rules

- **Don't post simultaneously** — space posts 24+ hours apart
- **Read each subreddit's rules** — some ban self-promotion or require specific formats
- **Engage genuinely in comments** — reply to every comment within the first 2–4 hours
- **Max 2–3 subreddits** — more than that looks like spam
- **No deleted accounts** — account should have history and be in good standing
- **Post during peak hours** — evening (5–9 PM) for US-based subreddits

## Timing Recommendation

1. **Post to r/programming first** (Monday–Wednesday, 7–9 PM ET)
2. **Wait 24–36 hours**
3. **Post to r/webdev** (next day, similar time)
4. **Wait 24 hours**
5. **Post to r/opensource** (if interested in attracting contributors)
