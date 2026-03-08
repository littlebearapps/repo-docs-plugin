---
title: "How PitchDocs Thinks"
description: "Design rationale and frameworks behind PitchDocs output — evidence-based features, GEO, 4-question test, Diátaxis, the Lobby Principle, and context drift detection."
type: explanation
difficulty: intermediate
last_verified: "1.14.0"
related:
  - guides/customising-output.md
  - guides/command-reference.md
order: 5
---

# How PitchDocs Thinks

> **TL;DR**: PitchDocs applies 7 documentation frameworks — evidence-based features, feature-to-benefit translation, user benefits extraction, the 4-question test, progressive disclosure, GEO, and Diátaxis — plus the Signal Gate principle for AI context files and context drift detection to keep AI coding assistants in sync with your code.

PitchDocs applies several documentation frameworks to generate consistently high-quality output. Understanding these frameworks helps you steer the tool and evaluate its suggestions.

---

## Evidence-Based Features

PitchDocs never claims a feature exists without proof. Every feature in a generated README traces back to a specific file path, function name, or configuration option in the codebase.

**The 10 signal categories** PitchDocs scans:

| Category | What It Looks For |
|----------|-------------------|
| CLI commands | `bin/`, `package.json#bin`, `src/cli*`, `src/commands/` |
| Public API | `src/index.*`, exports, routes, `.d.ts` files |
| Configuration | `*.config.*`, `.rc` files, schema definitions, `.env.example` |
| Integrations | Dependencies, `.mcp.json`, webhook handlers, event listeners |
| Performance | Cache layers, async/worker patterns, benchmark files |
| Security | OAuth, JWT, API keys, validation, encryption, rate limiting |
| TypeScript / DX | Strict mode, code generation, error messages, debug utilities |
| Testing | Test files, coverage config, CI test steps |
| Extensibility | Plugin systems, middleware chains, hook systems, event emitters |
| Documentation | `docs/`, `examples/`, JSDoc/docstring coverage |

Features are classified into 3 tiers: **Hero** (1–3 standout features), **Core** (4–8 essential capabilities), and **Supporting** (everything else). Only Hero and Core features typically appear in README; Supporting features go in detailed docs.

---

## Feature-to-Benefit Translation

A feature describes what software does. A benefit describes what the user gains. PitchDocs translates every feature into a benefit using this pattern:

```
[Feature] so you can [outcome] — [evidence]
```

**5 benefit categories** — PitchDocs uses at least 3 different categories across any features section:

| Category | User Feels | Example |
|----------|-----------|---------|
| Time saved | "That was fast" | "Generate a full README in under a minute — not an afternoon" |
| Confidence gained | "I trust this" | "Every benefit traces to actual code — no marketing fluff" |
| Pain avoided | "I don't have to worry" | "Never ship a repo with missing docs again" |
| Capability unlocked | "Now I can do something new" | "Scan any codebase and extract its selling points automatically" |
| Cost reduced | "This saves me effort" | "One plugin replaces five separate documentation tools" |

---

## User Benefits (the "Why?" Layer)

Feature benefits answer "What does this do for me?" User benefits answer **"Why should I care?"** — the real-world reasons someone would choose a project over alternatives.

PitchDocs extracts user benefits through two paths:

**Auto-scan (default):** PitchDocs infers 1–2 target personas from code signals (integration surface, execution model, entry points, deploy artifacts), then synthesises outcome-first benefits from Hero features and JTBD emotional/social jobs. A **signal gate** controls the aspiration level — workflow benefits by default ("Deploy without being at your desk"), experiential benefits only when mobile/async/remote signals exist in the code.

**Conversational ("Talk it out"):** The most compelling user benefits come from the developer's lived experience. PitchDocs asks four questions — why you built it, what scenarios it enables, what you'd lose without it, and who else benefits — then enriches your answers with code evidence. In Claude Code, this uses interactive questions; in other tools, the questions are presented as chat prompts.

**The output pattern:**
```
**[Bold user outcome]** — [mechanism/how it works]. [Constraint if needed].
```

**Anti-fluff rules:** Every user benefit requires a specific context ("on the train", "between meetings"), an enabling mechanism ("daemon → background execution"), and an evidence pointer. No ungrounded lifestyle claims.

Run `/pitchdocs:features benefits` to extract user benefits for your project.

---

## The 4-Question Test

Every document PitchDocs generates must answer these four questions (based on the Banesullivan framework):

1. **Does this solve my problem?** — Clear problem statement and value proposition in the first paragraph
2. **Can I use it?** — Installation, prerequisites, and quickstart within 30 seconds of reading
3. **Who made it?** — Credibility signals: author, contributors, badges, community size
4. **Where do I learn more?** — Links to docs, examples, community, and support channels

If a generated document feels incomplete, check which of these four questions it fails to answer.

---

## Progressive Disclosure (The Lobby Principle)

The README is the **lobby** of the repository — it gives visitors enough to decide whether they want to enter the building, but it should not contain the entire building.

