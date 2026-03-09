---
name: context-guard
description: Installs opt-in Claude Code hooks with two-tier enforcement for AI context file freshness. Tier 1 (Nudge) uses a Stop hook to remind about context updates before session end. Tier 2 (Guard) uses a PreToolUse hook to block commits with stale context docs. Also includes post-commit drift detection, structural change reminders, content filter write guards, and a quality rule. Claude Code only — hooks do not work in OpenCode, Codex CLI, or other tools.
version: "1.1.0"
---

# Context Guard

## What It Does

Context Guard adds hooks and a quality rule to keep AI context files (CLAUDE.md, AGENTS.md, GEMINI.md, .cursorrules, copilot-instructions.md, .windsurfrules, .clinerules) in sync with the codebase. It prevents content filter errors when generating standard OSS files, and provides two-tier enforcement for context doc freshness.

**Claude Code only.** These hooks use Claude Code's hook system (PreToolUse, PostToolUse, and Stop events via `.claude/settings.json`). OpenCode, Codex CLI, Cursor, Windsurf, Cline, and Gemini CLI do not support Claude Code hooks. The quality rule (`.claude/rules/context-quality.md`) is also Claude Code-specific.

Cross-tool features like skills (`.claude/skills/`) and AGENTS.md work in OpenCode and Codex CLI without Context Guard.

## Enforcement Tiers

| Tier | Name | Mechanism | Behaviour |
|------|------|-----------|-----------|
| 1 | Nudge | Stop hook | Advisory — suggests updating context docs before session ends. Claude can still stop if docs genuinely don't need changes. |
| 2 | Guard | PreToolUse on `git commit` | Blocking — prevents commits when structural files are staged without context doc updates. Exit code 2 blocks the commit. |

**Default install** (`/context-guard install`) activates Tier 1 only. Add Tier 2 with `/context-guard install strict`.

## Components

### Hook: context-drift-check.sh

- **Event:** PostToolUse on `Bash` (filters for `git commit` commands)
- **Fires:** After a successful git commit
- **Checks:**
  1. Compares each context file's last-modified commit vs the most recent source-code commit
  2. Detects broken file-path references inside context files
  3. Flags when `package.json` or `pyproject.toml` changed more recently than context files
- **Output:** Lists stale files and recommends `/ai-context audit`, or stays silent if everything is current
- **Throttle:** Max once per hour via `.git/.context-guard-last-check` timestamp

### Hook: context-structural-change.sh

- **Event:** PostToolUse on `Write|Edit`
- **Fires:** After creating or editing structural files (commands, skills, agents, rules, manifests, config)
- **Reminds:** Which context files may need updating based on the type of change
- **File patterns:**
  - `commands/*.md` → AGENTS.md, CLAUDE.md, llms.txt
  - `.claude/skills/*/SKILL.md` → AGENTS.md, CLAUDE.md, llms.txt
  - `.claude/agents/*.md` → AGENTS.md
  - `.claude/rules/*.md` → CLAUDE.md, AGENTS.md
  - `package.json`, `pyproject.toml`, config files → all context files

### Hook: content-filter-guard.sh

- **Event:** PreToolUse on `Write`
- **Fires:** Before Claude Code writes a file
- **HIGH-risk files** (CODE_OF_CONDUCT.md, LICENSE, SECURITY.md):
  - Blocks the write (exit non-zero)
  - Returns fetch commands for the canonical URL
- **MEDIUM-risk files** (CHANGELOG.md, CONTRIBUTING.md):
  - Allows the write
  - Returns advisory about chunked writing (5–10 entries at a time)
- **All other files:** Passes through silently

### Hook: context-guard-stop.sh (Tier 1)

- **Event:** Stop (no matcher — fires on every session end)
- **Fires:** When Claude considers ending the conversation
- **Checks:**
  1. Whether structural files (commands, skills, rules, config) have uncommitted changes
  2. Whether any context files (CLAUDE.md, AGENTS.md, llms.txt, etc.) were also modified
- **Loop prevention:** Checks `stop_hook_active` flag — if `true`, exits immediately to allow Claude to stop (prevents infinite loops)
- **Output:** Returns `{"decision": "block"}` with reason if structural changes exist without context updates, or stays silent

### Hook: context-commit-guard.sh (Tier 2)

- **Event:** PreToolUse on `Bash` (filters for `git commit` commands)
- **Fires:** Before a git commit command executes
- **Checks:**
  1. Whether structural files are in the staging area (`git diff --cached`)
  2. Whether any context files are also staged
- **Output:** Exit code 2 with stderr message to block the commit, or exit 0 to allow

### Rule: context-quality.md

Auto-loaded every session. Establishes cross-file consistency, path verification, version accuracy, command accuracy, context doc size guidance, and a sync-points table mapping project changes to context files.

## Installation

The `/context-guard install` command (Tier 1):

