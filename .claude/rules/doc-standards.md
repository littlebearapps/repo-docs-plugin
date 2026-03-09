# Documentation Standards

When generating public-facing repository documentation, follow these principles:

## The 4-Question Test (Banesullivan Framework)

Every document must answer these questions for the reader:

1. **Does this solve my problem?** — Clear problem statement and value proposition in the first paragraph
2. **Can I use it?** — Installation, prerequisites, and quickstart within 30 seconds of reading
3. **Who made it?** — Credibility signals: author, contributors, badges, community size
4. **Where do I learn more?** — Links to docs, examples, community, and support channels

## Progressive Disclosure (The Lobby Principle)

The README is the **lobby** of the repository — it gives visitors enough to decide whether they want to enter the building, but it should not contain the entire building. Detailed content belongs in separate docs and guides, linked from the README.

- First paragraph: non-technical, benefit-focused, anyone can understand
- Second section: quick start for developers who want to try it NOW
- Deeper sections: technical details, API reference, architecture
- A familiar user should be able to refresh their memory without scrolling past the fold

**Lobby content (belongs in README):**
- Value proposition (2–3 paragraphs max)
- Quick start with 5–7 examples
- Top features (8 or fewer emoji+bold+em-dash bullets)
- Comparison table (top 3–4 competitors, top 5–8 distinguishing capabilities)
- Credibility signals (badges, security, social proof)
- Links to docs, contributing, and licence

**Building content (delegate to `docs/guides/` or separate files):**
- Per-tool or per-platform setup instructions
- Exhaustive feature inventories or API surface docs
- Multi-step tutorials longer than 5–7 lines
- Configuration reference tables
- Architecture deep-dives
- Upstream specification details

**The delegation test:** If a README section exceeds 2 paragraphs of prose or a table exceeds 8 rows, it likely belongs in a dedicated guide linked from the README with a 2–3 line summary.

## Time to Hello World

The primary DevEx metric for documentation. Every quick start section should target a measurable Time to Hello World (TTHW) based on project type:

| TTHW Target | Project Type | Example |
|-------------|-------------|---------|
| Under 60 seconds | CLI tool, plugin | `npx create-thing && thing run` |
| Under 2 minutes | Library, SDK | `npm install` + 5-line code example |
| Under 5 minutes | Framework, platform | Clone + config + first request |
| Under 15 minutes | Infrastructure, self-hosted | Docker compose + verify health |

State the TTHW target explicitly in the quick start section where evidence supports it (e.g. "Get your first README in under 60 seconds").

**Cognitive Load Theory principles** (Sweller, 1988):
- **Leverage prior knowledge** — use analogies to familiar tools ("like ESLint, but for your docs")
- **Protect flow state** — never require the reader to leave the page during quick start; all prereqs listed upfront, all commands copy-paste-ready
- **Concrete before abstract** — show a working example first, explain the theory after
- **One concept per step** — each numbered step introduces exactly one new thing

## Tone & Language

- Consistent language — follow the project's existing locale and spelling conventions
- Professional-yet-approachable — confident, not corporate
- Benefit-driven: describe what users GAIN, not just what the software DOES
- "You can now..." not "We implemented..." — reader-centric framing
- Active voice. Short sentences. No jargon without explanation.

**Banned phrases:** Avoid these AI-detectable patterns entirely — "in today's digital landscape", "it's important to note", "dive into" / "deep dive", "leverage", "game-changer", "cutting-edge" / "state-of-the-art", "seamless" / "seamlessly", "robust", "in conclusion" / "to summarise", "furthermore" / "moreover", "revolutionise", "utilise", "comprehensive", "navigate the complexities", "elevate your". No "simple", "easy", or "powerful" without evidence — show simplicity through short examples, show power through benchmarks.

## Feature-to-Benefit Writing

Every feature mentioned in documentation must be translated into a user benefit.

**The pattern:**
```
[Technical feature] so you can [user outcome] — [evidence]
```

**Examples:**
- "Automatic changelog from git history **so you can** ship release notes in seconds — not hours"
- "TypeScript-first with strict mode **so you can** catch errors before they reach production"
- "14-file documentation audit **so you can** never ship a repo with missing docs again"

**5 benefit categories** — use at least 3 different categories across any features table:

| Category | User Feels | Pattern |
|----------|-----------|---------|
| Time saved | "That was fast" | "Do X in Y instead of Z" |
| Confidence gained | "I trust this" | "Know that X because Y" |
| Pain avoided | "I don't have to worry" | "Never worry about X again" |
| Capability unlocked | "Now I can do something new" | "Now you can X" |
| Cost reduced | "This saves me money/effort" | "One tool replaces N" |

