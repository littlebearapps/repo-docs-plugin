---
name: ai-context
description: Generates lean AI IDE context files (AGENTS.md, CLAUDE.md, .cursorrules, copilot-instructions.md, .windsurfrules, .clinerules, GEMINI.md) from codebase analysis. Applies the Signal Gate principle — only includes what agents cannot discover on their own. Use when setting up, auditing, or updating AI tool context for a repository.
version: "2.0.0"
---

# AI Context File Generator

## Philosophy

AI coding assistants work better when they understand a project's conventions, architecture, and constraints. Context files tell AI tools **how** to work with the codebase — the things they cannot discover on their own.

This skill generates context files for multiple AI tools from a single codebase analysis. The same scan produces output for Claude Code, Codex CLI, Cursor, GitHub Copilot, and Gemini CLI.

## The Signal Gate

Research shows that auto-generated context files **reduce** AI task success by ~3% and increase token costs by 20% (ETH Zurich, Feb 2026). Overstuffed files cause agents to ignore the instructions that matter. Less is more.

**The test for every line:** Would removing this cause the AI to make a mistake? If not, cut it.

### What to Include (Non-Discoverable)

Only include information the agent **cannot** figure out by reading source code:

- **Non-obvious conventions** — import order that differs from defaults, naming patterns that break from language norms, spelling locale (e.g., Australian English)
- **Hard constraints** — "never use `any`", "always use `direnv exec`", "no commits to main"
- **Key commands** — test, build, deploy, lint (agents cannot guess these without running them)
- **Security rules** — secret management, credential handling, input validation requirements
- **Environment quirks** — required env vars, non-standard tooling (e.g., `uv` instead of `pip`, `bun` instead of `npm`)

### What to Exclude (Discoverable)

Agents discover these by reading files — including them wastes tokens and dilutes signal:

- **Directory listings / file trees** — agents can `ls` and `find`
- **Dependency lists** — agents read `package.json`, `pyproject.toml`, `go.mod`
- **Architecture overviews** — agents read source code and infer structure
- **Framework conventions** — agents already know React, Express, Django, etc.
- **API patterns visible in source** — agents read the code directly
- **Key file tables** — agents discover entry points and configs via manifest files

### Framing

Each line in a context file signals something confusing enough to trip an AI agent. Consider fixing the root cause rather than documenting the workaround (Osmani, 2026). Describe the **end state** you want, not step-by-step instructions (Spotify Honk, 2025).

### Line Budgets

| File | Target | Hard Max |
|------|--------|----------|
| CLAUDE.md | Under 80 lines | 120 lines |
| AGENTS.md | Under 120 lines | 160 lines |
| Other context files | Under 60 lines | 100 lines |

## Supported Context Files

| File | AI Tool | Purpose | Adoption |
|------|---------|---------|----------|
| `AGENTS.md` | Codex CLI, Cursor, Gemini CLI, Claude Code, OpenCode, Copilot, RooCode | Cross-tool agent context — identity, capabilities, conventions | 60,000+ repos |
| `CLAUDE.md` | Claude Code | Project-specific instructions loaded on every session | Native to Claude Code |
| `.cursorrules` | Cursor | Editor-specific rules for code generation | Native to Cursor |
| `.github/copilot-instructions.md` | GitHub Copilot | Repository-level instructions for Copilot suggestions | Native to Copilot |
| `.windsurfrules` | Windsurf | Project-specific rules for Windsurf's Cascade AI | Native to Windsurf |
| `.clinerules` | Cline (VS Code extension) | Project context for autonomous Cline tasks | Native to Cline |
| `GEMINI.md` | Gemini CLI | Project context loaded at the start of every Gemini CLI session | Native to Gemini CLI |

### CLAUDE.md vs Auto-Memory (Claude Code)

Claude Code maintains three knowledge layers. PitchDocs generates CLAUDE.md — never MEMORY.md.

| Layer | File | Who Writes | Shared via Git? |
|-------|------|-----------|-----------------|
| Project instructions | `CLAUDE.md` | Developer / PitchDocs | Yes |
| Auto-memory | `~/.claude/.../MEMORY.md` | Claude itself | No (local only) |
| Session memory | (in-context) | Claude itself | No |

**Boundary rule:** CLAUDE.md contains instructions *for* Claude. MEMORY.md contains notes *by* Claude. If the same insight keeps appearing in MEMORY.md across sessions, promote it to CLAUDE.md.

