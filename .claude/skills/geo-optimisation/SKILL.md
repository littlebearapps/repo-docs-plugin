---
name: geo-optimisation
description: Generative Engine Optimisation (GEO) patterns for documentation that surfaces correctly in AI-generated answers — citation capsules, crisp definitions, atomic sections, comparison tables, statistics, and semantic scaffolding. Load when optimising docs for AI citation (ChatGPT, Perplexity, Google AI Overviews, Claude).
version: "1.0.0"
---

# GEO: Writing for AI Citation

Generative Engine Optimisation (GEO) ensures documentation surfaces correctly in AI-generated answers — ChatGPT, Perplexity, Google AI Overviews, and Claude. These principles apply to all public-facing docs, not just READMEs.

## Crisp Definitions First

Put a one-sentence definition of the project at the very top of the README, before badges or navigation. LLMs preferentially quote top-of-page definitions when answering "what is X?" queries.

**Pattern:**
```markdown
# Project Name

**[One sentence that defines what this project is and who it's for.]**
```

The definition must be standalone — it should make sense if extracted from the page with no surrounding context.

## Atomic Sections

Each H2 section should have **one clear intent**, answerable as a standalone snippet. AI retrieval systems (RAG) chunk documents by heading, so a section that mixes installation with architecture reduces citation accuracy.

**Rules:**
- One topic per H2 — don't combine "Features" and "Configuration"
- Strict heading hierarchy: H1 > H2 > H3 without skipping levels (no H1 > H3)
- Descriptive headings that contain the topic keyword — "## TypeScript Configuration" not "## Config"
- Each section should be comprehensible without reading prior sections

## Concrete Statistics

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

## Comparison Tables

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

## TL;DR and Key Concepts Blocks

For long guides (200+ lines), add a **TL;DR** or **Key Concepts** block immediately after the title. RAG systems often extract the first paragraph under a heading — make it count.

**Pattern:**
```markdown
# Migration Guide

> **TL;DR:** Upgrade from v1 to v2 by running `npx migrate` — the CLI handles config changes, dependency updates, and breaking API renames automatically. Manual steps are only needed for custom plugins.

## Prerequisites
...
```

## Prerequisite Blocks

Explicit, structured prerequisite blocks improve LLM understanding of dependencies and requirements. Always use a consistent format.

**Pattern:**
```markdown
## Prerequisites

- Node.js 20+ ([install guide](https://nodejs.org/))
- npm 10+ (included with Node.js)
- A GitHub account with repo access
```

Never bury prerequisites in prose paragraphs — AI extractors miss them.

## Data Density Over Narrative

AI systems extract concrete data, not marketing adjectives. To keep documents concise while maximising GEO value:

- Replace long paragraphs explaining *why* a feature is good with a single concrete statistic or benchmark
- Embed "by the numbers" stats directly into feature bullets as evidence — don't create a standalone stats section
- Comparison tables earn their place (LLMs surface them for "X vs Y" queries), but limit to the top 3–4 competitors and 5–8 distinguishing capabilities
- Be factually accurate about competitors — false claims erode trust with both humans and AI

## Cross-Referencing for Semantic Scaffolding

AI systems build understanding by following links between related documents. Explicit cross-references create a "semantic web" that improves citation accuracy across your documentation set.

**Rules:**
- Every guide links to at least one related guide and back to the hub page
- Use descriptive link text — `[Configuration Guide](docs/guides/configuration.md)` not `[click here](link)`
- README links to docs hub, docs hub links to individual guides, guides link back to README
- Changelog links to relevant documentation for breaking changes

## Citation Capsules

AI retrieval systems (RAG) preferentially extract the first paragraph under each heading. A **citation capsule** is a 40–60 word self-contained passage at the start of each H2 section, written so it makes sense if extracted with no surrounding context.

**Pattern:**
```markdown
## Features

PitchDocs generates marketing-grade repository documentation from codebase analysis — 15 skills covering README, changelog, roadmap, and AI context files. It runs as a pure-Markdown Claude Code plugin with zero runtime dependencies, producing docs that pass the 4-question test in under 60 seconds.

### Individual feature details below...
```

**Good capsule (standalone, concrete):**
> PitchDocs generates marketing-grade repository documentation from codebase analysis — 15 skills covering README, changelog, roadmap, and AI context files.

**Poor capsule (context-dependent, vague):**
> This section covers the main features of the project. Below you'll find details about each capability.

**Rules:**
- Every H2 section in README must open with a citation capsule
- Include at least one concrete fact: a number, named entity, or measurable outcome
- The capsule must be comprehensible without reading any other section
- Keep to 40–60 words — long enough to be informative, short enough for AI to extract whole
- Do not start with "This section" or "In this part" — start with the subject
