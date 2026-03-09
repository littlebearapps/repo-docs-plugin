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

Not all context files work in all tools. Key distinctions: `AGENTS.md` works in Claude Code, OpenCode, Codex CLI, and Gemini CLI. `CLAUDE.md` works in Claude Code and OpenCode. `.cursorrules`, `.windsurfrules`, `.clinerules`, `GEMINI.md`, and `.github/copilot-instructions.md` are tool-specific. `.claude/rules/*.md` and hooks are Claude Code only. `MEMORY.md` is auto-written by Claude — not user-authored, not version-controlled. For GitLab/Bitbucket projects, generate only tool-agnostic context files.

For context file size guidance and the Signal Gate principle, load the `ai-context` skill.
