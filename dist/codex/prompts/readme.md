---
description: "Generate or update a marketing-friendly README.md: $ARGUMENTS"
argument-hint: "[project-path or description of focus]"
allowed-tools:
  - Read
  - Glob
  - Grep
  - Bash
  - Write
  - Edit
  - WebFetch
  - mcp__github__get_file_contents
  - mcp__github__list_releases
  - mcp__github__list_tags
---

# /readme

Generate or update a README.md that sells as well as it informs.

## Behaviour

1. Run the `docs-writer` agent (which auto-detects the hosting platform and chooses lightweight or full research based on project size)
2. Load the `public-readme` skill for README structure and the marketing framework
3. Load the `feature-benefits` skill for the 7-step extraction workflow
4. Load additional skills **only when needed**:
   - `geo-optimisation` — load when writing citation capsules or optimising for AI search
   - `visual-standards` — load only if the README needs screenshots or emoji heading prefixes (7+ sections)
   - `platform-profiles` — load only for non-GitHub repos (GitLab/Bitbucket)

## Arguments

- No arguments: generates README for current directory
- Path argument: generates README for the specified project directory
- Description argument: focuses the README on specific aspects (e.g., "focus on the CLI interface")
- `--review`: force the review phase even for new READMEs
- `--no-review`: skip the review phase even for updates

## Output

Writes directly to `README.md` in the target directory. If a README already exists, it is read first and either updated or regenerated based on quality assessment.

## Quality Check

After generation, verify:
- Hero has three parts: bold one-liner + explanatory sentence + badges/compatibility line
- First paragraph is understandable by a non-developer
- README follows the Lobby Principle — no more than 8 features, 5–7 examples, exhaustive content delegated to guides
- All badge URLs are correct for this repo
- Quick start code examples actually work
- Features use emoji+bold+em-dash bullets or table with benefits column (evidence-based claims)
- At least 3 different benefit categories used across the features section
- Consistent spelling throughout
