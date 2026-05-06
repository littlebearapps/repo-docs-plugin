---
name: geo-optimisation
description: Generative Engine Optimisation (GEO) patterns for documentation that surfaces correctly in AI-generated answers — citation capsules, crisp definitions, atomic sections, comparison tables, statistics, and semantic scaffolding. Load when optimising docs for AI citation (ChatGPT, Perplexity, Google AI Overviews, Claude).
version: "1.0.0"
---

# GEO: Writing for AI Citation

Generative Engine Optimisation (GEO) ensures documentation surfaces correctly in AI-generated answers — ChatGPT, Perplexity, Google AI Overviews, and Claude. These principles apply to all public-facing docs, not just READMEs.

## Crisp Definitions First

Put a one-sentence definition of the project at the very top of the README, before badges or navigation. LLMs preferentially quote top-of-page definitions when answering "what is X?" queries. The definition must be standalone — it should make sense if extracted with no surrounding context.

## Atomic Sections

Each H2 section should have **one clear intent**, answerable as a standalone snippet. AI retrieval systems (RAG) chunk documents by heading, so a section that mixes installation with architecture reduces citation accuracy.

**Rules:**
- One topic per H2 — don't combine "Features" and "Configuration"
- Strict heading hierarchy: H1 > H2 > H3 without skipping levels
- Descriptive headings with topic keywords — "## TypeScript Configuration" not "## Config"
- Each section should be comprehensible without reading prior sections

## Concrete Statistics

Content with concrete statistics can boost visibility in AI responses by up to 28% (Aggarwal et al., "GEO: Generative Engine Optimization", 2023). Include benchmarks, performance numbers, and measurable outcomes wherever evidence exists.

**Rules:**
- Every statistic must trace to actual code, a benchmark file, or a verifiable measurement
- Prefer relative comparisons ("40% faster than X") over absolute numbers when the alternative is well-known

## Comparison Tables

LLMs frequently surface comparison tables when answering "X vs Y" queries. Use a descriptive H2 heading ("How It Compares"), be factually accurate about competitors, and include at least one quantitative row alongside qualitative ones.

## TL;DR and Key Concepts Blocks

For long guides (200+ lines), add a **TL;DR** block immediately after the title. RAG systems often extract the first paragraph under a heading — make it count.

## Prerequisite Blocks

Explicit, structured prerequisite blocks improve LLM understanding. Always use bullet list format — never bury prerequisites in prose paragraphs.

## Data Density Over Narrative

AI systems extract concrete data, not marketing adjectives. Replace long paragraphs with single concrete statistics. Embed stats directly into feature bullets as evidence. Comparison tables earn their place but limit to 3–4 competitors and 5–8 capabilities.

## Cross-Referencing for Semantic Scaffolding

Explicit cross-references create a "semantic web" that improves citation accuracy. Every guide links to at least one related guide and back to the hub page. Use descriptive link text — not "click here".

## Citation Capsules

A **citation capsule** is a 40–60 word self-contained passage at the start of each H2 section, written so it makes sense if extracted with no surrounding context.

**Rules:**
- Every H2 section in README must open with a citation capsule
- Include at least one concrete fact: a number, named entity, or measurable outcome
- The capsule must be comprehensible without reading any other section
- Keep to 40–60 words
- Do not start with "This section" or "In this part" — start with the subject
