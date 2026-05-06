---
description: "Generate or update ROADMAP.md from GitHub milestones and issues: $ARGUMENTS"
argument-hint: "[milestone name or 'full' for complete roadmap]"
allowed-tools:
  - Read
  - Glob
  - Grep
  - Bash
  - Write
  - Edit
  - mcp__github__list_issues
  - mcp__github__list_pull_requests
  - mcp__github__list_releases
  - mcp__github__list_tags
  - mcp__github__search_issues
---

# /roadmap

Generate or update ROADMAP.md from GitHub milestones, issues, and project boards.

## Behaviour

1. Load the `roadmap` skill for structure and format
2. Load the `doc-standards` rule for tone
3. If GitHub MCP tools are unavailable (GitLab/Bitbucket), gather data via `glab` CLI, REST API, or git history. Load `platform-profiles` for CLI equivalents.
4. Gather data from the hosting platform:
   - Milestones and their issues
   - Issues labelled `enhancement` or `feature`
   - Recent releases/tags for completed milestones
5. Structure into current, upcoming, and completed milestones
6. Add mission statement (from README or package description)
7. Add "How to get involved" section
8. Write ROADMAP.md

## Arguments

- No arguments: generates full roadmap
- Milestone name: focuses on a specific milestone
- `full`: regenerates from scratch (discards existing content)

## Data Sources (Priority Order)

1. GitHub Milestones (primary — best structured)
2. Issues with milestone assignments
3. Issues labelled `enhancement`/`feature` (if no milestones)
4. Git tags for completed versions
5. README/package.json for mission statement

## Output

Writes directly to `ROADMAP.md`. Links issues, uses emoji status indicators, includes comparison links between versions.
