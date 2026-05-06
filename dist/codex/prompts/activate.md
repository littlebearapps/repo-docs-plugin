---
description: "Install, uninstall, or check status of PitchDocs per-project features: $ARGUMENTS"
argument-hint: "[install|install strict|uninstall|status]"
allowed-tools:
  - Read
  - Glob
  - Grep
  - Bash
  - Write
  - Edit
---

# /activate

Install PitchDocs' advisory rules and docs-freshness agent into the current project. By default, PitchDocs only provides commands globally — the rules that suggest documentation improvements and the agent that checks freshness are opt-in per-project.

PitchDocs has two tiers:

- **Standard** (default): Advisory. Doc-standards and docs-awareness rules auto-load for this project. The docs-freshness agent is available for quick freshness checks.
- **Strict** (opt-in): Adds the content-filter-guard hook, which blocks writing high-risk OSS files (CODE_OF_CONDUCT.md, LICENSE, SECURITY.md) and advises on medium-risk files. **Claude Code only.**

## Behaviour

1. Determine the plugin's install location (the directory containing this command file)
2. Execute the requested action: `install`, `install strict`, `uninstall`, or `status`

## Arguments

- **`install`**: Install PitchDocs Standard into the current project:
  1. Create `.claude/rules/` directory if it does not exist
  2. Copy `doc-standards.md` and `docs-awareness.md` from the plugin's `rules/` directory to `.claude/rules/`
  3. Create `.claude/agents/` directory if it does not exist
  4. Copy `docs-freshness.md` from the plugin's `agents/` directory to `.claude/agents/`
  5. Report what was installed

- **`install strict`**: Install PitchDocs Standard + Strict into the current project:
  1. Perform all steps from `install` above
  2. Create `.claude/hooks/` directory if it does not exist
  3. Copy `content-filter-guard.sh` from the plugin's `hooks/` directory to `.claude/hooks/`
  4. Make the script executable (`chmod +x`)
  5. Merge a PreToolUse Write hook entry into `.claude/settings.json` (create the file if needed; if the entry already exists, do not duplicate it)
  6. Report what was installed, noting Strict tier is active

- **`uninstall`**: Remove all PitchDocs per-project features:
  1. Remove `.claude/rules/doc-standards.md` and `.claude/rules/docs-awareness.md`
  2. Remove `.claude/agents/docs-freshness.md`
  3. Remove `.claude/hooks/content-filter-guard.sh` if present
  4. Remove the content-filter-guard PreToolUse Write hook entry from `.claude/settings.json` if present (preserve other hooks)
  5. Report what was removed

- **`status`**: Check installation state:
  1. Check if rules exist in `.claude/rules/` (`doc-standards.md`, `docs-awareness.md`)
  2. Check if the docs-freshness agent exists in `.claude/agents/`
  3. Check if the content-filter-guard hook exists in `.claude/hooks/`
  4. Check if the hook entry is present in `.claude/settings.json`
  5. Determine which tier is active (Standard if rules + agent present, Strict if hook also present)
  6. Report findings

## Hook Configuration (Strict Tier)

When installing strict, merge this entry into `.claude/settings.json`:

```json
{
  "hooks": {
    "PreToolUse": [
      {
        "matcher": "Write",
        "hooks": [
          {
            "type": "command",
            "command": ".claude/hooks/content-filter-guard.sh"
          }
        ]
      }
    ]
  }
}
```

If `.claude/settings.json` already exists with other hooks, merge the PreToolUse entry without overwriting existing entries. If the content-filter-guard entry already exists (e.g. from ContextDocs), do not duplicate it.

## Output

### Install
```
PitchDocs activated (Standard):
  + .claude/rules/doc-standards.md — documentation quality standards
  + .claude/rules/docs-awareness.md — smart command suggestions at documentation moments
  + .claude/agents/docs-freshness.md — lightweight freshness checker with command suggestions

Strict tier not installed. Run /pitchdocs:activate install strict to also
add the content-filter-guard hook (blocks writing high-risk OSS files).

Tip: Add .claude/rules/ and .claude/agents/ to version control so your
team benefits from the same documentation standards.
```

### Install Strict
```
PitchDocs activated (Standard + Strict):
  + .claude/rules/doc-standards.md — documentation quality standards
  + .claude/rules/docs-awareness.md — smart command suggestions at documentation moments
  + .claude/agents/docs-freshness.md — lightweight freshness checker with command suggestions
  + .claude/hooks/content-filter-guard.sh — blocks writing high-risk OSS files
  + .claude/settings.json — PreToolUse Write hook registered

Note: The hook is Claude Code-specific. If your team also uses other AI coding
tools, the hook will be ignored (no errors, just no effect).
Add .claude/hooks/ to .gitignore if you prefer hooks to be per-developer.
```

### Status
```
PitchDocs Status:
  + Standard tier active
    + .claude/rules/doc-standards.md — present
    + .claude/rules/docs-awareness.md — present
    + .claude/agents/docs-freshness.md — present
  - Strict tier not installed
    - .claude/hooks/content-filter-guard.sh — not present

Run /pitchdocs:activate install strict to add the content-filter-guard hook.
```

### Uninstall
```
PitchDocs deactivated:
  - .claude/rules/doc-standards.md — removed
  - .claude/rules/docs-awareness.md — removed
  - .claude/agents/docs-freshness.md — removed
  - .claude/hooks/content-filter-guard.sh — not present (skipped)

PitchDocs commands (/pitchdocs:readme, /pitchdocs:features, etc.) remain
available globally. Only per-project advisory features were removed.
```
