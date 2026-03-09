---
title: "PitchDocs with Untether"
description: "How PitchDocs Context Guard hooks behave when Claude Code runs via Untether's Telegram bridge."
type: explanation
difficulty: beginner
last_verified: "1.19.3"
related:
  - guides/getting-started.md
  - guides/workflows.md
  - guides/command-reference.md
  - guides/troubleshooting.md
order: 8
---

# PitchDocs with Untether

> **Summary**: PitchDocs works out of the box with [Untether](https://github.com/littlebearapps/untether). One Context Guard hook adapts its behaviour automatically — no configuration needed, and no impact on standard Claude Code sessions.

---

## What Is Untether?

[Untether](https://github.com/littlebearapps/untether) is a Telegram bridge for AI coding agents. It lets you run Claude Code sessions remotely from your phone — send a task via Telegram, and Untether manages the Claude Code process on your development machine. When Untether launches Claude Code, it sets the `UNTETHER_SESSION=1` environment variable so that tools and plugins can detect the Telegram context.

---

## What Changes

Only the **Context Guard session-end nudge** (Tier 1) is affected. When `UNTETHER_SESSION` is set, the `context-guard-stop.sh` hook exits immediately instead of checking for stale AI context files.

### Why the Nudge Is Skipped

In Telegram's output model, the user sees only the final assistant message. If the Stop hook blocks Claude's exit to raise a "stale context files" concern, that meta-commentary replaces the actual work the user requested. Skipping the nudge preserves the user's output.

The Tier 2 commit guard still runs — stale context files are caught at commit time regardless.

### Hook Behaviour Summary

| Hook | Standard Session | Untether Session |
|------|-----------------|------------------|
| `context-guard-stop.sh` (Tier 1 — session-end nudge) | Checks for stale context files | **Skipped** |
| `context-drift-check.sh` (post-commit drift) | Warns after commits | No change |
| `context-structural-change.sh` (structural reminders) | Reminds on config changes | No change |
| `content-filter-guard.sh` (content filter protection) | Blocks high-risk writes | No change |
| `context-commit-guard.sh` (Tier 2 — commit guard) | Blocks commits with stale context | No change |

---

## What Does Not Change

All other PitchDocs features work identically in Untether sessions: skills, commands, agents, quality rules, and the other four Context Guard hooks. Feature extraction, README generation, docs-audit, AI context management, changelogs, and every slash command behave the same whether you're in a terminal or on Telegram.

---

## No Configuration Needed

Untether sets `UNTETHER_SESSION=1` automatically when it launches Claude Code. You do not need to configure anything in PitchDocs, pass any flags, or modify any hook files.

If you're not using Untether, this integration has zero effect. The environment variable is not present in standard Claude Code sessions, and the check is never reached.

---

## Technical Details

The detection is a single line in `context-guard-stop.sh`, before any file system operations:

```bash
[ -n "${UNTETHER_SESSION:-}" ] && echo '{}' && exit 0
```

This has zero performance cost — the shell test runs in microseconds and only triggers when the variable is set. The env var is set by Untether's runner (`src/untether/runners/claude.py`), not by PitchDocs.

---

## Security Considerations

The `UNTETHER_SESSION` variable only controls the advisory session-end nudge. It **cannot**:

- Bypass Tier 2 commit enforcement (`context-commit-guard.sh`)
- Disable content filter protection (`content-filter-guard.sh`)
- Suppress structural change reminders (`context-structural-change.sh`)
- Skip post-commit drift detection (`context-drift-check.sh`)

Manually setting `UNTETHER_SESSION=1` is equivalent to ignoring the nudge — which users can already do by dismissing it. There is no privilege escalation or security bypass.

---

## See Also

- [Getting Started](getting-started.md) — Install PitchDocs and Context Guard
- [Command Reference](command-reference.md) — `/pitchdocs:context-guard` commands
- [Troubleshooting](troubleshooting.md) — Context Guard FAQ
- [Untether on GitHub](https://github.com/littlebearapps/untether) — Installation and usage