**Evidence requirement:** Every benefit claim must trace to actual code — a file path, function name, config option, or test result. No speculative benefits.

**Anti-patterns:** Avoid "simple", "easy", "powerful" without evidence. Show simplicity through short examples, not adjectives.

### User Benefits (the "Why?" Layer)

Documentation has two benefit layers:

- **Feature benefits** answer "What does this do for me?" — `[Feature] so you can [outcome] — [evidence]`. Used in Features sections.
- **User benefits** answer "Why should I care?" — outcome-first statements that describe real-world impact. Used in "Why [Project]?" sections.

**The user benefit pattern:**
```
**[Bold user outcome]** — [mechanism/how it works]. [Constraint if needed].
```

**Examples:**
- **Work from anywhere** — voice notes are transcribed and queued as tasks on your VPS. Once queued, tasks continue even if your phone disconnects.
- **Ship without context-switching** — the daemon runs in the background, so you review results when you're ready.

**Signal gate:** The aspiration level of user benefits scales with code signals. Default to workflow benefits ("Deploy without being at your desk"). Only escalate to experiential benefits ("Start from your phone at the park") when mobile, async, or remote signals exist in the codebase.

**Two paths to user benefits:**
- **Auto-scan** — synthesised from Hero features, JTBD emotional/social jobs, and inferred personas. Good starting point.
- **Conversational** — developer describes their real use cases and motivations. Produces the most authentic, compelling benefits. Load the `feature-benefits` skill for the full two-path workflow.

**Anti-fluff rules:** Every user benefit requires a specific context, an enabling mechanism, and an evidence pointer. No ungrounded lifestyle claims.

### Feature List Formatting

Two formats available — choose based on content:

- **Emoji+bold+em-dash bullets** (recommended for 5+ features): `- 🔍 **Feature name** — benefit with evidence`. Emoji creates a visual anchor, bold names the feature, em-dash separates "what" from "why".
- **Table with benefits column** (for structured comparisons or status tracking): `| Feature | Benefit | Status |`. Use when features need status indicators or the list is short (under 5 items).

**Rules:** Every feature needs evidence (file path, function, config option). Use at least 3 different benefit categories. Feature names should be concise (2–5 words).

## Marketing Principles for Technical Docs

- **Hero section**: Four-part structure — (1) project logo image (`height="160"` to `height="240"`, SVG preferred, transparent background, `<picture>` for dark mode support), (2) bold one-liner explaining what it provides, (3) explanatory sentence covering scope and capabilities, (4) badges and platform compatibility line. Use separate `<p align="center">` blocks for each element — each `<p>` gets natural CSS margin from GitHub's stylesheet, creating consistent spacing. Avoid `<br>` inside `<div>` blocks for spacing — GitHub's renderer collapses them unpredictably. If the logo contains a wordmark (the project name), omit the `# Project Name` heading to avoid duplication.
- **Why section**: Frame with outcome-first user benefits (see "User Benefits" subsection above). Offer bold-outcome bullets for workflow/lifestyle tools, problem/solution table for technical tools
- **Social proof**: Stars, downloads, contributors, "used by" logos where applicable
- **Competitive edge**: Subtle positioning vs alternatives (benchmark charts, comparison tables)
- **Call to action**: Every doc should end with a clear next step

## Shields.io Badges

Badge URL paths differ by hosting platform (`/github/`, `/gitlab/`, `/bitbucket/`). Load the `platform-profiles` skill for platform-specific badge URL templates.

Use these badge categories (in order):
1. Build/CI status
2. Test coverage
3. Package version / npm / PyPI
4. License
5. Downloads / usage metrics
6. Community (Discord, discussions)

Format: `[![Badge](https://img.shields.io/...)](link)`

## File Naming

- `README.md` — Always uppercase
- `CHANGELOG.md` — Always uppercase
- `ROADMAP.md` — Always uppercase
- `CONTRIBUTING.md` — Always uppercase
- `CODE_OF_CONDUCT.md` — Always uppercase with underscores
- `SECURITY.md` — Always uppercase
- `.github/ISSUE_TEMPLATE/` — GitHub convention
- `.github/PULL_REQUEST_TEMPLATE.md` — GitHub convention

## Extended References (loaded on-demand)

- **Visual formatting** (emoji headings, screenshots, image specs): Load the `visual-standards` skill
- **GEO optimisation** (AI citation, capsules, statistics): Load the `geo-optimisation` skill
- **Skill authoring** (token budgets, metadata guidance): Load the `skill-authoring` skill
