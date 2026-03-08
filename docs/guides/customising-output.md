---
title: "Customising PitchDocs Output"
description: "Steer PitchDocs output with prompt patterns, tone control, monorepo support, and iterative refinement."
type: how-to
difficulty: intermediate
last_verified: "1.14.0"
related:
  - guides/concepts.md
  - guides/command-reference.md
  - guides/workflows.md
order: 4
---

# Customising PitchDocs Output

> **Summary**: Learn how to steer PitchDocs output — prompt patterns, tone control, monorepo support, and iterative refinement.

PitchDocs generates documentation based on its quality standards and frameworks. This guide explains how to steer the output to match your project's needs.

---

## Prompt Patterns

Every PitchDocs command accepts natural language arguments that guide what it generates. Use these patterns to focus output on specific areas.

### Focus on a section

```
/pitchdocs:readme focus on the comparison table
/pitchdocs:readme focus on the quickstart section
/pitchdocs:readme focus on badges and credibility signals
```

### Target a specific audience

```
/pitchdocs:readme for a technical audience familiar with TypeScript
/pitchdocs:readme for non-technical stakeholders
/pitchdocs:user-guide for DevOps engineers setting up CI/CD
```

### Iterate on existing output

Run commands multiple times with different focus areas:

```
/pitchdocs:readme                              # First pass — full generation
/pitchdocs:readme improve the features section # Second pass — refine specific section
/pitchdocs:readme add a comparison with Tool X # Third pass — add competitive positioning
```

PitchDocs reads existing content before generating, so each pass refines rather than replaces.

---

## Controlling Tone

PitchDocs defaults to professional-yet-approachable, benefit-driven language. Adjust by describing the tone you want:

```
/pitchdocs:readme with a formal, enterprise tone
/pitchdocs:readme keep it casual and developer-friendly
/pitchdocs:readme minimal marketing — focus on technical accuracy
```

**What you can't override:** The 4-question test (Does this solve my problem? Can I use it? Who made it? Where do I learn more?) is always applied. Every feature claim still requires code evidence. These are structural quality standards, not tone.

---

## Monorepo Support

Point commands at specific packages rather than the repo root:

```
/pitchdocs:readme packages/api
/pitchdocs:features packages/ui
/pitchdocs:docs-audit packages/shared
/pitchdocs:user-guide packages/cli
```

Each package can have its own independent documentation set. PitchDocs scans only the targeted directory's manifest files, source code, and git history.

---

## Working with Quality Rules

PitchDocs enforces three quality rules automatically (in Claude Code). Understanding them helps you work with the system rather than against it.

### doc-standards

The core quality framework. Enforces:
- **4-question test** — every doc must answer: Does this solve my problem? Can I use it? Who made it? Where do I learn more?
- **Progressive disclosure** (Lobby Principle) — README is the lobby, not the building. Detailed content goes in separate docs.
- **Feature-to-benefit language** — every feature claim needs evidence (file path, function, config option)
- **Visual structure** — emoji heading prefixes, horizontal rules between sections, consistent badge ordering

If PitchDocs generates content you find overly structured, it's following these rules. You can ask it to simplify:

```
/pitchdocs:readme without emoji headings
/pitchdocs:readme shorter features section — max 5 items
```

### context-quality (Claude Code only)

Ensures AI context files (AGENTS.md, CLAUDE.md, etc.) stay consistent with each other and with the actual codebase. Checks file paths, command lists, and version numbers.

### content-filter (Claude Code only)

Guides PitchDocs around Claude's content filter. You don't need to interact with this directly — it prevents HTTP 400 errors automatically. See [Troubleshooting](troubleshooting.md) if you hit content filter issues.

---

## Output Formats for Features

The `/pitchdocs:features` command supports multiple output formats:

```
/pitchdocs:features              # Structured inventory (Hero / Core / Supporting tiers)
/pitchdocs:features table        # | Feature | Benefit | Status | table format
/pitchdocs:features bullets      # Emoji+bold+em-dash bullet format
/pitchdocs:features benefits     # User benefits for "Why?" section (auto-scan or "talk it out")
/pitchdocs:features audit        # Gap analysis: documented vs actual
```

Choose the format that matches where you'll paste the output. `table` works well for comparison sections; `bullets` works well for features lists; `benefits` generates bold-outcome bullets for a "Why [Project]?" section — choose auto-scan for a quick draft or conversational for authentic, developer-driven benefits.

---

## Selective Refresh

After a release, you don't always need to refresh everything. Target specific areas:

```
/pitchdocs:doc-refresh plan              # Dry run — see what needs updating
/pitchdocs:doc-refresh changelog         # Only CHANGELOG.md
/pitchdocs:doc-refresh readme            # Only README.md features and metrics
/pitchdocs:doc-refresh guides            # Only affected user guides
/pitchdocs:doc-refresh context           # Only AI context files and llms.txt
/pitchdocs:ai-context update             # Patch only what drifted (preserves human edits)
/pitchdocs:ai-context promote            # Move stable MEMORY.md patterns to CLAUDE.md
/pitchdocs:doc-refresh release-notes     # Only GitHub release body
```

Use `/pitchdocs:doc-refresh plan` first to see what changed, then refresh selectively.

---

## Before/After Example

Here's what PitchDocs transforms. A typical developer-written feature line:

```
- Supports WebSocket connections
```

Becomes benefit-driven language with evidence:

```
- 📡 **Real-time streaming** — push updates to connected clients via WebSocket
  so you can build live dashboards without polling — see `src/ws/handler.ts`
```

The transformation applies the feature-to-benefit pattern: `[Feature] so you can [outcome] — [evidence]`.

---

**See also:** [Concepts](concepts.md) for the frameworks behind PitchDocs output, [Command Reference](command-reference.md) for full argument details.