1. Copies 4 hook scripts to `.claude/hooks/` in the target project
2. Merges hook configuration into `.claude/settings.json`
3. Copies the quality rule to `.claude/rules/context-quality.md`
4. Makes hook scripts executable

The `/context-guard install strict` command (Tier 1 + Tier 2):

1. Performs all steps from `install` above
2. Additionally copies `context-commit-guard.sh` to `.claude/hooks/`
3. Adds a PreToolUse Bash entry for the commit guard to `.claude/settings.json`

### Settings.json Configuration (Tier 1 only)

```json
{
  "hooks": {
    "PreToolUse": [
      {
        "matcher": "Write",
        "hooks": [{ "type": "command", "command": ".claude/hooks/content-filter-guard.sh" }]
      }
    ],
    "PostToolUse": [
      {
        "matcher": "Bash",
        "hooks": [{ "type": "command", "command": ".claude/hooks/context-drift-check.sh" }]
      },
      {
        "matcher": "Write|Edit",
        "hooks": [{ "type": "command", "command": ".claude/hooks/context-structural-change.sh" }]
      }
    ],
    "Stop": [
      {
        "hooks": [{ "type": "command", "command": ".claude/hooks/context-guard-stop.sh" }]
      }
    ]
  }
}
```

### Additional Settings.json Entry (Tier 2 — strict)

```json
{
  "hooks": {
    "PreToolUse": [
      {
        "matcher": "Bash",
        "hooks": [{ "type": "command", "command": ".claude/hooks/context-commit-guard.sh" }]
      }
    ]
  }
}
```

## Uninstallation

The `/context-guard uninstall` command removes all hook scripts (context-drift-check.sh, context-structural-change.sh, content-filter-guard.sh, context-guard-stop.sh, context-commit-guard.sh), settings.json entries (PreToolUse, PostToolUse, and Stop), and the quality rule.

## Customisation

### Throttle Interval

Edit `context-drift-check.sh` line with `3600` (seconds) to change the check interval. Set to `0` to check on every commit.

### File Patterns

Edit `context-structural-change.sh` case statement to add or remove structural file patterns.

## Troubleshooting

| Issue | Cause | Fix |
|-------|-------|-----|
| Hooks not firing | Scripts not executable | `chmod +x .claude/hooks/*.sh` |
| No output after commit | Throttle active | Delete `.git/.context-guard-last-check` to reset |
| "jq: command not found" | jq not installed | Install jq: `apt install jq` or `brew install jq` |
| Hooks fail silently | jq receives malformed JSON | Run `.claude/hooks/context-drift-check.sh` manually and check for JSON parse errors — common when `settings.json` has trailing commas or comments |
| Hook errors in logs | Wrong project directory | Check `CLAUDE_PROJECT_DIR` is set correctly |
| Hook blocks legitimate writes | content-filter-guard too aggressive | Uninstall with `/context-guard uninstall`, or remove just the PreToolUse entry from `.claude/settings.json` |
| Claude keeps running in a loop | Stop hook not checking `stop_hook_active` | Verify `context-guard-stop.sh` checks `stop_hook_active` flag on line 19; if broken, remove the Stop entry from `.claude/settings.json` |
| Commit blocked but context docs don't need updating | Tier 2 false positive on config edits | Stage a context file with a minor update, or remove the PreToolUse Bash entry for `context-commit-guard.sh` from `.claude/settings.json` |
| Stop hook doesn't fire in Untether sessions | By design — `UNTETHER_SESSION` env var is set by Untether | Stop hook blocks would displace user content in Telegram's single-message output. All other hooks (drift check, structural reminders, content filter guard, commit guard) still work normally. |

## Untether / Headless Compatibility

When Claude Code runs via [Untether](https://github.com/littlebearapps/untether) (a Telegram bridge for AI coding agents), Stop hook blocks cause content displacement — the hook's meta-commentary replaces the user's requested output in the final Telegram message.

To prevent this, `context-guard-stop.sh` checks the `UNTETHER_SESSION` environment variable. When set, the Stop hook (Tier 1 session-end nudge) exits immediately without checking for structural changes.

**What's affected:**

| Hook | Behaviour in Untether |
|------|-----------------------|
| context-guard-stop.sh (Tier 1) | **Skipped** — exits immediately |
| context-drift-check.sh | Works normally |
| context-structural-change.sh | Works normally |
| content-filter-guard.sh | Works normally |
| context-commit-guard.sh (Tier 2) | Works normally |

**If you don't use Untether, this has no effect.** The `UNTETHER_SESSION` env var is only set by Untether's runner environment. It is not present in standard Claude Code sessions and the check is a no-op.

**Security:** The env var only affects the advisory session-end nudge. It cannot bypass the Tier 2 commit guard, disable content filter protection, or suppress structural change reminders. Setting it manually is equivalent to ignoring the nudge, which users can already do.
