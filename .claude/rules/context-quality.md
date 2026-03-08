# AI Context File Quality Standards

When generating or updating AI context files (CLAUDE.md, AGENTS.md, GEMINI.md, .cursorrules, copilot-instructions.md, .windsurfrules, .clinerules), follow these standards.

## Cross-File Consistency

All context files for a project must agree on:

- Language and framework version
- Key commands (test, build, lint, deploy)
- Directory structure and key file paths
- Naming conventions and coding standards
- Critical rules and constraints

When updating one context file, check if the same information appears in others and update them too.

## Path Verification

Every file path mentioned in a context file must exist on disk. Before writing a context file, verify referenced paths:

```bash
test -f "path/to/file" || echo "WARN: path does not exist"
```

Never reference deleted files, renamed modules, or moved directories without checking first.

## Version Accuracy

Context files must reference the correct:

- Language runtime version (from `.nvmrc`, `engines`, `requires-python`, `go.mod`)
- Framework version (from `package.json`, `pyproject.toml`)
- Test runner (jest vs vitest vs pytest vs go test)
- Linter/formatter (eslint vs biome, ruff vs flake8)

## Command Accuracy

Every command listed in a context file (test, build, lint, deploy) must be runnable. Verify against `package.json` scripts, `Makefile` targets, or `pyproject.toml` scripts before writing.

## Sync Points

When these project changes occur, update the corresponding context files:

| Change | Files to Update |
|--------|----------------|
| New command or skill | AGENTS.md, CLAUDE.md, llms.txt |
| New dependency | All context files referencing tech stack |
| File rename or move | All context files referencing file paths |
| Test runner change | All context files listing test commands |
| New rule or convention | All context files listing coding standards |
| Architecture change | AGENTS.md, CLAUDE.md (architecture section) |
| New agent | AGENTS.md |
| Stable pattern in MEMORY.md | Promote to CLAUDE.md (so the whole team benefits) |

## Tool Compatibility

Not all context files work in all tools. Note that `.github/copilot-instructions.md` is GitHub-specific — for GitLab and Bitbucket projects, generate only the tool-agnostic context files (AGENTS.md, CLAUDE.md, .cursorrules, .windsurfrules, .clinerules, GEMINI.md).

| File | Works In | Does NOT Work In |
|------|----------|-----------------|
| `AGENTS.md` | Claude Code, OpenCode, Codex CLI, Gemini CLI | — |
| `CLAUDE.md` | Claude Code, OpenCode (fallback) | Cursor, Copilot |
| `.cursorrules` | Cursor | Claude Code, OpenCode |
| `.github/copilot-instructions.md` | GitHub Copilot | Claude Code, Cursor |
| `.windsurfrules` | Windsurf | Claude Code, Cursor |
| `.clinerules` | Cline | Claude Code, Cursor |
| `GEMINI.md` | Gemini CLI | Claude Code, Cursor |
| `.claude/rules/*.md` | Claude Code only | OpenCode, Codex CLI, Cursor |
| Claude Code hooks | Claude Code only | OpenCode, Codex CLI, all others |
| `MEMORY.md` (auto-memory) | Claude Code only (auto-written by Claude) | All others — not user-authored, not version-controlled |

## Context Doc Size Guidance

Context files are loaded into every AI session. Research shows overstuffed context files **reduce** AI task success by ~3% and increase costs by 20% (ETH Zurich, 2026). Less is more — only include what agents cannot discover on their own.

### Line Budgets

| File | Target | Hard Max | Why |
|------|--------|----------|-----|
| CLAUDE.md | Under 80 lines | 120 lines | Auto-loaded every Claude Code session — directly impacts token budget |
| AGENTS.md | Under 120 lines | 160 lines | Loaded by Claude Code, OpenCode, Codex CLI, Gemini CLI, Copilot, Cursor, and 60+ tools |
| Other context files | Under 60 lines | 100 lines | .cursorrules, .windsurfrules, .clinerules, GEMINI.md, copilot-instructions.md |

### The Signal Gate Test

For every line in a context file, ask: **would removing this cause the AI to make a mistake?** If not, cut it.

### Update, Don't Append

When updating context files, modify existing sections rather than appending new ones. Review the whole file and consolidate.

**Belongs in context files (non-discoverable):**
- Key commands (test, build, lint, deploy) — agents cannot guess these
- Non-default naming conventions and coding standards
- Hard constraints and critical rules
- Security rules and environment quirks (e.g., `direnv exec` requirements)

**Does NOT belong in context files (discoverable):**
- Directory listings and file trees — agents can `ls` and `find`
- Dependency lists — agents read manifests (`package.json`, `pyproject.toml`)
- Architecture overviews — agents read and infer from source code
- Framework conventions — agents already know React, Express, Django, etc.
- Key file tables — agents discover entry points via manifests
- Tutorials or step-by-step guides (put in docs/)
- Full API documentation (put in docs/ or generate)
- Changelogs or version history
- Auto-memory content (MEMORY.md is Claude's own notebook — project instructions belong in CLAUDE.md, not copied from auto-memory)
