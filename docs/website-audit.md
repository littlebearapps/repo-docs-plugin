# PitchDocs Website Audit

**Page audited:** https://dev.littlebearapps.com/builds/pitchdocs/
**Source of truth:** PitchDocs repo v1.19.1 (README.md, doc-standards.md, plugin.json, commands/*.md)
**Date:** 2026-03-09

---

## Critical — Fix These First

### 1. Command count is wrong (13 → 15)

The page says "13 slash commands" in two places:

- Hero banner: "13 slash commands. One plugin. Zero API calls."
- Feature card: "13 slash commands — Generate any doc type in under a minute"

**Actual count: 15 commands** (verified by counting `commands/*.md` files and the README commands table).

The two missing from the count are likely `/pitchdocs:context-guard` and `/pitchdocs:docs-audit` or similar — all 15 are listed in the README.

**Fix:** Replace "13" with "15" in both locations.

---

### 2. The 4-question framework is misquoted

The website states the 4 questions as:
> What does this do? Does it solve my problem? Can I use it? Where do I learn more?

The actual 4 questions from `doc-standards.md` (the Banesullivan Framework) are:
1. **Does this solve my problem?** — Clear problem statement and value proposition
2. **Can I use it?** — Installation, prerequisites, quickstart
3. **Who made it?** — Credibility signals: author, contributors, badges
4. **Where do I learn more?** — Links to docs, examples, community

"What does this do?" is **not** one of the four questions. **"Who made it?"** (credibility signals) is the missing one.

**Affected locations:**
- Feature card: "4-question framework — Every doc answers: what does this do, does it solve my problem, can I use it, where do I learn more?"
- FAQ answer for "What is the 4-question framework?"
- Hero flow section: "Every doc answers the 4 questions readers ask" (this line is fine as-is, but the expanded versions elsewhere are wrong)

**Fix:** Replace "What does this do?" with "Who made it?" everywhere the 4 questions are listed.

---

### 3. Install step 3 has wrong command

Website shows:
```
/context-guard install
```

Should be:
```
/pitchdocs:context-guard install
```

The README explicitly states: "When installed as a plugin, all commands use the `pitchdocs:` prefix."

**Fix:** Add the `pitchdocs:` prefix to step 3.

---

### 4. Commands section missing `pitchdocs:` prefix

The "Try these commands" section shows:
- `/readme`
- `/features`
- `/docs-audit`

These should be:
- `/pitchdocs:readme`
- `/pitchdocs:features`
- `/pitchdocs:docs-audit`

The short form only works inside the pitchdocs source directory, not when installed as a plugin (which is how users will have it).

**Fix:** Add `pitchdocs:` prefix to all command examples.

---

## Major — Missing Key Features

### 5. AI context file management is completely absent

This is one of PitchDocs' biggest differentiators and it's nowhere on the page. The feature:

- Generates and maintains AI context files for **7 AI tools**: AGENTS.md, CLAUDE.md, .cursorrules, copilot-instructions.md, .windsurfrules, .clinerules, GEMINI.md
- Uses the **Signal Gate principle** — only includes what agents can't discover on their own
- Full lifecycle: `init` (bootstrap), `update` (patch drift), `promote` (move MEMORY.md patterns to CLAUDE.md), `audit` (check health)
- The `/pitchdocs:ai-context` command drives all of this

**Fix:** Add a feature card for AI context management. Suggested wording:

> **AI context file management** — Generate, maintain, and audit context files for 7 AI tools (AGENTS.md, CLAUDE.md, .cursorrules, and more). Uses the Signal Gate principle to include only what agents can't discover on their own — leaner files, better AI performance.

Also add `/pitchdocs:ai-context` to the commands section.

---

### 6. Content filter protection not mentioned

PitchDocs automatically handles Claude Code's API content filter for CODE_OF_CONDUCT, LICENSE, and SECURITY files. Without this, users hit HTTP 400 errors when generating these standard OSS files.

**Fix:** Either add a feature card or mention it within the Context Guard card:

> **Content filter protection** — Automatically handles Claude Code's API filter for CODE_OF_CONDUCT, LICENSE, and SECURITY so you never hit HTTP 400 errors.

---

### 7. GEO optimisation not listed as a feature

The README lists GEO optimisation as a top-tier feature:
> GEO-optimised for AI citation — structured so ChatGPT, Perplexity, and Google AI Overviews cite your project accurately

This is absent from the website's feature cards.

**Fix:** Add a feature card:

> **GEO-optimised for AI citation** — Structured output so ChatGPT, Perplexity, and Google AI Overviews cite your project with accurate descriptions and statistics.

---

### 8. Most commands not shown

The website only shows 3 of 15 commands. At minimum, add the most impactful ones users would want to see:

| Command | Description |
|---------|-------------|
| `/pitchdocs:changelog` | Generate CHANGELOG.md from git history with user-benefit language |
| `/pitchdocs:ai-context` | Generate and maintain AI context files for 7 tools |
| `/pitchdocs:docs-verify` | Verify links, freshness, heading hierarchy, and quality score |
| `/pitchdocs:launch` | Generate Dev.to articles, HN posts, Reddit posts, Twitter threads |
| `/pitchdocs:doc-refresh` | Refresh all docs after a version bump |
| `/pitchdocs:roadmap` | Generate ROADMAP.md from GitHub milestones |
| `/pitchdocs:user-guide` | Generate task-oriented user guides |
| `/pitchdocs:llms-txt` | Generate llms.txt for AI discoverability |
| `/pitchdocs:context-guard` | Install/uninstall Context Guard hooks |
| `/pitchdocs:platform` | Detect hosting platform and feature support |
| `/pitchdocs:visual-standards` | Load visual formatting reference |
| `/pitchdocs:geo` | Load GEO optimisation patterns |

**Fix:** Show at least 6–8 commands instead of 3. The changelog, ai-context, docs-verify, and launch commands are particularly compelling.

---

## Minor — Accuracy and Polish

### 9. Quality scoring dimensions understated

Website says: "completeness, structure, freshness, and link health" (4 dimensions).

**Actual: 6 dimensions** — completeness, structure, freshness, link health, **evidence**, and **GEO & citation readiness**.

**Fix:** Update to list all 6 dimensions, or say "6 dimensions including completeness, structure, freshness, link health, evidence, and GEO readiness".

---

### 10. Duplicate feature cards: "Ready-to-use templates" and "GitHub community templates"

These two cards describe essentially the same thing:
- "Ready-to-use templates — CONTRIBUTING, SECURITY, SUPPORT, issue/PR templates, release config"
- "GitHub community templates — Generate CONTRIBUTING, SECURITY, SUPPORT, and issue/PR templates"

**Fix:** Consolidate into one card. Free up the slot for AI context management, GEO, or content filter protection.

---

### 11. "Upstream spec drift detection" is over-promoted

This is a monthly GitHub Action — useful but not a core user-facing feature. It currently occupies a feature card alongside much more impactful features.

**Fix:** Remove this card (or demote to a footnote) and replace with one of the missing major features: AI context management, content filter protection, or GEO optimisation.

---

## Suggestions — Would Strengthen the Page

### 12. Add a comparison table

The README has a strong comparison table (PitchDocs vs readmeai vs Generic AI Prompt) covering 6 capabilities. This is a key conversion element missing from the website.

**Suggested columns:** PitchDocs | readmeai | Generic AI Prompt
**Suggested rows:** Codebase scanning, Full docs suite, GEO/AI citation, AI context management, Quality scoring, Cross-tool compatibility

---

### 13. Hero tagline could be more benefit-driven

Current: "Documentation skills and templates for AI coding assistants."
README version: "Turn any codebase into professional, marketing-ready repository documentation — powered by AI coding assistants."

The README version leads with the outcome (professional docs) rather than the mechanism (skills and templates).

**Fix:** Consider adopting the README tagline, or a hybrid: "Turn any codebase into professional, marketing-ready documentation — skills and templates for 9 AI coding assistants."

---

### 14. FAQ "What is PitchDocs?" should mention AI context files

Current answer lists "README files, changelogs, roadmaps, contributing guides, and llms.txt files" but omits AI context files — one of the biggest features.

**Fix:** Add "and AI context files (AGENTS.md, CLAUDE.md, .cursorrules, and more)" to the list.

---

### 15. npm/PyPI registry compatibility not mentioned

PitchDocs audits package registry metadata fields (npm `repository`, `keywords`, `description`; PyPI equivalents). This is a useful differentiator for library authors.

**Fix:** Mention in a feature card or FAQ: "Audits npm and PyPI registry metadata so your package listing looks professional."

---

### 16. Self-quote testimonial

The testimonial quotes Nathan (the project author). While authentic, self-quotes carry less weight than third-party endorsements.

**Fix:** Consider replacing with a GitHub star count badge, a user comment from GitHub Discussions, or a quote from someone who's used PitchDocs on their own project.

---

## Summary of Recommended Feature Cards

Replace the current 13 feature cards with these (reordered by impact):

1. Evidence-based feature extraction (keep)
2. **AI context file management** (NEW — biggest missing feature)
3. 4-question framework (keep, fix the questions)
4. 20+ file documentation audit (keep)
5. **15** slash commands (fix count)
6. **GEO-optimised for AI citation** (NEW)
7. llms.txt generation (keep)
8. Quality scoring — 6 dimensions (fix count)
9. GitHub, GitLab, and Bitbucket (keep)
10. Context Guard + content filter protection (merge/expand)
11. Progressive disclosure (keep)
12. Works with 9 AI tools (keep)

**Remove:** "Ready-to-use templates" (merged into #4), "GitHub community templates" (duplicate), "Upstream spec drift detection" (too minor for a card)
