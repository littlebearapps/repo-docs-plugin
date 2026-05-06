---
name: public-readme
description: Generates READMEs with the Daytona/Banesullivan marketing framework — hero section, benefit-driven features, quickstart, comparison tables, and compelling CTAs. Produces docs that sell as well as they inform. Use when creating or overhauling a project README.
version: "1.0.0"
---

# Public README Generator

## README Structure (Recommended Order)

**Output formatting conventions** (see `doc-standards` rule for the full reference):
- Prefix each H2 section heading with an emoji from the standard table
- Separate major sections with `---` horizontal rules
- The numbered sections below (1–9) indicate recommended ORDER — the actual output uses H2 headings with emoji prefixes, not numbered H3s

### GEO: Optimising for AI Citation

Load the `geo-optimisation` skill for the full GEO reference. README-specific essentials:

1. **First paragraph as standalone definition** — The bold one-liner must work if extracted with no surrounding context
2. **Comparison section** — Include "How It Compares" with a feature table (LLMs surface these for "X vs Y" queries)
3. **Statistics and benchmarks** — Embed concrete numbers in feature descriptions (28% more AI visibility)
4. **Semantic heading hierarchy** — Strict H1 > H2 > H3, descriptive topic-keyword headings
5. **Atomic feature descriptions** — Each bullet/row comprehensible without surrounding context

### 1. Hero Section

**Full hero template:**

```html
<p align="center">
  <img src="docs/assets/logo.svg" height="200" alt="Project Name" />
</p>

<p align="center">
  <strong>One compelling sentence that explains the value proposition — not what it IS, but what it DOES FOR YOU.</strong>
</p>

<p align="center">
  <a href="link"><img src="https://img.shields.io/github/actions/workflow/status/org/repo/ci.yml?branch=main" alt="Build" /></a>
  <a href="link"><img src="https://img.shields.io/codecov/c/github/org/repo" alt="Coverage" /></a>
  <a href="link"><img src="https://img.shields.io/npm/v/package-name" alt="npm" /></a>
  <a href="link"><img src="https://img.shields.io/github/license/org/repo" alt="License" /></a>
  <a href="link"><img src="https://img.shields.io/npm/dm/package-name" alt="Downloads" /></a>
</p>

<p align="center">
  <a href="link">Documentation</a> · <a href="link">Examples</a> · <a href="link">Discord</a> · <a href="link">Blog</a>
</p>

---
```

The `---` after the hero creates a visual break before the content body. For READMEs with 7+ sections, add a table of contents between the hero `---` and the first content section.

**Three-part hero structure:**

1. **Bold one-liner** (maximum 15 words) — explains what the project provides, not just what it is. Starts with an action verb or benefit. No jargon.
2. **Explanatory sentence** — one sentence covering scope, capabilities, and key selling points.
3. **Badges and compatibility line** — standard shields.io badges (version, licence, CI), plus any platform/ecosystem badges.

**Audience awareness:** The bold one-liner should resonate with both developers (what it does technically) and decision makers (what it achieves for the team/org).

For logo guidelines, registry-specific badges, and dark mode support, load `SKILL-reference.md` from this skill directory.

### 2. Visual Element (Optional but High-Impact)

Place a screenshot, demo GIF, terminal recording, or architecture diagram after the hero. Keep under 800px wide. For device-specific screenshots, captions, and shadow/border styling, load the `visual-standards` skill.

### 3. Value Proposition

Frame the value proposition to serve two reader tracks simultaneously:

**Developer/Implementer track** — Technical problem → technical solution with code evidence. "How do I use this?" focus.

**Decision Maker/Ops track** — Business problem → measurable outcome. "Why should we adopt this?" focus.

```markdown
## Why Project Name?

| Problem | Solution | Evidence |
|---------|----------|----------|
| Manual changelog writing wastes hours per release | Generates changelogs from conventional commits in seconds | `src/changelog.ts` |
| READMEs go stale within weeks of launch | Detects drift between code and docs, suggests updates | `hooks/context-drift-check.sh` |
```

**Alternative format: Problem/solution bullets** (for libraries, APIs, and technical tools):

```markdown
## Why Project Name?

- **Problem you solve** — How you solve it, and why your approach is better
- **Another pain point** — Your elegant solution, with a specific metric if possible
```

For bold-outcome bullets, credibility rows, use-case framing (section 3.5), and format selection guidance, load `SKILL-reference.md` from this skill directory.

### 4. Quick Start

Must achieve the **Time to Hello World** target for the detected project type (see TTHW Targets table in `SKILL-reference.md` in this skill directory).

**Rules:**
- Show the SIMPLEST possible usage first
- Include expected output in comments
- Use TypeScript if the project supports it
- Limit to 5–7 lines of code — move extensive tutorials to `docs/guides/getting-started.md`
- Never require the reader to leave the page — all prereqs listed upfront, all commands copy-paste-ready

### 5. Features

Two formats are available:

**Emoji+bold+em-dash bullets** (recommended for 5+ features):

```markdown
- 🔍 **Feature name** — benefit description with evidence
- 📋 **Another feature** — benefit description with evidence
```

**Table with benefits column** (for structured comparisons or status tracking):

```markdown
| Feature | Benefit | Status |
|---------|---------|--------|
| Feature A | Saves 30 min per release | :white_check_mark: Stable |
```

#### How to Populate Features

1. Load the `feature-benefits` skill and run the 7-step Feature Extraction Workflow
2. Take all **Hero** and **Core** tier features from the classified inventory
3. **Limit to the top 8 features in the README.** Link to a full list in docs if 10+
4. Apply the feature-to-benefit translation — use at least 3 different benefit categories
5. No features without file/function evidence — if you can't point to code, don't list it

**One-liner generation**: Synthesise from Hero features. Pattern: "Ship [outcome] with [how]" or "[Action verb] [what users gain] — [key differentiator]."

### 6. Comparison (If Applicable)

Only include if there are genuine alternatives. Be honest and fair. Limit to the top 3–4 competitors and 5–8 distinguishing capabilities.

### 7. Documentation Links

Link to getting started guide, API reference, configuration, examples, and FAQ.

### 8. Contributing

Brief section with link to CONTRIBUTING.md. Include open issues link and discussion forum.

### 9. License & Credits

```markdown
## License

[MIT](LICENSE) — Made with care by [Author/Org](link)
```

## Anti-Patterns to Avoid

- **Don't start with installation** — sell the value first
- **Don't list every API method** — link to API docs instead
- **Don't use "simple" or "easy"** — show, don't tell
- **Don't include build instructions** — that's for CONTRIBUTING.md
- **Don't include TOC for READMEs under 7 sections** — the hero quick-links row is sufficient
- **Don't use emoji heading prefixes for READMEs under 5 sections**
- **Don't put exhaustive content in the README** — delegate to `docs/guides/`. The README is the lobby, not the building.
