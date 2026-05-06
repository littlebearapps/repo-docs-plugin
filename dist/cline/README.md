# PitchDocs for Cline

Cline supports skills and has a rich hook system. Here's how to use PitchDocs.

## Setup

1. Copy `.clinerules/` files into your project root
2. Reference PitchDocs skill files on demand in your Cline session:

```
Read /path/to/pitchdocs/.claude/skills/public-readme/SKILL.md and use it to
generate a README for this project
```

## Skills

Cline has skill support. If your version reads SKILL.md files, copy the
`.claude/skills/` directory into your project and reference skills by name.

## Hooks

Cline's PreToolUse hooks could potentially support the content-filter-guard.
See the PitchDocs `hooks/` directory for the source script.
