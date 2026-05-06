---
name: user-guides
description: Generates task-oriented user guides and how-to documentation for a repository. Creates docs/guides/ with step-by-step instructions for common workflows, integrations, and advanced usage. Links guides into README.md and CONTRIBUTING.md. Use when a project needs user-facing how-to documentation beyond the README quickstart.
version: "2.0.0"
---

# User Guide Generator

## Philosophy

User guides answer the question: **"How do I do [specific thing]?"**

They complement the README (which sells and introduces) by providing detailed, task-oriented instructions for users who are already onboard.

## Diataxis Framework

All documentation should be classified into one of four quadrants from the [Diataxis framework](https://diataxis.fr/). Each quadrant serves a different reader need:

| Quadrant | Purpose | Reader State | Directory |
|----------|---------|-------------|-----------|
| **Tutorials** | Learning-oriented lessons | "I want to learn" | `docs/tutorials/` |
| **How-to Guides** | Task-oriented recipes | "I want to do X" | `docs/guides/` |
| **Reference** | Information-oriented lookup | "I need to check Y" | `docs/reference/` or `docs/api/` |
| **Explanation** | Understanding-oriented context | "I want to understand why" | `docs/explanation/` |

**Rules:**
- Classify every document into exactly one quadrant before writing — don't mix tutorial prose with reference tables
- Tutorials walk through a complete learning journey; guides solve a specific task
- Reference docs are dry, accurate, and complete. Explanation docs cover architecture decisions and "why".
- At minimum, provide **How-to Guides** (this skill's primary output) and link to any existing reference docs
- During guide discovery (Step 1), classify each existing doc into a quadrant. Flag any quadrant with zero documents.

See SKILL-reference.md for frontmatter field tables and title conventions.

## Guide Structure

### Directory Layout

```
docs/
├── tutorials/                  # Learning-oriented lessons (Diataxis: Tutorial)
│   └── build-your-first-app.md
├── guides/                     # Task-oriented how-to recipes (Diataxis: How-to)
│   ├── getting-started.md      # First-time setup, expanded quickstart
│   ├── configuration.md        # All config options explained
│   ├── [task-name].md          # One guide per common task
│   └── troubleshooting.md      # Common problems and solutions
├── reference/                  # Information-oriented lookup (Diataxis: Reference)
│   ├── api.md                  # API reference
│   └── cli.md                  # CLI reference
├── explanation/                # Understanding-oriented context (Diataxis: Explanation)
│   └── architecture.md         # Design decisions and architecture
└── README.md                   # Docs index / hub page
```

### docs/README.md (Hub Page)

See SKILL-templates.md for the hub page template.

### Individual Guide Format

Every guide follows this structure (how-to template shown; tutorial, reference, and explanation templates are in `SKILL-templates.md` — ask Claude to load it if needed):

```markdown
---
title: "[Task Name] Guide"
description: "One-sentence summary of what the reader will accomplish."
type: how-to
difficulty: beginner
time_to_complete: "10 minutes"
related:
  - guides/getting-started.md
  - reference/cli.md
---

# [Task Name] Guide

> **Summary**: What you'll accomplish by the end of this guide.

## Prerequisites

- What you need before starting
- Link to getting-started if they haven't done setup

## Steps

### 1. [First Step]

Explanation of what this step does and why.

\`\`\`bash
command here
\`\`\`

Expected output:
\`\`\`
output here
\`\`\`

### 2. [Second Step]

...

### 3. [Verify It Works]

Always end with a verification step so the user knows they succeeded.

\`\`\`bash
verification command
\`\`\`

You should see:
\`\`\`
expected success output
\`\`\`

## What's Next?

- [Related Guide](link) — natural next step
- [Advanced Topic](link) — for power users
- [Back to Docs](../README.md)
```

## Guide Discovery Workflow

### Step 1: Identify What Guides Are Needed

Analyse the project to find:

```bash
# Check existing docs
find docs/ -name "*.md" 2>/dev/null | sort

# Check README for referenced guides that may not exist
grep -oE '\[.*?\]\(docs/[^)]+\)' README.md 2>/dev/null

# Check GitHub issues for common questions
gh issue list --label "question" --state all --limit 30 2>/dev/null
gh issue list --label "help wanted" --state all --limit 30 2>/dev/null

# Check discussions for common topics
gh api repos/{owner}/{repo}/discussions --jq '.[].title' 2>/dev/null | head -20

# Check for configuration files users need to understand
ls *.config.* .env.example wrangler.* tsconfig.* 2>/dev/null
```

### Step 2: Prioritise Guides

Create guides in this order:
1. **Getting Started** — always first, expanded version of README quickstart
2. **Configuration** — if the project has any config files or env vars
3. **Most-asked-about tasks** — based on issues and discussions
4. **Deployment** — if the project is deployed
5. **Migration** — if there have been breaking version changes
6. **Troubleshooting** — compile from closed issues and common errors

### Step 3: Write Guides

For each guide:
1. Read the relevant source code to understand the feature
2. Actually trace the user journey step by step
3. Include exact commands, expected outputs, and error handling
4. Add screenshots or diagrams for complex workflows
5. Cross-link to related guides and the README

### Step 4: Link Into README

Add a `## Documentation` section to README.md with a table linking each guide (title + one-line description) and a "Full documentation: [docs/](docs/README.md)" footer. See SKILL-templates.md for the hub page template.

## Writing Style

- **Task-oriented**: "How to deploy to production" not "Deployment documentation"
- **Numbered steps**: Every guide is a numbered sequence
- **Expected output**: Show what success looks like after each step
- **Error recovery**: After each step, show common failure modes and how to fix them
- **Cross-links**: Every guide links to related guides, Diataxis siblings, and back to the hub
- **Active voice**: "Run the command" not "The command should be run"
- **Consistent spelling**: follow the project's existing language conventions
- **Copy-paste-ready code**: Every code block must be runnable as-is — no `...` placeholders, no incomplete snippets, no "replace with your value" without showing the exact replacement

See SKILL-reference.md for video/screencast placeholder guidance.

See SKILL-templates.md for copy-paste-ready code examples, troubleshooting template, error recovery patterns, and Diataxis cross-links.

## Anti-Patterns

- **Don't dump API reference into guides** — guides are task-oriented, API docs are reference (use Diataxis separation)
- **Don't assume knowledge** — link to prerequisites
- **Don't skip verification steps** — users need to know they succeeded
- **Don't write walls of text** — use code blocks, tables, and short paragraphs
- **Don't orphan guides** — every guide must be linked from README or docs hub
- **Don't mix guide and reference** — keep them in separate Diataxis quadrants
- **Don't use placeholder code** — every code block must be copy-paste-ready with realistic values
- **Don't bury prerequisites in prose** — use a structured prerequisites block (see `doc-standards` GEO section)
- **Don't skip frontmatter** — every guide needs at minimum `title`, `description`, and `type` fields

## Companion Files

- `SKILL-templates.md` — Hub page, how-to code examples, tutorial/reference/explanation templates, troubleshooting, error recovery, Diataxis cross-links
- `SKILL-reference.md` — Frontmatter field tables, title conventions, video/screencast guidance
