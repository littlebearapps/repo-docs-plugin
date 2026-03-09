---
name: skill-authoring
description: Token budget guidelines for writing Claude Code skills — recommended budgets by skill type, metadata and activation content limits, measuring token cost, and anti-patterns. Load when creating or reviewing skills.
version: "1.0.0"
---

# Skill Authoring: Token Budgets

Claude Code loads skill files on-demand. Token cost directly affects session context and response quality. Follow these budgets when writing or reviewing skills.

## Recommended Budgets by Skill Type

| Skill Type | Metadata Target | Activation Target | When to Split |
|-----------|----------------|------------------|---------------|
| Reference (lookup tables, templates) | ~100 tokens | Under 3,000 tokens | Over 4,000 tokens — split into SKILL.md + SKILL-extended.md |
| Workflow (step-by-step procedures) | ~100 tokens | Under 4,000 tokens | Over 5,000 tokens |
| Combined (reference + workflow) | ~150 tokens | Under 5,000 tokens | Always split at this point |

## Metadata (~100 tokens)

The YAML frontmatter block (`name`, `description`, `version`, `upstream`) should stay under 100 tokens. Descriptions are loaded even when the skill is not active — keep them to 1–2 sentences.

## Activation Content (<5,000 tokens)

The Markdown body is loaded only when explicitly invoked. Stay under 5,000 tokens total per skill file. If a skill is growing beyond this, move extended reference tables and template examples into a companion file (e.g., `SKILL-templates.md`) and reference it with a note: "Extended templates available in SKILL-templates.md — ask Claude to load it if needed."

## Measuring Token Cost

To audit a skill's token cost, count words and multiply:

```bash
wc -w .claude/skills/<name>/SKILL.md
```

Multiply word count by ~1.3 to estimate tokens. A 1,000-word skill is approximately 1,300 tokens.

## Anti-Patterns

- **Do not embed verbatim external spec text** — link to it instead
- **Do not include every possible edge case** — cover the 80% case and note that edge cases exist
- **Do not duplicate content across skills** — cross-reference with "Load the `X` skill for..." instead