## Codebase Analysis Workflow

### Step 1: Detect Project Profile

```bash
# Language and runtime
ls package.json pyproject.toml Cargo.toml go.mod pom.xml build.gradle 2>/dev/null

# Framework detection
cat package.json 2>/dev/null | grep -E '"(react|next|express|fastify|hono|astro|svelte)"'
cat pyproject.toml 2>/dev/null | grep -E '(fastapi|django|flask|starlette)'

# Test runner
ls jest.config* vitest.config* pytest.ini pyproject.toml .mocharc* 2>/dev/null
grep -l "test" package.json 2>/dev/null

# Linter/formatter
ls .eslintrc* eslint.config* .prettierrc* biome.json ruff.toml .flake8 2>/dev/null

# TypeScript configuration
ls tsconfig*.json 2>/dev/null

# Monorepo detection
ls pnpm-workspace.yaml lerna.json nx.json turbo.json 2>/dev/null

# CI/CD
ls .github/workflows/*.yml 2>/dev/null
```

### Step 2: Extract Conventions

From the codebase analysis, extract:

1. **Language version** — Node.js version from `.nvmrc`/`engines`, Python from `requires-python`, Go from `go.mod`
2. **Import conventions** — ESM vs CommonJS, absolute vs relative imports, path aliases (`@/`)
3. **Naming patterns** — camelCase/snake_case for variables, PascalCase for types, file naming
4. **Directory structure** — where source, tests, config, and docs live
5. **Test patterns** — test file location (`__tests__/`, `*.test.ts`, `tests/`), test runner, assertion style
6. **Build/deploy** — build command, deploy target (Cloudflare, Vercel, AWS, etc.)
7. **Error handling** — custom error classes, Result types, try-catch patterns
8. **Security rules** — .gitignore patterns, secret management, input validation

### Step 3: Generate Context Files

#### AGENTS.md Structure

Target: under 120 lines. Only include what agents cannot discover by reading source code.

```markdown
# AGENTS.md

## Identity

[Project name] is a [brief description]. Built with [language/framework].

## Conventions

- [Language]: [version]
- Style: [naming conventions, import order]
- Types: [strict mode, no any, explicit returns — if TypeScript]
- Tests: [runner, location, naming pattern]
- Commits: [conventional commits, branch naming]

## Commands

```bash
[install command]
[test command]
[build command]
[lint command]
[deploy command]
```

## Rules

- [Critical rule 1 — e.g., never commit secrets]
- [Critical rule 2 — e.g., all public functions need tests]
- [Critical rule 3 — e.g., use direnv exec for deploy commands]
```

**Omit** Project Structure, Architecture, and Important Files sections — agents discover these by reading the codebase. Only add them back if the project has non-obvious structure that would genuinely trip an agent.

#### CLAUDE.md Structure

Claude Code loads this file at the start of every session. Target: under 80 lines. For each line, ask: would removing this cause Claude to make a mistake?

```markdown
# [Project Name]

[One sentence: what this project is]

## Commands

- **Test**: `[test command]`
- **Build**: `[build command]`
- **Deploy**: `[deploy command]`

## Conventions

[3-5 bullet points — only conventions that differ from language/framework defaults]

## Rules

[Critical do/don't rules that prevent common mistakes]
```

**Omit** Architecture, Key Paths, and directory listings — Claude reads the codebase directly. Only include paths if they are genuinely non-obvious (e.g., deploy scripts in an unusual location).

#### .cursorrules Structure

Cursor rules are plain text, loaded when editing files in the project. Target: under 60 lines.

```
You are working on [project name], a [description].

Language: [X] with [framework]
Style: [conventions that differ from defaults]

Key rules:
- [Rule 1]
- [Rule 2]
- [Rule 3]

When writing code:
- [Non-default pattern 1]
- [Non-default pattern 2]

When writing tests:
- [Test pattern 1]
- [Test pattern 2]
```

**Omit** file structure listings — Cursor can read the project tree.

#### .github/copilot-instructions.md Structure

```markdown
# Copilot Instructions

## Project Context

This is a [description] built with [language/framework].

## Coding Standards

- [Convention 1]
- [Convention 2]
- [Convention 3]

## Patterns to Follow

- [Pattern 1]
- [Pattern 2]

## Patterns to Avoid

- [Anti-pattern 1]
- [Anti-pattern 2]
```

#### .windsurfrules Structure

