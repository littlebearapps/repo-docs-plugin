# Diátaxis Document Templates

Companion file for the `user-guides` skill. Contains structural templates for Diátaxis document types, the docs hub page, copy-paste-ready code examples, troubleshooting guides, error recovery patterns, and Diataxis cross-links. The main skill covers how-to guide structure and the discovery workflow.

Load this file when generating documents in these quadrants.

---

## Tutorial Template

Tutorials are **learning-oriented** — they guide a beginner through a complete experience to build confidence. The reader learns by doing, not by reading theory.

**Key principles:**
- The reader should achieve something **real** and **visible** by the end
- Every step must work — test the entire tutorial path before publishing
- Celebrate milestones ("You should now see..." followed by expected output)
- Explain the minimum necessary to keep moving; defer deep explanations to Explanation docs
- Never assume prior knowledge beyond the stated prerequisites

```markdown
---
title: "Build Your First [Thing]"
description: "A hands-on tutorial that walks you through [outcome] from scratch."
type: tutorial
difficulty: beginner
time_to_complete: "15 minutes"
related:
  - guides/getting-started.md
  - reference/cli.md
  - explanation/architecture.md
---

# Build Your First [Thing]

> **What you'll learn**: By the end of this tutorial, you'll have [concrete, visible outcome — e.g., "a working API that returns JSON from a D1 database"].

## Before You Start

**Prerequisites:**

- [Prerequisite 1] ([install guide](link))
- [Prerequisite 2]
- Completed the [Getting Started guide](../guides/getting-started.md)

**What we'll build:**

A brief description (2–3 sentences) of the end result — what it does, what it looks like, why it matters.

## Step 1: [Set Up the Foundation]

Brief explanation of what this step achieves (1–2 sentences).

\`\`\`bash
command here
\`\`\`

You should see:
\`\`\`
expected output
\`\`\`

## Step 2: [Add the Core Feature]

Brief explanation.

\`\`\`bash
command or code here
\`\`\`

You should see:
\`\`\`
expected output showing progress
\`\`\`

## Step 3: [Connect the Pieces]

Brief explanation.

\`\`\`bash
command or code here
\`\`\`

## Step 4: [Verify Everything Works]

Now let's confirm the full system works end-to-end.

\`\`\`bash
verification command
\`\`\`

You should see:
\`\`\`
expected success output showing the completed thing
\`\`\`

## What You Built

Recap what the reader accomplished (2–3 sentences). Reinforce the key concepts they used — but don't go deep. Link to Explanation docs for the "why".

## What's Next?

- **Extend it**: [Next tutorial](link) — add [next feature] to what you built
- **Understand it**: [Architecture explanation](../explanation/architecture.md) — why it's structured this way
- **Reference it**: [API Reference](../reference/api.md) — all options for the tools you used
- [Back to Docs Hub](../README.md)
```

**Tutorial anti-patterns:**
- Don't explain theory before the reader has done something — motivation comes from achievement
- Don't offer choices ("you could also use X") — tutorials have one path
- Don't skip verification steps — readers need to know they're on track
- Don't reference advanced features that aren't needed for this tutorial

---

## Reference Template

Reference docs are **information-oriented** — they describe the machinery. They are dry, complete, and accurate. The reader arrives knowing what they want to look up.

**Key principles:**
- **Completeness** is the primary virtue — every parameter, every option, every return type
- **Consistency** in structure — every item documented the same way
- **No narrative** — no "why", no opinions, no tutorials mixed in
- Use tables for structured data; use consistent column headings across all reference pages
- Link to relevant How-to Guides for "how do I use this?" questions

