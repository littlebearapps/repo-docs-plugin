---
description: "Generate lean AI IDE context files using the Signal Gate principle — only what agents cannot discover on their own: $ARGUMENTS"
argument-hint: "[claude|agents|cursor|copilot|windsurf|cline|gemini|all|init|update|promote|audit] or no args for all"
allowed-tools:
  - Read
  - Glob
  - Grep
  - Bash
  - Write
  - Edit
---

# /ai-context

Generate lean context files that help AI coding assistants understand your project's non-obvious conventions and constraints. Applies the Signal Gate principle — excludes discoverable content (directory listings, file trees, architecture overviews) that research shows reduces AI task success.

## Behaviour

1. Load the `ai-context` skill for templates, the Signal Gate, and the codebase analysis workflow
2. Load the `doc-standards` rule for quality criteria
3. Run the codebase analysis: detect language, framework, test runner, linter, conventions
4. Generate the requested context file(s) from the analysis results, filtering through the Signal Gate

## Arguments

### Generate
- **No arguments** / `all`: Generate all applicable context files (AGENTS.md, CLAUDE.md, .cursorrules, .github/copilot-instructions.md, .windsurfrules, .clinerules, GEMINI.md)
- `claude`: Generate CLAUDE.md only
- `agents`: Generate AGENTS.md only
- `cursor`: Generate .cursorrules only
- `copilot`: Generate .github/copilot-instructions.md only
- `windsurf`: Generate .windsurfrules only
- `cline`: Generate .clinerules only
- `gemini`: Generate GEMINI.md only

### Lifecycle
- `init`: Bootstrap a new project — generate missing context files, offer Context Guard hooks, run audit. Skips existing files.
- `update`: Patch only what drifted since the last context update, using git change detection. Preserves human edits.
- `promote`: Scan Claude Code's auto-memory (MEMORY.md) for stable patterns and assist promoting them to CLAUDE.md.
- `audit`: Check existing context files for staleness, drift, discoverable content, and Context Guard status.

## Output

Each generated file is written directly to disk. Line counts should stay within the Signal Gate budgets (CLAUDE.md <80, AGENTS.md <120, others <60).

```
AI Context Files:
  ✓ AGENTS.md — generated (48 lines)
  ✓ CLAUDE.md — generated (35 lines)
  ✓ .cursorrules — generated (28 lines)
  ✓ .github/copilot-instructions.md — generated (25 lines)
  ✓ .windsurfrules — generated (22 lines)
  ✓ .clinerules — generated (30 lines)
  ✓ GEMINI.md — generated (24 lines)
```

Audit mode:
```
AI Context Audit:
  ✓ AGENTS.md — up to date (48 lines, within budget)
  ⚠ CLAUDE.md — references jest but vitest.config.ts detected
  ✗ .cursorrules — references src/index.ts but file moved to src/main.ts
  · GEMINI.md — not present (recommend generating)
  ℹ MEMORY.md — contains 3 conventions that may belong in CLAUDE.md (run /ai-context promote)

  Context Guard:
    ✓ Tier 1 active (Stop hook)
    ✗ Tier 2 not installed
```