Windsurf's Cascade AI reads `.windsurfrules` from the project root. Format is plain text — similar to `.cursorrules`. Target: under 60 lines.

```
# [Project Name] — Windsurf Rules

[Project name] is a [description]. Built with [language/framework].

## Conventions

- [Convention that differs from defaults 1]
- [Convention that differs from defaults 2]
- [Convention that differs from defaults 3]

## Commands

[test command]
[build command]
[deploy command]

## Rules

- [Critical rule 1]
- [Critical rule 2]
```

**Omit** Key Files and Project Context sections — Windsurf reads the project tree directly.

#### .clinerules Structure

Cline reads `.clinerules` from the project root. Supports task checklists. Target: under 60 lines.

```markdown
# [Project Name]

[1-2 sentence description of what the project is and does]

## Conventions

- [Non-default convention 1]
- [Non-default convention 2]
- [Non-default convention 3]

## Commands

- Test: `[test command]`
- Build: `[build command]`
- Lint: `[lint command]`

## Before Committing

- [ ] Tests pass (`[test command]`)
- [ ] Linting passes (`[lint command]`)
- [ ] No secrets or credentials in changed files
```

**Omit** Tech Stack and Important Paths sections — Cline reads manifests and the file tree directly.

#### GEMINI.md Structure

Gemini CLI reads `GEMINI.md` from the project root (or `.gemini/GEMINI.md`). Target: under 60 lines. Gemini CLI also supports Claude Code Skills (same SKILL.md format).

```markdown
# [Project Name]

[One sentence: what is this project and who is it for]

## Commands

[test command]
[build command]
[deploy command]

## Conventions

- [Non-default convention 1]
- [Non-default convention 2]
- [Non-default convention 3]

## Rules

- [Critical rule 1]
- [Critical rule 2]
```

**Omit** Tech Stack and Key Paths sections — Gemini CLI reads manifests and the file tree directly.

## MEMORY.md Promotion

When running with `promote` argument, scan Claude Code's auto-memory for stable patterns that belong in CLAUDE.md.

### Workflow

1. **Locate MEMORY.md** for the current project:

```bash
find ~/.claude/projects -name "MEMORY.md" -path "*$(basename $(pwd))*" 2>/dev/null
```

2. **Parse for convention patterns** — lines that look like project rules:
   - Lines starting with "Always", "Never", "Use", "Don't", "Prefer"
   - Lines mentioning commands, file paths, or naming conventions
   - Lines that describe patterns or constraints

3. **Cross-reference against CLAUDE.md** — skip any insights already present

4. **Present candidates** with recommendation:

```
MEMORY.md Promotion Candidates:
  → "Always use direnv exec for deploy commands" — not in CLAUDE.md (promote)
  → "Import order: external → types → @/ → ./" — already in CLAUDE.md (skip)
  → "Use Australian English (realise, colour)" — not in CLAUDE.md (promote)

Promote 2 insights to CLAUDE.md? (Will append to ## Conventions section)
```

5. **Append promoted insights** to the appropriate CLAUDE.md section, deduplicating. Use Edit (not Write) to preserve existing content.

**Boundary rule:** Only promote insights that pass the signal gate test — would removing this cause the AI to make a mistake? Workflow observations, debugging notes, and session-specific state stay in MEMORY.md.

## Init Mode

When running with `init` argument, bootstrap AI context for a new project in one step.

### Workflow

1. Run codebase analysis (Step 1 and Step 2 above)
2. Detect which context files already exist — **skip existing files** (never overwrite)
3. Generate missing context files using signal-gate-filtered templates
4. Offer Context Guard hook installation (Claude Code only)
5. Run a quick audit pass on generated files (verify paths and commands)
6. Report summary:

```
AI Context Init:
  Created:
    ✓ AGENTS.md (48 lines)
    ✓ CLAUDE.md (35 lines)
    ✓ .cursorrules (28 lines)
  Skipped (already exist):
    · GEMINI.md
  Context Guard:
    ✓ Tier 1 hooks installed (Claude Code only)
  Audit:
    ✓ All paths valid
    ✓ Commands verified
```

## Incremental Update

When running with `update` argument, patch only what drifted — preserving human edits to context files.

### Workflow

1. **Detect changes** since context files were last modified:

```bash
# Find when each context file was last touched
git log -1 --format=%H -- CLAUDE.md
git log -1 --format=%H -- AGENTS.md

# What source files changed since then
git diff --name-only <last-context-commit>..HEAD
```