```markdown
---
title: "[Subject] Reference"
description: "Complete reference for all [subject] parameters, options, and return types."
type: reference
last_verified: "1.11.0"
related:
  - guides/getting-started.md
  - guides/configuration.md
---

# [Subject] Reference

> **Version**: This reference applies to v[X.Y]. See the [changelog](../../CHANGELOG.md) for version history.

## [Category 1]

### `command-or-function-name`

Brief description (one sentence).

| Parameter | Type | Default | Required | Description |
|-----------|------|---------|----------|-------------|
| `param1` | `string` | — | Yes | What this parameter controls |
| `param2` | `number` | `10` | No | What this parameter controls |
| `param3` | `boolean` | `false` | No | What this parameter controls |

**Returns:** `ReturnType` — description of return value.

**Example:**
\`\`\`bash
command --param1 "value" --param2 20
\`\`\`

---

### `another-command`

Brief description.

| Parameter | Type | Default | Required | Description |
|-----------|------|---------|----------|-------------|
| ... | ... | ... | ... | ... |

---

## [Category 2]

### `another-item`

...

---

## See Also

- [Getting Started Guide](../guides/getting-started.md) — how to use these commands in practice
- [Configuration Guide](../guides/configuration.md) — environment variables and config files
- [Back to Docs Hub](../README.md)
```

**Reference anti-patterns:**
- Don't mix "how to" instructions into reference — link to guides instead
- Don't omit parameters because they're "obvious" — reference must be complete
- Don't use inconsistent table columns across sections — pick a format and stick to it
- Don't include long prose explanations — one sentence per item, link to Explanation docs for depth

---

## Explanation Template

Explanation docs are **understanding-oriented** — they answer "why?" and connect concepts. The reader has already used the software and wants to understand the decisions behind it.

**Key principles:**
- **Context and reasoning** — explain the problem that led to this design
- **Trade-offs** — every design choice has alternatives; acknowledge them
- **No instructions** — don't tell the reader what to do (that's a guide), explain why things are the way they are
- Can include diagrams, analogies, and historical context
- Link to Reference docs for exact specifications; link to Guides for practical steps

```markdown
---
title: "Why [Project] Uses [Approach]"
description: "Design rationale behind [specific architecture decision or concept]."
type: explanation
related:
  - reference/api.md
  - guides/configuration.md
---

# Why [Project] Uses [Approach]

> **TL;DR**: [One-sentence summary of the design decision and its primary benefit.]

## The Problem

What situation or constraint led to this design? What were users experiencing? What technical limitation existed?

(2–3 paragraphs, concrete examples preferred over abstract descriptions)

## The Approach

How does [Project] solve this? What pattern, architecture, or technique was chosen?

(Describe the current design. Include a diagram if the architecture has 3+ interacting components.)

## Alternatives Considered

Why not [Alternative A]? Brief explanation of why it was ruled out.

Why not [Alternative B]? Brief explanation.

(Be fair to alternatives — acknowledge their strengths while explaining why they didn't fit this context.)

## Trade-offs

What did this approach cost? Every design choice has downsides:

- **Pro**: [Benefit of the chosen approach]
- **Pro**: [Another benefit]
- **Con**: [Downside or limitation]
- **Con**: [Another limitation]

## Further Reading

- **Reference**: [API Reference](../reference/api.md) — exact specifications of the system described here
- **Guide**: [Configuration Guide](../guides/configuration.md) — how to customise the behaviour discussed here
- **External**: [Relevant paper, blog post, or specification](link) — the original source for this pattern
- [Back to Docs Hub](../README.md)
```

**Explanation anti-patterns:**
- Don't include step-by-step instructions — that's a guide
- Don't list every parameter — that's a reference
- Don't be defensive about trade-offs — honest analysis builds trust
- Don't write an explanation for every minor implementation detail — only for decisions that users will wonder about

---

## Hub Page Template (docs/README.md)

