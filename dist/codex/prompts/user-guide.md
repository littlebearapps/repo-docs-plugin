---
description: "Generate user guide documentation for the repository: $ARGUMENTS"
argument-hint: "[topic or 'all' for full guide suite]"
allowed-tools:
  - Read
  - Glob
  - Grep
  - Bash
  - Write
  - Edit
  - mcp__github__list_issues
  - mcp__github__search_issues
---

# /user-guide

Generate task-oriented user guides and how-to documentation.

## Behaviour

1. Load the `user-guides` skill for structure and templates
2. Load the `doc-standards` rule for tone and language
3. If GitHub MCP tools are unavailable (GitLab/Bitbucket), gather equivalent data via `glab` CLI, REST API, or git history
4. Analyse the project to determine what guides are needed:
   - Check existing docs for gaps
   - Scan GitHub issues/discussions for common questions
   - Identify config files, CLI commands, and workflows users need to understand
5. Generate guide files in `docs/guides/`
6. Create or update `docs/README.md` as a hub page
7. Update `README.md` to link to the documentation section

## Arguments

- No arguments: analyses project and generates the most-needed guides
- Topic name (e.g., `deployment`, `configuration`): generates a specific guide
- `all`: generates the full guide suite (getting-started, configuration, deployment, troubleshooting)
- `hub`: only generates the docs/README.md hub page linking existing guides

## Guide Priority

1. **Getting Started** — always generated first (expanded quickstart)
2. **Configuration** — if config files or env vars exist
3. **Task-specific guides** — based on project features and common questions
4. **Deployment** — if the project has deploy scripts or CI/CD
5. **Migration** — if there are breaking version changes
6. **Troubleshooting** — compiled from closed issues and error patterns

## Output

- Creates `docs/guides/` directory structure
- Creates `docs/README.md` hub page
- Updates `README.md` with documentation links section
- Each guide follows the numbered-steps format with verification steps

## Cross-Linking

After generating guides, ensure:
- README.md links to `docs/README.md` and key guides
- CONTRIBUTING.md links to getting-started guide
- Each guide links to related guides and back to the hub
- Troubleshooting guide is referenced from other guides' error sections
