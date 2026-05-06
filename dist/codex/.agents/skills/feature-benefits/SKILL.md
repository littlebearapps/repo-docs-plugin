---
name: feature-benefits
description: Systematic codebase scanning for features and evidence-based feature-to-benefit translation. Extracts what a project does from its code and translates it into what users gain — generates features and benefits sections, "Why [Project]?" content, and feature audit reports. Use when writing a features table for a README, extracting features from code, auditing feature coverage, or answering "why should someone use this project?".
version: "1.0.0"
---

# Feature-Benefits Extraction

Scan a codebase systematically, extract concrete features with evidence, classify by impact, and translate into benefit-driven language for documentation.

## 7-Step Feature Extraction Workflow

### Step 1: Detect Project Type

Read the primary manifest to understand the ecosystem:

| File | Ecosystem | Key Fields |
|------|-----------|------------|
| `package.json` | Node.js / JavaScript / TypeScript | `dependencies`, `scripts`, `bin`, `exports`, `type` |
| `pyproject.toml` | Python | `[project.dependencies]`, `[project.scripts]`, `[tool.*]` |
| `Cargo.toml` | Rust | `[dependencies]`, `[features]`, `[[bin]]` |
| `go.mod` | Go | `require`, module path |
| `.claude-plugin/plugin.json` | Claude Code Plugin | `skills`, `commands`, `agents`, `hooks` |

Also check: `Makefile`, `Dockerfile`, `docker-compose.yml`, `.github/workflows/`, `wrangler.toml` for deployment signals.

### Step 2: Scan Signal Categories

Scan the 10 signal categories: CLI Commands, Public API, Configuration, Integrations, Performance, Security, TypeScript/DX, Testing, Middleware/Plugins, Documentation.

For each category, check file patterns, read matching files, and record what you find. For detailed file patterns and scan lists per category, load `SKILL-signals.md` from this skill directory.

### Step 3: Extract Concrete Features with Evidence

For each signal found, create a feature entry:

```
Feature: [What it does — concrete, specific]
Evidence: [File path, function name, or config that proves it]
Category: [Signal category from Step 2]
```

**Rules:**
- Every feature must have a file path or function as evidence
- No speculative features — if you can't point to code, it's not a feature
- Be specific: "Zero-config TypeScript support" not "Good developer experience"

### Step 3.5: Map to Jobs-to-be-Done (Hero features only)

For Hero features, frame the job: `When I am [situation], I want [capability], so I can [outcome]`. Classify as Functional, Emotional, or Social. Skip JTBD for Core/Supporting tiers and projects with fewer than 5 features. For full JTBD guidance, load `SKILL-signals.md`.

### Step 3.6: Persona Inference

Infer 1–2 target personas from code signals (integration surface, execution model, entry points, deploy artifacts). Map to archetypes: Solo builder, Team lead, Platform/ops engineer, Power user/automator, Compliance-aware org. Default to "Solo builder" if ambiguous. For the full persona inference table, load `SKILL-signals.md`.

### Step 4: User Benefits (the "Why?" Layer)

User benefits answer **"Why should I care?"** — the real-world reasons someone would choose this project.

**Two paths available — both produce the same output format:**

#### Path A: Auto-Scan (default)

Synthesise outcome-first benefits from Hero features + JTBD + persona:
1. Apply the **signal gate**: Standard (workflow benefits) by default; Elevated (experiential) only with mobile/async/remote/voice signals in code
2. Generate 3–7 draft benefits, tag claim strength: Strong (code directly enables), Medium (reasonable inference), Weak (discard)
3. Ship only Strong + Medium benefits

#### Path B: Conversational ("Talk it out")

Use 4 interactive questions to surface authentic use cases, then enrich with code evidence. For the full prompt sequence, load `SKILL-signals.md`.

#### Output Format

```
**[Bold user outcome]** — [mechanism/how it works]. [Constraint if needed].
```

Each benefit requires: a specific context, an enabling mechanism, and an evidence pointer.

### Step 5: Classify by Impact Tier

| Tier | Count | Criteria | README Placement |
|------|-------|----------|-----------------|
| **Hero** | 1–3 | Primary differentiators — why someone chooses THIS over alternatives | One-liner, Why section, first in features |
| **Core** | 4–8 | Expected by the target audience — missing these would be a deal-breaker | Features table, quick start examples |
| **Supporting** | 9+ | Nice-to-have — adds polish but isn't the reason someone adopts | Mentioned briefly or linked to docs |

### Step 6: Output Structured Feature Inventory

Output as a Markdown table with Feature, Evidence, Benefit Category, and optional JTBD columns, grouped by tier (Hero, Core, Supporting). Or use emoji+bold+em-dash bullets for direct README use.

---

## Feature-to-Benefit Translation Framework

### The Translation Pattern

```
[Technical feature] so you can [user outcome] — [evidence]
```

### 5 Benefit Categories

Use at least 3 different categories across your features table:

| Category | Pattern | Example Benefit |
|----------|---------|----------------|
| **Time saved** | "Do X in Y instead of Z" | "Generate a full README in under a minute — not an afternoon" |
| **Confidence gained** | "Know that X because Y" | "Every benefit traces to actual code — no marketing fluff" |
| **Pain avoided** | "Never worry about X" | "Never ship a repo with missing docs again" |
| **Capability unlocked** | "Now you can X" | "Scan any codebase and extract its selling points automatically" |
| **Cost reduced** | "Save X by Y" | "One plugin replaces five separate documentation tools" |

### Anti-Patterns

- **No "simple" or "easy"** — show simplicity through a short code example
- **No "powerful" without evidence** — what specifically makes it powerful?
- **No speculative benefits** — "could save you hours" requires evidence
- **No feature-as-benefit** — "Has caching" is a feature; "Responses in <50ms after first request" is the benefit
- **No benefit without context** — every user benefit needs a specific situation
- **No benefit without mechanism** — every user benefit needs an enabling mechanism
- **No ungrounded lifestyle claims** — elevated signal gate only when code proves the mechanism

For the full translation table by signal category, badge mapping, and common patterns library, load `SKILL-signals.md`.