2. **Classify changes** by their impact on context files:
   - `package.json` scripts changed → update Commands sections
   - `tsconfig.json` / linter config changed → update Conventions sections
   - Source files renamed/moved → fix path references
   - New commands/skills/agents added → update relevant listings

3. **Apply surgical edits** using Edit (not Write) — only touching affected sections

4. **Report** what was patched:

```
AI Context Update:
  CLAUDE.md:
    → Updated "Commands" (package.json scripts changed)
    → Fixed path: src/index.ts → src/main.ts
  AGENTS.md:
    → Updated "Commands" section
  .cursorrules:
    → No drift detected (skipped)
```

## Staleness Audit

When running in `audit` mode, check existing context files for drift:

1. **Version mismatch** — Does the context file reference the correct language/framework version?
2. **Missing commands** — Are test/build/deploy commands still accurate? Run them to verify.
3. **Stale paths** — Do referenced file paths still exist?
4. **New conventions** — Has the project adopted new patterns (e.g., added ESLint, switched to Vitest) that aren't reflected?
5. **Memory drift** — If a MEMORY.md exists for this project, check whether it records conventions or patterns that should be promoted to CLAUDE.md. Flag as `ℹ MEMORY.md contains project conventions that may belong in CLAUDE.md`.
6. **Context Guard status** — Check if Context Guard hooks are installed and healthy:

```bash
# Check for hook scripts
ls .claude/hooks/context-*.sh 2>/dev/null

# Check settings.json for hook entries
grep -l "context-" .claude/settings.json 2>/dev/null
```

Report format:
```
AI Context Audit:
  ✓ AGENTS.md — up to date (last modified: 2 days ago)
  ⚠ CLAUDE.md — references jest but vitest.config.ts detected
  ✗ .cursorrules — references src/index.ts but file moved to src/main.ts
  · .github/copilot-instructions.md — not present
  · .windsurfrules — not present (recommend generating)
  · .clinerules — not present (recommend generating)
  · GEMINI.md — not present (recommend generating)

  Context Guard:
    ✓ Tier 1 active (Stop hook)
    ✗ Tier 2 not installed (recommend /context-guard install strict)
    ✓ 4/4 hook scripts executable
```

## AGENTS.md Spec Version Tracking

The AGENTS.md format is defined by the [agents.md spec](https://github.com/agentsmd/agents.md). PitchDocs tracks the pinned version in `upstream-versions.json`.

### Current Stable: v1.0

The v1.0 spec defines these standard sections:

| Section | Purpose |
|---------|---------|
| Identity | Project name, description, what it does |
| Project Structure | Key directories and their purposes |
| Conventions | Coding standards, naming, commit conventions |
| Commands | Test, build, deploy, lint commands |
| Architecture | System design, data flow, key abstractions |
| Files | Important files and their roles |
| Rules | Hard constraints (security, compatibility) |

### Proposed v1.1 Features (Draft — Do Not Implement)

These features are under discussion and may change before stabilisation:

| Feature | Status | Notes |
|---------|--------|-------|
| Sub-agents section | Draft | Nested agent definitions within AGENTS.md |
| Tool permissions | Proposed | Declaring which tools an agent can use |
| `.agent/` directory | Proposed | Directory-based agent definitions (alternative to single file) |
| `when:` frontmatter | Draft | Trigger conditions for agent activation |

**Guidance:** Do not generate these proposed sections until they reach stable status. Monitor the [agents.md releases](https://github.com/agentsmd/agents.md/releases) for v1.1 announcement. The `check-upstream` GitHub Action will flag when a new version is available. When v1.1 reaches stable, update the pinned version in `upstream-versions.json` and add the new sections to the generation templates above.

## Anti-Patterns

- **Don't include discoverable content** — directory listings, file trees, dependency lists, and architecture overviews waste tokens (see Signal Gate above)
- **Don't include secrets** — no API keys, tokens, or credentials in context files
- **Don't repeat framework docs** — agents already know React, Express, Django conventions
- **Don't over-constrain** — provide patterns, not rigid rules that prevent creative problem-solving
- **Don't include session-specific state** — context files should be durable across sessions
- **Don't ship auto-generated files unedited** — generated context files reduce task success by ~3% (ETH Zurich, 2026). Always curate: remove lines that fail the "would removing this cause a mistake?" test
