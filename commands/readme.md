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

1. Run the `docs-writer` agent (which auto-detects the hosting platform)
2. If GitHub MCP tools are unavailable (GitLab/Bitbucket), gather equivalent data via `glab` CLI, REST API, or git history. Load the `platform-profiles` skill for platform-specific guidance.
3. Load the `public-readme` skill for README structure and the marketing framework
4. Load the `feature-benefits` skill for the 7-step extraction workflow
5. Load the `geo-optimisation` skill for citation capsules and AI-friendly structure
6. Load the `visual-standards` skill if the README needs screenshots or emoji heading prefixes
7. Generate README.md following the skills' structure and the auto-loaded `doc-standards` rule

## Arguments

- No arguments: generates README for current directory
- Path argument: generates README for the specified project directory
- Description argument: focuses the README on specific aspects (e.g., "focus on the CLI interface")

## Output

Writes directly to `README.md` in the target directory. If a README already exists, it is read first and either updated or regenerated based on quality assessment.

## Quality Check

After generation, verify:
- Hero has three parts: bold one-liner + explanatory sentence + badges/compatibility line
- First paragraph is understandable by a non-developer
- README follows the Lobby Principle — no more than 8 features, 5–7 examples, exhaustive content delegated to guides
- All badge URLs are correct for this repo
- Quick start code examples actually work
- Links to existing docs/guides are included
- Consistent spelling throughout
- Features use emoji+bold+em-dash bullets or table with benefits column (evidence-based claims)
- At least 3 different benefit categories used across the features section
- Use-case scenarios framed with reader context (if "What X Does" section is present)
- Cross-renderer compatibility verified if published to npm or PyPI (load `package-registry` skill)
- Registry-specific badges included with correct package names and links
- Image URLs use absolute paths (not relative) if published to npm or PyPI
