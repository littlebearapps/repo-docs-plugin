#!/usr/bin/env bash
# build-dist.sh — Generate platform-specific distributions from canonical .claude/ sources
# Usage: bash scripts/build-dist.sh [--check]
#   --check: Verify dist/ is in sync without modifying (for CI)
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
ROOT="$(cd "$SCRIPT_DIR/.." && pwd)"
DIST="$ROOT/dist"
SKILLS_DIR="$ROOT/.claude/skills"
COMMANDS_DIR="$ROOT/commands"
AGENTS_DIR="$ROOT/agents"
RULES_DIR="$ROOT/rules"
FLAT_AGENT="$AGENTS_DIR/docs-writer-flat.md"

CHECK_MODE=false
[ "${1:-}" = "--check" ] && CHECK_MODE=true

# If check mode, work in a temp dir and compare
if $CHECK_MODE; then
    DIST=$(mktemp -d)
    trap 'rm -rf "$DIST"' EXIT
fi

log() { printf '  %s\n' "$1"; }
header() { printf '\n==> %s\n' "$1"; }

# ─────────────────────────────────────────────
# Helpers
# ─────────────────────────────────────────────

# Extract YAML frontmatter value from a Markdown file
frontmatter_val() {
    local file="$1" key="$2"
    sed -n '/^---$/,/^---$/p' "$file" | grep "^${key}:" | sed "s/^${key}: *\"\{0,1\}\(.*\)\"\{0,1\}$/\1/" | sed 's/"$//'
}

# Strip YAML frontmatter from Markdown, return body only
strip_frontmatter() {
    local file="$1"
    awk 'BEGIN{fm=0} /^---$/{fm++; next} fm>=2{print}' "$file"
}

# Convert a PitchDocs command .md to Gemini CLI .toml
command_to_toml() {
    local src="$1" dest="$2"
    local desc body name
    desc=$(frontmatter_val "$src" "description" | sed 's/: \$ARGUMENTS$//')
    name=$(basename "$src" .md)
    body=$(strip_frontmatter "$src")

    cat > "$dest" <<TOML
description = "${desc}"

[prompt]
text = """
${body}

---
For the full PitchDocs skill reference, read the corresponding SKILL.md file
from the PitchDocs skills/ directory.
"""
TOML
}

# Convert a PitchDocs command .md to Cursor .mdc agent-selected rule
command_to_mdc() {
    local src="$1" dest="$2"
    local desc body
    desc=$(frontmatter_val "$src" "description" | sed 's/: \$ARGUMENTS$//')
    body=$(strip_frontmatter "$src")

    cat > "$dest" <<MDC
---
description: "${desc} — PitchDocs documentation standards and workflow"
---

${body}
MDC
}

