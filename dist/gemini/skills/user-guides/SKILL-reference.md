# User Guide Reference

Companion file for the `user-guides` skill. Contains frontmatter field specifications, title conventions, and video/screencast guidance. Load this file when you need metadata details for guide files.

---

## Guide Frontmatter

Every documentation file in `docs/` should include YAML frontmatter for metadata, navigation, and cross-referencing. This enables hub page generation, related article linking, and docs-verify validation.

### Required Fields

```yaml
---
title: "Getting Started with PitchDocs"
description: "Install PitchDocs, generate your first README, and explore all 16 commands."
type: how-to          # tutorial | how-to | reference | explanation
---
```

### Optional Fields

```yaml
---
difficulty: beginner   # beginner | intermediate | advanced
time_to_complete: "5 minutes"
last_verified: "1.11.0"  # Product version this guide was last verified against
related:
  - guides/workflows.md
  - guides/command-reference.md
order: 1               # Sort position within its type for hub page listings
---
```

**Field descriptions:**
- `title` — matches the H1 heading; used in hub page tables and llms.txt
- `description` — one-sentence summary; used in hub page and search
- `type` — Diataxis quadrant classification (determines structural expectations)
- `difficulty` — reader skill level; displayed in hub page if present
- `time_to_complete` — estimated reading or completion time
- `last_verified` — the product version against which this guide was last tested
- `related` — paths to related documents (relative to `docs/`); used for "What's Next?" sections and cross-referencing
- `order` — numeric sort position within its type grouping on the hub page

**Rules:**
- All three required fields (`title`, `description`, `type`) must be present
- `type` must be exactly one of: `tutorial`, `how-to`, `reference`, `explanation`
- `related` paths must point to files that exist on disk
- `last_verified` should be updated when a guide is re-tested against a new version

## Title Conventions

Use consistent title patterns per document type:

| Doc Type | Pattern | Example |
|----------|---------|---------|
| Tutorial | "Build Your First [Thing]" | "Build Your First API" |
| How-to | "[Task] Guide" or "How to [Task]" | "Deployment Guide" |
| Reference | "[Subject] Reference" | "CLI Reference" |
| Explanation | "How [Project] [Concept]" or "Why [Decision]" | "How PitchDocs Thinks" |

**Rules:**
- The H1 heading must match the `title` frontmatter field exactly
- Keep titles under 60 characters for readability in navigation
- Use the project name in the title when the guide is project-specific ("Getting Started with PitchDocs"), omit it for generic tasks ("Deployment Guide")
- Task-oriented titles for how-to guides; concept-oriented titles for explanations

## Video and Screencast Placeholders

When a guide involves CLI interaction or multi-step UI workflows, suggest terminal recording placement:

```markdown
### Demo

<!-- Terminal recording: Run `asciinema rec` before starting, `asciinema upload` when done -->
<!-- Suggested recording: Steps 1-3 (install, configure, verify) in a single session -->
<!-- Alternative: Record a 30-second GIF with `terminalizer` or `vhs` -->

Watch the [terminal recording](link) to see the full setup flow.
```

**When to suggest recordings:**
- Getting started guides (always)
- Guides with 5+ CLI steps
- Guides involving interactive prompts or TUI interfaces
- Migration guides where the before/after is instructive
