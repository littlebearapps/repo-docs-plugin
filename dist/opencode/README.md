# PitchDocs for OpenCode

OpenCode reads `.claude/skills/` natively — PitchDocs works out of the box.

## What Works

- **Skills**: All 15 SKILL.md files load automatically from `.claude/skills/`
- **Commands**: Command files in `commands/` resolve as slash commands
- **AGENTS.md**: Loaded as the primary context file
- **Rules**: Copy `rules/doc-standards.md` content into your AGENTS.md for quality standards

## Setup

Install PitchDocs as you would for Claude Code. OpenCode reads the same directory
structure, so no additional setup is needed.

If you have the GitHub MCP server configured, the docs-writer agent can access
repository metadata, issues, and releases.

## Known Differences

- Sub-agent spawning via the `Agent` tool may behave differently — test with
  your OpenCode version
- MCP tool names (`mcp__github__*`) work if you have the GitHub MCP server
  configured with the same naming convention
