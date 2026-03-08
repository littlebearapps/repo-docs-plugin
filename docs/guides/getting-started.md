---
title: "Getting Started with PitchDocs"
description: "Install PitchDocs, generate your first README, and explore all 13 commands."
type: how-to
difficulty: beginner
time_to_complete: "5 minutes"
last_verified: "1.14.0"
related:
  - guides/workflows.md
  - guides/command-reference.md
  - guides/customising-output.md
order: 1
---

# Getting Started with PitchDocs

> **Summary**: Install PitchDocs, generate your first README, and explore all 13 commands.

**Time to Hello World:** Under 60 seconds for your first README. Full walkthrough below: ~5 minutes.

## Prerequisites

- [Claude Code](https://code.claude.com/) or [OpenCode](https://opencode.ai/) installed
- A project repository you want to document

> **Using a different AI tool?** PitchDocs also works with Codex CLI, Cursor, Windsurf, Cline, Gemini CLI, Aider, and Goose. See [Use with Other AI Tools](../../README.md#-use-with-other-ai-tools) for setup instructions.

---

## 1. Install PitchDocs

Open Claude Code in your terminal and run:

```bash
# Add the LBA plugin marketplace (once per machine)
/plugin marketplace add littlebearapps/lba-plugins

# Install PitchDocs
/plugin install pitchdocs@lba-plugins
```

**Verify it worked:** The skills and commands are loaded automatically. You should see PitchDocs skills available when you start a new session.

**Note:** When installed as a plugin, all commands use the `pitchdocs:` prefix (e.g., `/pitchdocs:readme`). The short form `/readme` only works inside the pitchdocs source directory.

---

## 2. Generate Your First README

Navigate to the project you want to document, then run:

```bash
/pitchdocs:readme
```

PitchDocs will:
1. Scan your codebase (manifest files, project structure, git history)
2. Extract features with file-level evidence across 10 signal categories
3. Translate features into benefit-driven language
4. Generate a README.md with a hero section, quick start, features table, and proper badges

**Tip:** If a README.md already exists, PitchDocs reads it first and improves it rather than overwriting from scratch.

---

## 3. Audit Your Documentation

Check what other docs your project needs:

```bash
/pitchdocs:docs-audit
```

This scans your repo against a 20+ file checklist across 3 priority tiers and reports what's missing. To auto-generate everything that's missing in one go:

```bash
/pitchdocs:docs-audit fix
```

---

## 4. Extract Features

See what PitchDocs detects in your codebase:

```bash
# Full feature inventory with evidence
/pitchdocs:features

# Output as a benefits table for your README
/pitchdocs:features table

# Output as emoji+bold+em-dash bullets
/pitchdocs:features bullets

# Extract user benefits for a "Why?" section (auto-scan or conversational)
/pitchdocs:features benefits

# Audit: compare what's documented vs what's in the code
/pitchdocs:features audit
```

---

## 5. Generate Individual Docs

Use any command on its own for specific doc types:

```bash
/pitchdocs:changelog          # CHANGELOG.md from git history
/pitchdocs:roadmap            # ROADMAP.md from GitHub milestones
/pitchdocs:user-guide         # User guides in docs/guides/
/pitchdocs:llms-txt           # llms.txt for AI discoverability
/pitchdocs:ai-context init    # Bootstrap AGENTS.md, CLAUDE.md, .cursorrules, and 4 more (Signal Gate filtered)
/pitchdocs:ai-context update  # Patch only what drifted since last update
/pitchdocs:docs-verify        # Validate links, freshness, and consistency
/pitchdocs:launch             # Dev.to articles, HN posts, Reddit posts, Twitter threads
```

---

## 6. Verify Everything

Before shipping your docs, run the verification suite:

```bash
/pitchdocs:docs-verify
```

This checks for:
- Broken internal and external links (with case-sensitivity and fragment validation)
- Stale content (files not updated in 90+ days)
- llms.txt sync (all referenced files exist)
- Heading hierarchy issues (no level skipping)
- Badge URL validity
- Security issues (leaked credentials, internal paths, internal hostnames)
- AI context health (line budgets, discoverable content, stale paths, cross-file consistency)
- Quality score (0–100 across 5 dimensions with A–F grade bands)
- Token budget compliance (skill files within size targets)

---

## 7. Install Context Guard Hooks (Optional, Claude Code Only)

Context Guard adds three hooks to your project that run automatically during your Claude Code sessions:

```bash
/pitchdocs:context-guard install
```

What it installs:

- **Drift detection** — warns after commits if AI context files (AGENTS.md, CLAUDE.md) are stale
- **Structural change reminders** — nudges you to update context files when you modify commands, skills, or config
- **Content filter guard** — prevents content filter errors (HTTP 400) by intercepting Write operations on files like CODE_OF_CONDUCT.md, LICENSE, and SECURITY.md, advising you to fetch them from canonical URLs instead

Check status anytime with `/pitchdocs:context-guard status`. Uninstall with `/pitchdocs:context-guard uninstall`.

**Note:** These hooks are Claude Code-specific. If your team uses OpenCode or Codex CLI alongside Claude Code, the hooks are silently ignored by those tools.

---

## What's Next?

- **Manage AI context files** — Run `/pitchdocs:ai-context init` to bootstrap all 7 context files, or `update` to patch only what drifted. Use `promote` to move stable patterns from Claude's auto-memory to CLAUDE.md for the whole team.
- **Improve your README further** — Run `/pitchdocs:readme` again with specific focus areas (e.g., `/pitchdocs:readme focus on the comparison table`)
- **Check your quality score** — Run `/pitchdocs:docs-verify score` to get a numeric rating and actionable suggestions for improvement
- **Set up CI verification** — The `/pitchdocs:docs-verify` command outputs CI-friendly results for GitHub Actions
- **Launch your project** — Run `/pitchdocs:launch` to generate Dev.to articles, Hacker News posts, and awesome list submissions
- **Explore skills** — Each command loads specialised reference knowledge. See the [Available Skills](../../AGENTS.md#available-skills) table for the full inventory.

---

**Need help?** See [SUPPORT.md](../../SUPPORT.md) for getting help, common questions, and contact details.