# Copy all skills to a target directory (preserving subdirectory structure)
copy_skills() {
    local target="$1"
    mkdir -p "$target"
    for skill_dir in "$SKILLS_DIR"/*/; do
        local skill_name
        skill_name=$(basename "$skill_dir")
        mkdir -p "${target}/${skill_name}"
        cp "$skill_dir"SKILL*.md "${target}/${skill_name}/"
    done
}

# ─────────────────────────────────────────────
# Platform builds
# ─────────────────────────────────────────────

build_codex() {
    header "Codex CLI"
    local d="$DIST/codex"
    rm -rf "$d"
    mkdir -p "$d/.agents/skills" "$d/.codex/agents" "$d/prompts"

    # Skills — copy to .agents/skills/ (Codex native path)
    copy_skills "$d/.agents/skills"
    log "Copied 15 skills to .agents/skills/"

    # Agent — flat-mode writer
    cp "$FLAT_AGENT" "$d/.codex/agents/pitchdocs-writer.md"
    log "Copied flat-mode agent to .codex/agents/"

    # Commands — copy as prompt files (Codex reads Markdown prompts)
    for cmd in "$COMMANDS_DIR"/*.md; do
        local name
        name=$(basename "$cmd")
        # Skip stubs
        case "$name" in
            ai-context.md|context-guard.md) continue ;;
        esac
        cp "$cmd" "$d/prompts/$name"
    done
    log "Copied 14 command prompts to prompts/"

    # AGENTS.md — copy from root
    [ -f "$ROOT/AGENTS.md" ] && cp "$ROOT/AGENTS.md" "$d/AGENTS.md"
    log "Copied AGENTS.md"

    # Doc standards
    cp "$RULES_DIR/doc-standards.md" "$d/doc-standards.md"
    log "Copied doc-standards.md"
}

build_gemini() {
    header "Gemini CLI"
    local d="$DIST/gemini"
    rm -rf "$d"
    mkdir -p "$d/skills" "$d/commands"

    # Extension manifest
    cat > "$d/gemini-extension.json" <<'JSON'
{
  "name": "pitchdocs",
  "version": "2.2.0",
  "description": "Generate high-quality public-facing repository documentation with a marketing edge.",
  "author": "Little Bear Apps",
  "homepage": "https://github.com/littlebearapps/pitchdocs"
}
JSON
    log "Created gemini-extension.json"

    # Skills — copy to skills/ (Gemini extension path)
    copy_skills "$d/skills"
    log "Copied 15 skills to skills/"

    # Commands — convert to TOML
    for cmd in "$COMMANDS_DIR"/*.md; do
        local name
        name=$(basename "$cmd" .md)
        case "$name" in
            ai-context|context-guard) continue ;;
        esac
        command_to_toml "$cmd" "$d/commands/${name}.toml"
    done
    log "Created 14 TOML command files"

    # Context file
    [ -f "$ROOT/GEMINI.md" ] && cp "$ROOT/GEMINI.md" "$d/GEMINI.md"
    log "Copied GEMINI.md"

    # Doc standards
    cp "$RULES_DIR/doc-standards.md" "$d/doc-standards.md"
    log "Copied doc-standards.md"
}

build_cursor() {
    header "Cursor"
    local d="$DIST/cursor"
    rm -rf "$d"
    mkdir -p "$d/.cursor/rules" "$d/.cursor/agents"

    # Rules — doc-standards as agent-selected .mdc
    local body
    body=$(strip_frontmatter "$RULES_DIR/doc-standards.md")
    cat > "$d/.cursor/rules/pitchdocs-standards.mdc" <<MDC
---
description: PitchDocs documentation quality standards — 4-question framework, benefit-driven language, progressive disclosure, marketing-friendly structure. Activate when generating or reviewing documentation.
---

${body}
MDC
    log "Created pitchdocs-standards.mdc"

    # Rules — content-filter as agent-selected .mdc
    body=$(strip_frontmatter "$ROOT/.claude/rules/content-filter.md")
    cat > "$d/.cursor/rules/pitchdocs-filter.mdc" <<MDC
---
description: Content filter mitigation for generating OSS documentation files (CODE_OF_CONDUCT, LICENSE, SECURITY, CHANGELOG, CONTRIBUTING). Activate when writing these file types.
---

${body}
MDC
    log "Created pitchdocs-filter.mdc"

    # Agent — flat-mode writer
    cp "$FLAT_AGENT" "$d/.cursor/agents/pitchdocs-writer.md"
    log "Copied flat-mode agent to .cursor/agents/"
}

build_opencode() {
    header "OpenCode"
    local d="$DIST/opencode"
    rm -rf "$d"
    mkdir -p "$d"

    cat > "$d/README.md" <<'EOF'
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
EOF
    log "Created OpenCode README"
}

build_cline() {
    header "Cline"
    local d="$DIST/cline"
    rm -rf "$d"
    mkdir -p "$d/.clinerules"

    # Rules — doc-standards as .clinerules
    cp "$RULES_DIR/doc-standards.md" "$d/.clinerules/pitchdocs-standards.md"
    log "Created .clinerules/pitchdocs-standards.md"

    # Content filter
    cp "$ROOT/.claude/rules/content-filter.md" "$d/.clinerules/pitchdocs-content-filter.md"
    log "Created .clinerules/pitchdocs-content-filter.md"

    cat > "$d/README.md" <<'EOF'
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
EOF
    log "Created Cline README"
}

build_windsurf() {
    header "Windsurf"
    local d="$DIST/windsurf"
    rm -rf "$d"
    mkdir -p "$d/.windsurf/rules"

    # Distilled rule — must be under 6,000 chars
    cat > "$d/.windsurf/rules/pitchdocs.md" <<'RULE'
# PitchDocs Documentation Standards

## The 4-Question Test

Every document must answer: (1) Does this solve my problem? (2) Can I use it? (3) Who made it? (4) Where do I learn more?

## Progressive Disclosure (Lobby Principle)

The README is the lobby — enough to decide whether to enter, not the entire building.
- First paragraph: non-technical, benefit-focused
- Quick start: copy-paste-ready, 5-7 lines
- Features: 8 or fewer emoji+bold+em-dash bullets
- Detailed content: delegate to docs/guides/

If a section exceeds 2 paragraphs or an 8-row table, move it to a guide.

## Feature-to-Benefit Writing

Pattern: `[Technical feature] so you can [user outcome] — [evidence]`
Use at least 3 of: time saved, confidence gained, pain avoided, capability unlocked, cost reduced.

## Tone

- Professional-yet-approachable, confident, not corporate
- "You can now..." not "We implemented..."
- Active voice, short sentences, no jargon without explanation
- Match the project's existing locale and spelling conventions

## Banned Phrases

Never use: "in today's digital landscape", "dive into", "leverage", "game-changer", "cutting-edge", "seamless", "robust", "furthermore", "revolutionise", "utilise", "comprehensive", "navigate the complexities", "elevate your". No "simple", "easy", or "powerful" without evidence.

## README Structure

1. Hero: bold one-liner + explanatory sentence + badges
2. Quick Start: achieves Time to Hello World
3. Features: emoji+bold+em-dash bullets or table with benefits column
4. Why [Project]?: comparison table vs alternatives
5. Documentation links
6. Contributing/Community
7. Licence

## Content Filter (High-Risk Files)

Fetch these from canonical URLs rather than generating inline:
- CODE_OF_CONDUCT.md: `curl -sL "https://www.contributor-covenant.org/version/3/0/code_of_conduct/code_of_conduct.md"`
- LICENSE: `curl -sL "https://raw.githubusercontent.com/spdx/license-list-data/main/text/MIT.txt"`
- SECURITY.md: Fetch template, then customise

For CHANGELOG.md and CONTRIBUTING.md, write in chunks (5-10 entries at a time).

## Skills Reference

For detailed guidance, read PitchDocs skill files from the cloned repo:
- `public-readme/SKILL.md` — Full README framework with hero structure, badges, CTAs
- `feature-benefits/SKILL.md` — 7-step feature extraction and benefit translation
- `changelog/SKILL.md` — Conventional commits to user-benefit changelog
- `geo-optimisation/SKILL.md` — Citation capsules and AI search optimisation
RULE

    # Check char count
    local chars
    chars=$(wc -c < "$d/.windsurf/rules/pitchdocs.md")
    if [ "$chars" -gt 6000 ]; then
        log "WARNING: pitchdocs.md is ${chars} chars (limit: 6,000)"
    else
        log "Created pitchdocs.md (${chars} chars, under 6,000 limit)"
    fi
}

build_goose() {
    header "Goose"
    local d="$DIST/goose"
    rm -rf "$d"
    mkdir -p "$d/recipes"

    # .goosehints template
    cat > "$d/.goosehints" <<'HINTS'
# PitchDocs Documentation Standards

When generating public-facing repository documentation, follow these principles:

## 4-Question Framework
Every document must answer: (1) Does this solve my problem? (2) Can I use it? (3) Who made it? (4) Where do I learn more?

## Progressive Disclosure
README is the lobby — first paragraph non-technical, quick start copy-paste-ready (5-7 lines), features 8 or fewer items. Delegate detailed content to docs/guides/.

## Feature-to-Benefit Writing
Pattern: [Technical feature] so you can [user outcome] — [evidence]
Use at least 3 benefit categories: time saved, confidence gained, pain avoided, capability unlocked, cost reduced.

## Tone
Professional-yet-approachable. "You can now..." not "We implemented...". Active voice, short sentences. Match project locale.

## Banned Phrases
Never use: "in today's digital landscape", "dive into", "leverage", "game-changer", "cutting-edge", "seamless", "robust", "furthermore", "revolutionise", "utilise", "comprehensive", "navigate the complexities", "elevate your".

## PitchDocs Skills
For detailed guidance on specific documentation types, read the SKILL.md files from:
/path/to/pitchdocs/.claude/skills/

Key skills: public-readme, feature-benefits, changelog, geo-optimisation, docs-verify
HINTS
    log "Created .goosehints template"

    # Recipe: readme
    cat > "$d/recipes/pitchdocs-readme.yaml" <<'YAML'
name: pitchdocs-readme
description: Generate a marketing-friendly README using PitchDocs standards
steps:
  - prompt: |
      Read the PitchDocs public-readme skill and feature-benefits skill, then
      scan this codebase and generate a README.md.

      Follow the 4-question framework, progressive disclosure (Lobby Principle),
      and benefit-driven language. Hero section needs bold one-liner + explanatory
      sentence + badges. Features section uses emoji+bold+em-dash bullets with
      evidence from the codebase. Quick start must be copy-paste-ready.

      Skills to reference:
      - /path/to/pitchdocs/.claude/skills/public-readme/SKILL.md
      - /path/to/pitchdocs/.claude/skills/feature-benefits/SKILL.md
YAML
    log "Created readme recipe"

    # Recipe: changelog
    cat > "$d/recipes/pitchdocs-changelog.yaml" <<'YAML'
name: pitchdocs-changelog
description: Generate CHANGELOG.md from git history using benefit language
steps:
  - prompt: |
      Read the PitchDocs changelog skill, then analyse this project's git
      history and generate a CHANGELOG.md.

      Use Keep a Changelog format. Rewrite commit messages in user-benefit
      language ("You can now..." not "Refactored internal..."). Exclude
      internal refactors that don't affect users.

      Skill to reference:
      - /path/to/pitchdocs/.claude/skills/changelog/SKILL.md
YAML
    log "Created changelog recipe"

    # Recipe: features
    cat > "$d/recipes/pitchdocs-features.yaml" <<'YAML'
name: pitchdocs-features
description: Extract features and benefits from this codebase
steps:
  - prompt: |
      Read the PitchDocs feature-benefits skill, then scan this codebase
      across 10 signal categories and extract features with evidence.

      Classify features by tier (Hero 1-3, Core 4-8, Supporting 9+).
      Translate each feature to benefit language using one of 5 categories:
      time saved, confidence gained, pain avoided, capability unlocked,
      cost reduced.

      Skill to reference:
      - /path/to/pitchdocs/.claude/skills/feature-benefits/SKILL.md
YAML
    log "Created features recipe"
}

build_aider() {
    header "Aider"
    local d="$DIST/aider"
    rm -rf "$d"
    mkdir -p "$d"

    cat > "$d/.aider.conf.yml" <<'YAML'
# PitchDocs documentation standards
# Add these entries to your project's .aider.conf.yml
read:
  - /path/to/pitchdocs/rules/doc-standards.md
  # Add specific skills as needed:
  # - /path/to/pitchdocs/.claude/skills/public-readme/SKILL.md
  # - /path/to/pitchdocs/.claude/skills/feature-benefits/SKILL.md
  # - /path/to/pitchdocs/.claude/skills/changelog/SKILL.md
YAML
    log "Created .aider.conf.yml snippet"

    # CONVENTIONS.md with PitchDocs standards
    cp "$RULES_DIR/doc-standards.md" "$d/CONVENTIONS.md"
    log "Created CONVENTIONS.md from doc-standards"
}

# ─────────────────────────────────────────────
# Main
# ─────────────────────────────────────────────

header "Building PitchDocs distributions"
echo "Source: $ROOT"
echo "Output: $DIST"

build_codex
build_gemini
build_cursor
build_opencode
build_cline
build_windsurf
build_goose
build_aider

# Summary
echo ""
header "Build complete"
echo ""
PLATFORMS=0
for platform_dir in "$DIST"/*/; do
    [ -d "$platform_dir" ] || continue
    name=$(basename "$platform_dir")
    files=$(find "$platform_dir" -type f | wc -l)
    printf "  %-12s %3d files\n" "$name" "$files"
    PLATFORMS=$((PLATFORMS + 1))
done
echo ""
echo "  Total: $PLATFORMS platforms"

# Check mode: compare with existing dist/
if $CHECK_MODE; then
    REAL_DIST="$ROOT/dist"
    if [ ! -d "$REAL_DIST" ]; then
        echo ""
        echo "ERROR: dist/ does not exist. Run 'bash scripts/build-dist.sh' to generate."
        exit 1
    fi

    # Compare directory trees
    DIFF_OUTPUT=$(diff <(cd "$DIST" && find . -type f | sort) <(cd "$REAL_DIST" && find . -type f | sort) 2>&1 || true)
    if [ -n "$DIFF_OUTPUT" ]; then
        echo ""
        echo "ERROR: dist/ is out of sync with .claude/ sources."
        echo "$DIFF_OUTPUT"
        exit 1
    fi

    # Compare file contents
    CONTENT_DIFF=false
    while IFS= read -r file; do
        if ! diff -q "$DIST/$file" "$REAL_DIST/$file" > /dev/null 2>&1; then
            echo "CHANGED: $file"
            CONTENT_DIFF=true
        fi
    done < <(cd "$DIST" && find . -type f | sort)

    if $CONTENT_DIFF; then
        echo ""
        echo "ERROR: dist/ content is stale. Run 'bash scripts/build-dist.sh' to regenerate."
        exit 1
    fi

    echo ""
    echo "OK: dist/ is in sync with .claude/ sources."
fi
