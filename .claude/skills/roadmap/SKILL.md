---
name: roadmap
description: Generates ROADMAP.md from project milestones, issues, and boards (GitHub, GitLab, or Bitbucket). Structures content with mission statement, current milestone progress, upcoming milestones, and community involvement section. Use when creating or updating a project roadmap.
version: "1.0.0"
---

# Roadmap Generator

## ROADMAP.md Structure

```markdown
# Roadmap

> **Mission**: [One sentence describing the project's north star goal]

This roadmap reflects our current plans and priorities. It's a living document — priorities shift based on community feedback and real-world usage.

**Last updated**: [Date]

## Legend

| Status | Meaning |
|--------|---------|
| :white_check_mark: Done | Shipped and available |
| :construction: In Progress | Actively being worked on |
| :dart: Planned | Committed for this milestone |
| :thought_balloon: Exploring | Under consideration, feedback welcome |

---

## Current Milestone: v1.3 — [Milestone Title]

**Target**: Q1 2026 · **Progress**: 6/10 items complete

| Status | Feature | Issue | Notes |
|--------|---------|-------|-------|
| :white_check_mark: | Marketing-friendly README generation | #42 | Shipped in v1.2 |
| :white_check_mark: | Changelog from conventional commits | #38 | Shipped in v1.2 |
| :construction: | GitHub Projects integration | #45 | PR open |
| :construction: | User-benefit language in changelogs | #44 | In review |
| :dart: | Comparison table generator | #50 | Starting next sprint |
| :dart: | CONTRIBUTING.md generator | #48 | Blocked on #45 |

---

## Upcoming

### v1.4 — [Milestone Title] (Q2 2026)

| Status | Feature | Issue |
|--------|---------|-------|
| :dart: | Full docs suite audit command | #55 |
| :dart: | GitHub issue template generator | #56 |
| :thought_balloon: | Blog post generator from README | #60 |
| :thought_balloon: | Multi-language README support | #62 |

### v2.0 — [Milestone Title] (Q3 2026)

| Status | Feature | Issue |
|--------|---------|-------|
| :thought_balloon: | Interactive README builder | #70 |
| :thought_balloon: | Auto-update on CI | #72 |

---

## Completed Milestones

<details>
<summary>v1.2 — Documentation Foundation (January 2026)</summary>

- :white_check_mark: Basic README generation (#10)
- :white_check_mark: Badge detection and generation (#12)
- :white_check_mark: Package.json/pyproject.toml parsing (#15)
- :white_check_mark: Quick start section generator (#18)

</details>

---

## How to Get Involved

We'd love your input on what to build next:

- **Vote on features**: React with :+1: on issues you want prioritised
- **Propose ideas**: [Open a discussion](link)
- **Contribute**: See [CONTRIBUTING.md](CONTRIBUTING.md) for how to get started
- **Report issues**: [File a bug](link)

Items marked :thought_balloon: are especially open to community feedback.
```

## Data Sources

Data source commands below default to GitHub (`gh` CLI / `mcp__github__*`). For GitLab, use `glab` CLI. For Bitbucket, use REST API or Jira integration. Load the `platform-profiles` skill for CLI and API equivalents.

### Milestones (via platform CLI or MCP)

```bash
# GitHub
gh issue list --milestone "v1.3" --state all

# GitLab
glab issue list --milestone "v1.3" --all
```

Use milestones to group features into releases. Each milestone becomes a section. GitLab also supports Epics for higher-level grouping across milestones.

### Project Boards

If the repo uses project boards (GitHub Projects v2, GitLab Boards, or Jira), pull items from there:
1. Get board items
2. Map columns/statuses to roadmap legend
3. Extract issue numbers and titles

### Git Tags

```bash
git tag --sort=-v:refname | head -20
```

Map tags to completed milestones. Include completion dates.

### Open Issues with Labels

```bash
# GitHub
gh issue list --label "enhancement" --state open --limit 50
gh issue list --label "feature" --state open --limit 50

# GitLab
glab issue list --label "enhancement" --all --per-page 50
glab issue list --label "feature" --all --per-page 50
```

## Language Rules

- **Mission statement**: One sentence, present tense, aspirational but concrete
- **Feature descriptions**: Benefit-focused, not implementation-focused
- **Status updates**: Factual, linked to issues/PRs
- **Timeline**: Use quarters (Q1/Q2/Q3/Q4), not specific dates (they create pressure and disappointment)
- **Tone**: Transparent, inviting, community-oriented

## Anti-Patterns

- **Don't promise specific dates** — use quarters or "upcoming"
- **Don't list every issue** — curate to significant features
- **Don't include internal tasks** — roadmaps are for users
- **Don't forget completed milestones** — they show momentum
- **Don't make it static** — include "last updated" date
- **Don't forget the "get involved" section** — roadmaps are conversation starters