**Lobby content (belongs in README):**
- Value proposition (2–3 paragraphs max)
- Quick start with 5–7 examples
- Top features (8 or fewer)
- Comparison table (top 3–4 competitors)
- Credibility signals and links

**Building content (belongs in separate docs):**
- Per-tool setup instructions
- Exhaustive feature inventories
- Multi-step tutorials
- Configuration reference tables
- Architecture deep-dives

**The delegation test:** If a README section exceeds 2 paragraphs of prose or a table exceeds 8 rows, it likely belongs in a dedicated guide linked from the README.

---

## GEO: Writing for AI Citation

Generative Engine Optimisation (GEO) ensures documentation surfaces correctly in AI-generated answers — ChatGPT, Perplexity, Google AI Overviews, and Claude.

**Key principles PitchDocs applies:**

- **Crisp definitions first** — A one-sentence definition at the top of the README, standalone and quotable by AI systems
- **Atomic sections** — Each H2 section has one clear intent, answerable as a standalone snippet (RAG systems chunk by heading)
- **Concrete statistics** — Benchmarks and measurable outcomes boost AI citation visibility by up to 28%
- **Comparison tables** — LLMs frequently surface structured comparisons when answering "X vs Y" queries
- **Descriptive headings** — "TypeScript Configuration" not "Config" — AI systems match headings to queries

---

## Diataxis Framework

PitchDocs classifies documentation into four types (from the Diataxis framework):

| Type | Purpose | Orientation | PitchDocs Example |
|------|---------|-------------|-------------------|
| Tutorial | Learning | Learning-oriented | Getting Started guide |
| How-to | Problem-solving | Task-oriented | Workflow recipes |
| Reference | Information | Information-oriented | Command Reference |
| Explanation | Understanding | Understanding-oriented | This page |

When PitchDocs generates guides with `/pitchdocs:user-guide`, it classifies each guide into one of these types. This helps ensure the docs set covers all four quadrants rather than concentrating on just one.

---

## The Signal Gate

AI context files (AGENTS.md, CLAUDE.md, .cursorrules, etc.) tell AI coding assistants how to work with your project. But research shows that overstuffed context files — full of directory listings, dependency lists, and architecture overviews — actually reduce AI task success by ~3% and increase costs by 20% (ETH Zurich, 2026).

**The Signal Gate principle:** For every line in a context file, ask: *would removing this cause the AI to make a mistake?* If not, cut it.

**Include (non-discoverable):** Key commands (test, build, deploy), non-default naming conventions, hard constraints, security rules, environment quirks.

**Exclude (discoverable):** Directory listings, dependency lists, file trees, framework conventions, architecture overviews — agents discover these by reading the codebase.

PitchDocs applies Signal Gate when generating context files via `/pitchdocs:ai-context`. The result: leaner files that stay within recommended line budgets (CLAUDE.md under 80 lines, AGENTS.md under 120 lines) and contain only high-signal content.

---

## Context Drift Detection

AI coding assistants (Claude Code, Cursor, Copilot, Windsurf) rely on context files to understand your project's conventions, architecture, and constraints. When your code changes but context files don't, the AI operates on stale information — suggesting deprecated patterns, referencing moved files, or missing new commands.

**What drifts:**
- File paths referenced in AGENTS.md or CLAUDE.md that no longer exist
- Commands listed in context files that were renamed or removed
- Architecture descriptions that don't reflect recent refactors

**How PitchDocs detects it:**
PitchDocs' Context Guard hooks (Claude Code only) run automatically after commits and file edits:

- **Post-commit check** — compares modification dates of context files against code changes and flags stale references
- **Structural change reminder** — fires when you modify commands, skills, agents, or rules and reminds you which context files need updating

Install with `/pitchdocs:context-guard install`. See [Workflows — Set Up Context Guard](workflows.md#set-up-context-guard) for details.

**Fixing drift:** Run `/pitchdocs:ai-context update` to patch only what drifted (preserves human edits). Run `/pitchdocs:ai-context audit` to check drift without making changes. Use `/pitchdocs:ai-context promote` to move stable patterns from Claude's auto-memory (MEMORY.md) into CLAUDE.md for the whole team.

---

## Time to Hello World

PitchDocs optimises quick start sections for measurable "Time to Hello World" (TTHW) based on project type:

| TTHW Target | Project Type |
|-------------|-------------|
| Under 60 seconds | CLI tool, plugin |
| Under 2 minutes | Library, SDK |
| Under 5 minutes | Framework, platform |
| Under 15 minutes | Infrastructure, self-hosted |

Quick start sections follow Cognitive Load Theory principles: leverage prior knowledge through analogies, protect flow state by listing all prerequisites upfront, show concrete examples before abstract theory, and introduce one concept per step.

---

**See also:** [Customising Output](customising-output.md) to steer PitchDocs' output, [Command Reference](command-reference.md) for all commands.
