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

### Feature List Formatting

For features sections in READMEs, two formats are available. Choose based on content:

**Emoji+bold+em-dash bullets** (recommended for 5+ features — more scannable):

```markdown
- 🔍 **Feature name** — benefit description with evidence
- 📋 **Another feature** — another benefit with evidence
```

The emoji creates a visual anchor for each item, the bold text names the feature, and the em-dash cleanly separates "what" from "why". Choose an emoji that relates to the feature content — not decorative randomness. Use when feature descriptions vary in length or don't need structured comparison.

**Table with benefits column** (use for structured comparisons or when status tracking is needed):

```markdown
| Feature | Benefit | Status |
|---------|---------|--------|
| Feature A | Benefit description | :white_check_mark: Stable |
```

Use when features need status indicators, direct side-by-side comparison, or when the list is short (under 5 items).

**Rules for both formats:**
- Every feature must have evidence (file path, function, config option)
- Use at least 3 different benefit categories across the list
- Feature names should be concise (2-5 words) — put detail in the benefit text

## Marketing Principles for Technical Docs

- **Hero section**: Four-part structure — (1) project logo image (`height="160"` to `height="240"`, SVG preferred, transparent background, `<picture>` for dark mode support), (2) bold one-liner explaining what it provides, (3) explanatory sentence covering scope and capabilities, (4) badges and platform compatibility line. Use separate `<p align="center">` blocks for each element — each `<p>` gets natural CSS margin from GitHub's stylesheet, creating consistent spacing. Avoid `<br>` inside `<div>` blocks for spacing — GitHub's renderer collapses them unpredictably. If the logo contains a wordmark (the project name), omit the `# Project Name` heading to avoid duplication.
- **Why section**: Frame features as solutions to real problems
- **Social proof**: Stars, downloads, contributors, "used by" logos where applicable
- **Competitive edge**: Subtle positioning vs alternatives (benchmark charts, comparison tables)
- **Call to action**: Every doc should end with a clear next step

## Visual Structure & Readability

Formatting choices affect scannability. These patterns are recommended for READMEs with 5+ sections or any document over 150 lines. Shorter documents can omit them.

### Emoji Heading Prefixes

Use a single emoji before each H2 heading to create visual anchors when scrolling. This helps readers scan a long document and locate sections quickly.

**Pattern:** `## {emoji} Section Title`

**Recommended emoji by section type:**

| Section Type | Emoji | Example |
|-------------|-------|---------|
| Quick start / Getting started | ⚡ | `## ⚡ Quick start` |
| Why / Value proposition | 💡 | `## 💡 Why ProjectName?` |
| Features | 🎯 | `## 🎯 Features` |
| Commands / API / Usage | 🤖 | `## 🤖 Commands` |
| Configuration | ⚙️ | `## ⚙️ Configuration` |
| Requirements / Prerequisites | 📦 | `## 📦 Requirements` |
| Documentation links | 📚 | `## 📚 Documentation` |
| Contributing | 🤝 | `## 🤝 Contributing` |
| Licence / License | 📄 | `## 📄 Licence` |
| Acknowledgements | 🙏 | `## 🙏 Acknowledgements` |
| Security | 🔒 | `## 🔒 Security` |
| Integrations / Plugins | 🔌 | `## 🔌 Integrations` |
| How it compares | ⚖️ | `## ⚖️ How it compares` |
| Roadmap | 🗺️ | `## 🗺️ Roadmap` |
| What it does / Use cases | 🚀 | `## 🚀 What ProjectName Does` |
| Cross-platform / Other tools | 🔀 | `## 🔀 Use with Other Tools` |

**Rules:**
- One emoji per heading — never two
- Use the same emoji consistently for the same section type across projects
- H3 sub-features within a Features section may also use emoji prefixes for visual grouping (`### 📡 Progress streaming`)
- Inline bullet emoji is the recommended format for feature lists (`- 🎙️ **Voice notes** — description`)
- Choose emoji that relate to the section content — decorative randomness hurts more than it helps
- Skip emoji prefixes for READMEs under 5 sections — the visual overhead outweighs the navigation benefit

### Horizontal Rules as Section Separators

Use `---` between major H2 sections to create visual breathing room. This is especially effective in long READMEs (200+ lines).

**When to use:**
- After the hero/badge section (before the first content section)
- After the table of contents
- Between each top-level H2 section
- Before the licence/footer

**When to skip:**
- Between H3 subsections within a single H2 section
- In short documents (under 150 lines) where they add more noise than clarity
- In files other than README.md (CONTRIBUTING, SECURITY, etc. are typically shorter)