```markdown
# [Project Name] Documentation

## Getting Started

New to [Project Name]? Start here:

- [Getting Started Guide](guides/getting-started.md) — Installation, setup, and your first [thing]
- [Configuration Guide](guides/configuration.md) — All configuration options explained

## Guides

Step-by-step instructions for common tasks:

| Guide | What You'll Learn |
|-------|-------------------|
| [Getting Started](guides/getting-started.md) | Install, configure, and run your first [thing] |
| [Configuration](guides/configuration.md) | Customise behaviour with environment variables and config files |
| [Deployment](guides/deployment.md) | Deploy to production with CI/CD |
| [Migration](guides/migration.md) | Upgrade from v1.x to v2.x |
| [Troubleshooting](guides/troubleshooting.md) | Common issues and how to fix them |

## API Reference

- [API Documentation](api/README.md)

## Need Help?

- [FAQ](guides/troubleshooting.md#faq)
- [Open a Discussion](link)
- [File an Issue](link)
```

---

## Copy-Paste-Ready Code Examples

Every code block in a guide must be directly executable:

```markdown
### 2. Configure the database

Create a `wrangler.toml` configuration file:

\`\`\`toml
name = "my-api"
compatibility_date = "2024-01-01"

[[d1_databases]]
binding = "DB"
database_name = "my-database"
database_id = "your-database-id"
\`\`\`

**Note:** Replace `your-database-id` with the ID from step 1. You can find it by running `wrangler d1 list`.
```

**Rules:**
- Include import statements — don't assume readers know the package name
- Show expected output after every command
- Use realistic values (not `foo`, `bar`, `test123`) — readers copy-paste and expect real patterns
- If a value must be customised, call it out explicitly after the code block

---

## Troubleshooting Guide Template

```markdown
# Troubleshooting

Common issues and how to resolve them.

## Installation Issues

### Error: `MODULE_NOT_FOUND`

**Cause**: Dependencies not installed or wrong Node.js version.

**Fix**:
\`\`\`bash
rm -rf node_modules
npm install
\`\`\`

If the issue persists, check your Node.js version:
\`\`\`bash
node --version  # Must be 20+
\`\`\`

---

### Error: `EACCES permission denied`

**Cause**: npm global packages installed without proper permissions.

**Fix**:
\`\`\`bash
# Option 1: Use npx instead of global install
npx package-name

# Option 2: Fix npm permissions
# See: https://docs.npmjs.com/resolving-eacces-permissions-errors-when-installing-packages-globally
\`\`\`

---

## Runtime Issues

### [Symptom description]

**Cause**: [Why this happens]

**Fix**:
\`\`\`bash
[solution]
\`\`\`

---

## FAQ

### Q: [Common question]?

**A**: [Clear answer with example if applicable]

---

## Still Stuck?

- Search [existing issues](link)
- [Open a new issue](link) with the `help wanted` label
- [Ask in discussions](link)
```

## Error Recovery Patterns

After each major step, include a collapsible troubleshooting section for common failures:

```markdown
### 3. Start the development server

\`\`\`bash
npm run dev
\`\`\`

You should see:
\`\`\`
Server running at http://localhost:3000
\`\`\`

<details>
<summary><strong>Troubleshooting: Port already in use</strong></summary>

If you see `Error: listen EADDRINUSE :::3000`:

\`\`\`bash
# Find and kill the process using port 3000
lsof -ti:3000 | xargs kill -9
npm run dev
\`\`\`

</details>
```

Use `<details>` for error recovery so it doesn't clutter the happy path. For GitHub-only guides, this collapses neatly; for cross-renderer guides, use a bold inline callout instead.

## Diataxis Cross-Links

Each guide must link to related documents in other Diataxis quadrants:

```markdown
## What's Next?

- **Tutorial**: [Build Your First App](../tutorials/build-first-app.md) — hands-on lesson that builds on this setup
- **Reference**: [CLI Reference](../reference/cli.md) — all flags and options for commands used in this guide
- **Explanation**: [Architecture Overview](../explanation/architecture.md) — understand why the project is structured this way
- [Back to Docs Hub](../README.md)
```
