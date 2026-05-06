---
name: llms-txt
description: Generates llms.txt and llms-full.txt files following the llmstxt.org specification. Provides LLM-friendly content curation for AI coding assistants (Cursor, Windsurf, Claude Code) and AI search engines. Use when generating or updating llms.txt for a repository.
version: "1.0.0"
---

# llms.txt Generator

Generate structured, LLM-friendly content indexes following the [llmstxt.org](https://llmstxt.org/) specification.

## Background

llms.txt was proposed by Jeremy Howard (Answer.AI) in September 2024. It provides a curated Markdown file that gives LLMs a structured map of a project's most important content — solving the problem of context windows being too small to process entire websites or repositories.

Adopted by: Anthropic, Cloudflare, Stripe, Vercel, Cursor, Mintlify, GitBook, Fern.

Used by: Cursor, Windsurf, Context7 MCP, Claude Code (reading local files), AI search engines.

## Specification (llmstxt.org)

An llms.txt file is a Markdown document with sections in this exact order:

1. **H1 heading** (required) — the name of the project or site
2. **Blockquote** (optional) — short summary with key information for understanding the rest of the file
3. **Body text** (optional) — zero or more Markdown sections of any type **except headings**
4. **H2 sections with file lists** (optional) — each contains a Markdown list where every item has:
   - A **required** hyperlink: `[name](url)`
   - Optionally a `:` followed by notes about the file
5. **`## Optional` section** (special) — URLs here can be skipped when shorter context is needed

**No other heading levels are used.** Only H1 (one, at the top) and H2 (for sections).

## Two Output Files

| File | Content | Size Target | Use Case |
|------|---------|-------------|----------|
| `llms.txt` | Index with links and descriptions | Under 10K tokens | Real-time AI assistants navigating quickly |
| `llms-full.txt` | Concatenated Markdown of all referenced files | Varies (can be 100K+ tokens) | RAG ingestion, IDE indexing, full-context tools |

## Generation Workflow

### Step 1: Gather Project Metadata

Read the primary manifest for the project name and description:

| File | Name Field | Description Field |
|------|-----------|------------------|
| `package.json` | `name` | `description` |
| `pyproject.toml` | `[project].name` | `[project].description` |
| `Cargo.toml` | `[package].name` | `[package].description` |
| `go.mod` | module path | First line of README |
| `.claude-plugin/plugin.json` | `name` | `description` |

### Step 2: Scan for Documentation Files

Check for these files and directories:

**Primary docs:**
- `README.md`
- `docs/` directory (hub page, guides, API reference)
- `examples/` directory

**Supporting docs:**
- `CONTRIBUTING.md`
- `CHANGELOG.md`
- `SECURITY.md`
- `CODE_OF_CONDUCT.md`
- `ROADMAP.md`
- `LICENSE`

**Code entry points** (include only if the project is a library/framework):
- `src/index.*` or `lib/index.*`
- Config files with schema documentation

### Step 3: Write Descriptive Annotations

For each file, write a benefit-focused description — not just the file name:

**Good:**
```
- [Getting Started](./docs/guides/getting-started.md): Install, configure, and deploy your first worker in under 5 minutes
```

**Bad:**
```
- [Getting Started](./docs/guides/getting-started.md): Getting started guide
```

Use the feature-benefits approach: describe what the reader **gains** from reading that file.

### Step 4: Assemble llms.txt

For **repositories** (local paths):

```markdown
# [Project Name]

> [Description from manifest or README first paragraph]

[Optional body text: language, framework, key technical context]

## Docs

- [README](./README.md): Project overview, value proposition, and quick start
- [API Reference](./docs/api.md): Complete endpoint documentation with authentication and error codes
- [Configuration](./docs/configuration.md): All config options with defaults and examples

## Guides

- [Getting Started](./docs/guides/getting-started.md): Install, configure, and run your first example in under 5 minutes
- [Deployment](./docs/guides/deployment.md): Production deployment to Docker, AWS Lambda, and Cloudflare Workers

## Examples

- [Basic Usage](./examples/basic/): Minimal working examples for common use cases
- [Advanced Patterns](./examples/advanced/): Complex integrations and performance optimisation

## Optional

- [Changelog](./CHANGELOG.md): Version history with user-facing change descriptions
- [Contributing](./CONTRIBUTING.md): Development setup, coding standards, and PR workflow
- [Code of Conduct](./CODE_OF_CONDUCT.md): Community behaviour standards (Contributor Covenant v3.0)
- [Security](./SECURITY.md): Vulnerability reporting process and response timeline
- [License](./LICENSE): MIT license terms
```

For **documentation sites** (full URLs):

```markdown
# [Project Name]

> [Description]

## Docs

- [Getting Started](https://docs.example.com/getting-started): Installation and first steps
- [API Reference](https://docs.example.com/api): Complete API documentation

## Optional

- [Changelog](https://docs.example.com/changelog): Version history
- [Contributing](https://github.com/org/repo/blob/main/CONTRIBUTING.md): How to contribute
```

### Step 5: Generate llms-full.txt (if requested)

Concatenate all referenced files in the same order as llms.txt, with clear separators:

```markdown
# [Project Name] — Full Documentation

> Complete documentation content for LLM ingestion.

---

## README.md

[Full contents of README.md]

---

## docs/api.md

[Full contents of docs/api.md]

---

[Continue for all referenced files, excluding the Optional section unless specifically requested]
```

**Size management:**
- Skip binary files (images, PDFs)
- For very large files (>50K tokens), include only the first section or a summary
- Note the total token count at the end of the file

## When to Generate

| Project Type | llms.txt | llms-full.txt |
|-------------|----------|---------------|
| Public repo with docs site | Always | Always (host on docs site) |
| Public GitHub repo | Recommended | Optional (large repos benefit) |
| Claude Code plugin | Recommended | Optional |
| Small utility / internal tool | Optional | Skip |

## Regeneration

llms.txt should be updated when documentation changes significantly:
- After adding or removing documentation files
- After major version releases
- After restructuring the docs directory
- Add to the release checklist alongside CHANGELOG updates

## Real-World Examples

| Project | llms.txt | llms-full.txt | Notable Pattern |
|---------|----------|---------------|-----------------|
| Anthropic | `docs.anthropic.com/llms.txt` (~8K tokens) | 481K tokens | Organised by product area |
| Cloudflare | `developers.cloudflare.com/llms.txt` | Per-product files (~3.7M total) | Product-specific full files |
| Stripe | `docs.stripe.com/llms.txt` | Yes | Uses Optional for niche products |
| Vercel | `vercel.com/docs/llms.txt` | ~400K words | Multi-product structure |

## Specification Reference

- **Spec**: [llmstxt.org](https://llmstxt.org/)
- **Creator**: Jeremy Howard, Answer.AI
- **Reference repo**: [AnswerDotAI/llms-txt](https://github.com/AnswerDotAI/llms-txt)
- **Directory**: [llms-txt-hub](https://github.com/thedaviddias/llms-txt-hub)
