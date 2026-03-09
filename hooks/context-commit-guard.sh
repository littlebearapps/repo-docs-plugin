#!/bin/bash
# context-commit-guard.sh
# Hook: PreToolUse (Bash, matching git commit)
# Purpose: Block git commit when structural files are staged without
#          corresponding AI context file updates.
# Tier: 2 (Guard) — blocks the commit until context docs are staged
# Installed by: /context-guard install strict
#
# Claude Code only — OpenCode, Codex CLI, Cursor, and other tools
# do not support Claude Code hooks.

set -euo pipefail

# Read hook input from stdin
INPUT=$(cat)
TOOL_NAME=$(echo "$INPUT" | jq -r '.tool_name // empty' 2>/dev/null)
COMMAND=$(echo "$INPUT" | jq -r '.tool_input.command // empty' 2>/dev/null)

# Only process Bash tool
[ "$TOOL_NAME" != "Bash" ] && echo '{}' && exit 0

# Only process git commit commands (including --amend, -m, etc.)
[[ "$COMMAND" != *"git commit"* ]] && echo '{}' && exit 0

# Resolve project directory
PROJECT_DIR="${CLAUDE_PROJECT_DIR:-.}"
cd "$PROJECT_DIR" || { echo '{}'; exit 0; }

# Must be inside a git repository
git rev-parse --is-inside-work-tree &>/dev/null || { echo '{}'; exit 0; }

# Get staged files
STAGED_FILES=$(git diff --cached --name-only 2>/dev/null)
[ -z "$STAGED_FILES" ] && echo '{}' && exit 0

# Check for structural file patterns in staging area
HAS_STRUCTURAL=false
while IFS= read -r FILE; do
  case "$FILE" in
    # Skip Context Guard's own infrastructure — not project structural changes
    .claude/hooks/*|.claude/rules/context-quality.md|.claude/settings.json) continue ;;
    commands/*.md) HAS_STRUCTURAL=true; break ;;
    .claude/skills/*/SKILL.md) HAS_STRUCTURAL=true; break ;;
    .agents/skills/*/SKILL.md) HAS_STRUCTURAL=true; break ;;
    .claude/agents/*.md) HAS_STRUCTURAL=true; break ;;
    .agents/agents/*.md) HAS_STRUCTURAL=true; break ;;
    .claude/rules/*.md) HAS_STRUCTURAL=true; break ;;
    package.json) HAS_STRUCTURAL=true; break ;;
    pyproject.toml) HAS_STRUCTURAL=true; break ;;
    Cargo.toml) HAS_STRUCTURAL=true; break ;;
    go.mod) HAS_STRUCTURAL=true; break ;;
    tsconfig*.json) HAS_STRUCTURAL=true; break ;;
    wrangler.toml) HAS_STRUCTURAL=true; break ;;
    vitest.config*) HAS_STRUCTURAL=true; break ;;
    jest.config*) HAS_STRUCTURAL=true; break ;;
    eslint.config*) HAS_STRUCTURAL=true; break ;;
    biome.json) HAS_STRUCTURAL=true; break ;;
    .claude-plugin/plugin.json) HAS_STRUCTURAL=true; break ;;
  esac
done <<< "$STAGED_FILES"

# No structural files staged — allow commit
[ "$HAS_STRUCTURAL" = false ] && echo '{}' && exit 0

# Check if any context files are also staged
HAS_CONTEXT=false
while IFS= read -r FILE; do
  case "$FILE" in
    CLAUDE.md|AGENTS.md|GEMINI.md) HAS_CONTEXT=true; break ;;
    .cursorrules|.windsurfrules|.clinerules) HAS_CONTEXT=true; break ;;
    .github/copilot-instructions.md) HAS_CONTEXT=true; break ;;
    llms.txt) HAS_CONTEXT=true; break ;;
  esac
done <<< "$STAGED_FILES"

# Block commit if structural changes without context updates
if [ "$HAS_CONTEXT" = false ]; then
  echo "COMMIT BLOCKED: Structural files (commands, skills, rules, or config) are staged but no AI context docs (CLAUDE.md, AGENTS.md, llms.txt, etc.) were updated. Update and stage the relevant context files before committing. Run /ai-context audit to check what needs updating, or /ai-context to regenerate." >&2
  exit 2
fi

echo '{}'