### Table of Contents with Emoji Anchors

When a README uses emoji heading prefixes and has a table of contents, the anchor links must account for the emoji. GitHub strips the emoji character but retains the leading hyphen.

**Pattern:**
```markdown
## Table of contents

- [Quick start](#-quick-start)
- [Why ProjectName?](#-why-projectname)
- [Features](#-features)
- [Configuration](#%EF%B8%8F-configuration)
```

Include a TOC for READMEs with 7+ sections. Below 7 sections, the hero quick-links row (`[Docs](link) · [Examples](link) · [Discord](link)`) is sufficient.

### Bold Inline Callouts

For brief warnings, tips, and notes within a section, use bold inline callouts rather than GitHub-specific `[!NOTE]` syntax (which breaks on npm and PyPI).

**Pattern:**
```markdown
**Note:** This only applies when running in production mode.

**Tip:** Pass `--verbose` to see detailed output.

**Warning:** Never commit this file — it contains credentials.
```

Reserve GitHub callout syntax (`> [!NOTE]`, `> [!WARNING]`) for GitHub-only documents (issue templates, PR templates) where cross-renderer compatibility is not a concern.

### Screenshots & Device Images

Guidelines for including screenshots and device-specific captures in documentation. These complement the general image rules in the `pitchdocs-suite` skill (format, storage, alt text).

#### Capture Dimensions & Display Sizes

Capture at native resolution (or 2× for retina) but always set an explicit display `width` in HTML so the image renders at a consistent, readable size across screens.

| Device | Capture Size (logical px) | Display HTML | Notes |
|--------|--------------------------|-------------|-------|
| Desktop / laptop | 1280×800 | `width="700"` | Standard width; use `width="800"` for full-width hero screenshots |
| Mobile (iPhone) | 390×844 | `width="280"` | Centre-align; narrow images look odd left-aligned |
| Tablet (iPad) | 820×1180 | `width="400"` | Portrait orientation default |
| Terminal / CLI | 80 columns wide | `width="700"` | Use `asciinema`, `vhs`, or `terminalizer` for recordings |

#### HTML Patterns

**Desktop screenshot (standard):**
```html
<p align="center">
  <img src="docs/images/dashboard-desktop.png" width="700" alt="Dashboard showing project metrics and recent activity" />
</p>
```

**Mobile screenshot (centred, narrow):**
```html
<p align="center">
  <img src="docs/images/dashboard-mobile.png" width="280" alt="Dashboard mobile view with collapsed navigation" />
</p>
```

**Side-by-side desktop + mobile (responsive comparison):**
```html
<p align="center">
  <img src="docs/images/dashboard-desktop.png" width="480" alt="Dashboard desktop view" />
  &nbsp;&nbsp;&nbsp;&nbsp;
  <img src="docs/images/dashboard-mobile.png" width="200" alt="Dashboard mobile view" />
</p>
```

**Terminal recording (GIF or SVG):**
```html
<p align="center">
  <img src="docs/images/demo-quick-start.gif" width="700" alt="Terminal recording: installing and running first command in 30 seconds" />
</p>
```

#### Retina / HiDPI Handling

- **Capture at 2× resolution** (e.g., 2560×1600 for a desktop screenshot) to ensure crisp rendering on retina displays
- **Always set an explicit `width`** in the HTML — without it, the 2× image displays at double size
- Do not use `srcset` in GitHub Markdown — it is not supported. The explicit `width` attribute handles scaling.

#### Annotation Conventions

When annotating screenshots with callouts, arrows, or highlights:

