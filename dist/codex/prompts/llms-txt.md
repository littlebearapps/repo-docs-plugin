---
description: "Generate llms.txt and llms-full.txt for LLM-friendly content curation: $ARGUMENTS"
argument-hint: "[path or 'full' to include llms-full.txt]"
allowed-tools:
  - Read
  - Glob
  - Grep
  - Bash
  - Write
  - Edit
---

# /llms-txt

Generate an `llms.txt` file (and optionally `llms-full.txt`) following the [llmstxt.org](https://llmstxt.org/) specification. This provides AI coding assistants and search engines with a structured index of your project's documentation.

## Behaviour

1. Load the `llms-txt` skill for the specification and generation patterns
2. Load the `doc-standards` rule for description quality
3. Read the project manifest (`package.json`, `pyproject.toml`, etc.) for name and description
4. Scan the repository for documentation files:
   - Core: `README.md`, `docs/`, API reference
   - Guides: `docs/guides/`
   - Examples: `examples/`
   - Supporting: `CONTRIBUTING.md`, `CHANGELOG.md`, `SECURITY.md`, `CODE_OF_CONDUCT.md`, `ROADMAP.md`, `LICENSE`
5. Write benefit-focused descriptions for each file (not just file names)
6. Assemble `llms.txt` following the spec:
   - H1 from project name
   - Blockquote from manifest description or README first paragraph
   - H2 sections grouping docs by category
   - `## Optional` for supporting files
7. If `full` argument: concatenate all referenced files into `llms-full.txt`

## Output Files

| File | Content | When |
|------|---------|------|
| `llms.txt` | Index with relative links and benefit-focused descriptions | Always |
| `llms-full.txt` | Concatenated Markdown of all referenced docs | Only with `full` argument |

## Description Quality

Every file annotation must be benefit-focused:

**Good:** `[Getting Started](./docs/guides/getting-started.md): Install, configure, and deploy your first worker in under 5 minutes`

**Bad:** `[Getting Started](./docs/guides/getting-started.md): Getting started guide`

Use at least 3 different benefit categories across the file (Time saved, Confidence gained, Pain avoided, Capability unlocked, Cost reduced).

## Arguments

- No arguments: generate `llms.txt` only for the current project
- `full`: generate both `llms.txt` and `llms-full.txt`
- Path argument: generate for a specific project directory

## When to Run

- When setting up a new public repository
- After restructuring documentation
- After major releases (alongside changelog)
- When preparing a project for AI tool discoverability