- **Colour**: red (#E34234) for callout arrows and highlight boxes — high contrast on most UI backgrounds
- **Stroke**: 2px for arrows and boxes; 3px for emphasis
- **Style**: rounded rectangles for area highlights; straight arrows with solid heads for pointing
- **Text labels**: white text on red background pill, 14px minimum — must be legible at the display `width`
- **Tool recommendations**: Cleanshot X (macOS), Flameshot (Linux), or ShareX (Windows) all support annotation presets

#### Captions

Add a caption beneath a screenshot when the image needs context that alt text alone can't convey — workflow diagrams, multi-part screenshots, or before/after comparisons. Captions are optional for straightforward UI screenshots.

**Cross-renderer pattern** (works on GitHub, npm, and PyPI):
```html
<p align="center">
  <img src="docs/images/dashboard-desktop.png" width="700" alt="Dashboard showing project metrics" />
</p>
<p align="center"><em>Figure 1: Dashboard overview showing project health metrics and recent activity</em></p>
```

**GitHub-preferred pattern** (semantic HTML — stripped on npm/PyPI):
```html
<figure align="center">
  <img src="docs/images/dashboard-desktop.png" width="700" alt="Dashboard showing project metrics" />
  <figcaption><em>Figure 1: Dashboard overview showing project health metrics and recent activity</em></figcaption>
</figure>
```

**Rules:**
- Use the cross-renderer `<p>` + `<em>` pattern for README and any file published to registries
- Use `<figure>`/`<figcaption>` for GitHub-only docs (guides, tutorials, explanation pages)
- Caption format: `Figure N: description` — keep descriptions under one sentence
- Italic formatting (`<em>`) visually distinguishes captions from body text
- Don't caption every screenshot — only when the image needs explanation beyond its alt text

#### Shadows & Borders

GitHub strips all CSS `style` attributes, so `box-shadow` and `border` do **not** render in GitHub Markdown (or npm/PyPI). Shadows and borders must be baked into the image at capture time.

**Baked shadow (recommended for hero/marketing screenshots):**
- Capture tools with built-in shadow presets: Cleanshot X (macOS), Flameshot (Linux), ShareX (Windows)
- Shadow style: soft drop shadow, 10–20px blur, 40–60% opacity black, 0px horizontal / 4–8px vertical offset
- Export with a white or transparent background behind the shadow — GitHub renders on white, so white is safest
- Use shadows for hero/marketing screenshots in README where polish matters; skip for in-guide screenshots where content clarity takes priority

**Baked border (for flat screenshots that bleed into the page):**
- When a screenshot has a white or light background, add a 1px #E0E0E0 border at capture/export time to separate it from the page
- Terminal screenshots and dark-themed UI don't need borders — their inherent dark background provides contrast

**Anti-patterns:**
- Don't use inline `style="box-shadow:..."` — stripped on all renderers
- Don't use `<div>` wrapper styling — stripped on GitHub
- Don't add shadows to terminal recordings (GIF/SVG) — dark backgrounds provide natural contrast

#### Browser Chrome

- **Exclude** browser chrome (address bar, tabs) for focused UI screenshots — readers care about the app, not the browser
- **Include** browser chrome when demonstrating URL patterns, browser extensions, or full-page context
- **Include** browser chrome for marketing hero screenshots where the browser frame adds perceived realism

#### File Naming

Pattern: `{feature}-{device}-{variant}.{ext}`

Examples:
- `dashboard-desktop.png` — desktop screenshot of the dashboard
- `dashboard-mobile-dark.png` — mobile screenshot with dark mode
- `setup-terminal.gif` — terminal recording of setup process
- `login-tablet-annotated.png` — annotated tablet screenshot of login

#### Optimisation

- Run PNG screenshots through `optipng` or `pngquant` before committing
- Keep GIFs under 5MB (10MB GitHub limit, but large GIFs load slowly); prefer `vhs` SVG recordings for terminal demos
- Target under 300KB per image where possible

## Shields.io Badges

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

## GEO: Writing for AI Citation

Generative Engine Optimisation (GEO) ensures documentation surfaces correctly in AI-generated answers — ChatGPT, Perplexity, Google AI Overviews, and Claude. These principles apply to all public-facing docs, not just READMEs.

### Crisp Definitions First

Put a one-sentence definition of the project at the very top of the README, before badges or navigation. LLMs preferentially quote top-of-page definitions when answering "what is X?" queries.

**Pattern:**
```markdown
# Project Name

**[One sentence that defines what this project is and who it's for.]**
```

The definition must be standalone — it should make sense if extracted from the page with no surrounding context.

### Atomic Sections

Each H2 section should have **one clear intent**, answerable as a standalone snippet. AI retrieval systems (RAG) chunk documents by heading, so a section that mixes installation with architecture reduces citation accuracy.

**Rules:**
- One topic per H2 — don't combine "Features" and "Configuration"
- Strict heading hierarchy: H1 > H2 > H3 without skipping levels (no H1 > H3)
- Descriptive headings that contain the topic keyword — "## TypeScript Configuration" not "## Config"
- Each section should be comprehensible without reading prior sections

### Concrete Statistics

Content with concrete statistics can boost visibility in AI responses by up to 28% (Aggarwal et al., "GEO: Generative Engine Optimization", 2023). Include benchmarks, performance numbers, percentages, and measurable outcomes wherever evidence exists.

**Pattern:**
```markdown
- Reduces bundle size by 40% compared to webpack (benchmark: `npm run bench`)
- Processes 10,000 records/second on a single worker (see `benchmarks/throughput.ts`)
- 95% test coverage across 200+ test cases (`npm test -- --coverage`)
```

**Rules:**
- Every statistic must trace to actual code, a benchmark file, or a verifiable measurement
- No speculative numbers — "blazingly fast" without evidence is worse than no claim at all
- Prefer relative comparisons ("40% faster than X") over absolute numbers when the alternative is well-known

### Comparison Tables

LLMs frequently surface comparison tables when answering "X vs Y" or "best X for Y" queries. Structure comparison sections to be extractable:

**Pattern:**
```markdown
## How It Compares

| Feature | This Project | Alternative A | Alternative B |
|---------|-------------|---------------|---------------|
| Specific feature | :white_check_mark: (with detail) | :x: | Partial |
```

**Rules:**
- Use a descriptive H2 heading: "How It Compares" or "How [Project] Compares to [Category]"
- Be factually accurate about competitors — false claims erode trust with both humans and AI
- Include at least one quantitative row (speed, bundle size, API count) alongside qualitative ones
- Link to sources for competitor claims where possible

### TL;DR and Key Concepts Blocks

For long guides (200+ lines), add a **TL;DR** or **Key Concepts** block immediately after the title. RAG systems often extract the first paragraph under a heading — make it count.

**Pattern:**
```markdown
# Migration Guide

> **TL;DR:** Upgrade from v1 to v2 by running `npx migrate` — the CLI handles config changes, dependency updates, and breaking API renames automatically. Manual steps are only needed for custom plugins.

## Prerequisites
...
```

### Prerequisite Blocks

Explicit, structured prerequisite blocks improve LLM understanding of dependencies and requirements. Always use a consistent format.

**Pattern:**
```markdown
## Prerequisites

- Node.js 20+ ([install guide](https://nodejs.org/))
- npm 10+ (included with Node.js)
- A GitHub account with repo access
```

Never bury prerequisites in prose paragraphs — AI extractors miss them.

### Data Density Over Narrative

AI systems extract concrete data, not marketing adjectives. To keep documents concise while maximising GEO value:

- Replace long paragraphs explaining *why* a feature is good with a single concrete statistic or benchmark
- Embed "by the numbers" stats directly into feature bullets as evidence — don't create a standalone stats section
- Comparison tables earn their place (LLMs surface them for "X vs Y" queries), but limit to the top 3–4 competitors and 5–8 distinguishing capabilities
- Be factually accurate about competitors — false claims erode trust with both humans and AI

### Cross-Referencing for Semantic Scaffolding

AI systems build understanding by following links between related documents. Explicit cross-references create a "semantic web" that improves citation accuracy across your documentation set.

**Rules:**
- Every guide links to at least one related guide and back to the hub page
- Use descriptive link text — `[Configuration Guide](docs/guides/configuration.md)` not `[click here](link)`
- README links to docs hub, docs hub links to individual guides, guides link back to README
- Changelog links to relevant documentation for breaking changes

## Token Budget Guidelines for Skills

Claude Code loads skill files on-demand. Token cost directly affects session context and response quality. Follow these budgets when writing or reviewing skills.

### Recommended Budgets by Skill Type

| Skill Type | Metadata Target | Activation Target | When to Split |
|-----------|----------------|------------------|---------------|
| Reference (lookup tables, templates) | ~100 tokens | Under 3,000 tokens | Over 4,000 tokens — split into SKILL.md + SKILL-extended.md |
| Workflow (step-by-step procedures) | ~100 tokens | Under 4,000 tokens | Over 5,000 tokens |
| Combined (reference + workflow) | ~150 tokens | Under 5,000 tokens | Always split at this point |

### Metadata (~100 tokens)

The YAML frontmatter block (`name`, `description`, `version`, `upstream`) should stay under 100 tokens. Descriptions are loaded even when the skill is not active — keep them to 1–2 sentences.

### Activation Content (<5,000 tokens)

The Markdown body is loaded only when explicitly invoked. Stay under 5,000 tokens total per skill file. If a skill is growing beyond this, move extended reference tables and template examples into a companion file (e.g., `SKILL-templates.md`) and reference it with a note: "Extended templates available in SKILL-templates.md — ask Claude to load it if needed."

### Measuring Token Cost

To audit a skill's token cost, count words and multiply:

```bash
wc -w .claude/skills/<name>/SKILL.md
```

Multiply word count by ~1.3 to estimate tokens. A 1,000-word skill is approximately 1,300 tokens.

### Anti-Patterns

- **Do not embed verbatim external spec text** — link to it instead
- **Do not include every possible edge case** — cover the 80% case and note that edge cases exist
- **Do not duplicate content across skills** — cross-reference with "Load the `X` skill for..." instead
