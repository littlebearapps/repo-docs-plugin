#!/usr/bin/env bash
# setup.sh — Install PitchDocs for any AI coding platform
# Usage: bash /path/to/pitchdocs/scripts/setup.sh [platform] [--project-dir /path]
#
# Platforms: codex, gemini, cursor, opencode, cline, windsurf, goose, aider
# If no platform is specified, auto-detects based on project directory contents.
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
PITCHDOCS_ROOT="$(cd "$SCRIPT_DIR/.." && pwd)"
DIST="$PITCHDOCS_ROOT/dist"
PROJECT_DIR="."

# ─────────────────────────────────────────────
# Argument parsing
# ─────────────────────────────────────────────
PLATFORM=""
while [ $# -gt 0 ]; do
    case "$1" in
        --project-dir)
            shift
            PROJECT_DIR="$1"
            ;;
        codex|gemini|cursor|opencode|cline|windsurf|goose|aider)
            PLATFORM="$1"
            ;;
        --help|-h)
            cat <<HELP
PitchDocs Setup — Install documentation skills for your AI coding tool

Usage: bash $(basename "$0") [platform] [--project-dir /path]

Platforms:
  codex      Codex CLI (OpenAI) — copies skills, agent, and prompts
  gemini     Gemini CLI (Google) — installs as Gemini extension
  cursor     Cursor — adds rules and agent
  opencode   OpenCode — verifies native compatibility
  cline      Cline — adds rules to .clinerules/
  windsurf   Windsurf — adds distilled rules (under 6,000 char limit)
  goose      Goose (Block) — adds .goosehints and recipes
  aider      Aider — adds .aider.conf.yml and CONVENTIONS.md

Options:
  --project-dir  Target project directory (default: current directory)
  --help         Show this help message

If no platform is specified, auto-detection is attempted.
HELP
            exit 0
            ;;
        *)
            echo "Unknown argument: $1 (use --help for usage)"
            exit 1
            ;;
    esac
    shift
done

PROJECT_DIR="$(cd "$PROJECT_DIR" && pwd)"

# ─────────────────────────────────────────────
# Auto-detection
# ─────────────────────────────────────────────
detect_platform() {
    # Check for tool-specific directories/files in the project
    [ -d "$PROJECT_DIR/.codex" ] && echo "codex" && return
    [ -d "$PROJECT_DIR/.gemini" ] && echo "gemini" && return
    [ -d "$PROJECT_DIR/.cursor" ] && echo "cursor" && return
    [ -f "$PROJECT_DIR/.clinerules" ] || [ -d "$PROJECT_DIR/.clinerules" ] && echo "cline" && return
    [ -f "$PROJECT_DIR/.windsurfrules" ] || [ -d "$PROJECT_DIR/.windsurf" ] && echo "windsurf" && return
    [ -f "$PROJECT_DIR/.goosehints" ] && echo "goose" && return
    [ -f "$PROJECT_DIR/.aider.conf.yml" ] && echo "aider" && return

    # Check for AGENTS.md (Codex/OpenCode) vs CLAUDE.md (Claude Code/OpenCode)
    [ -f "$PROJECT_DIR/AGENTS.md" ] && echo "codex" && return

    # Default: can't detect
    echo ""
}

if [ -z "$PLATFORM" ]; then
    PLATFORM=$(detect_platform)
    if [ -z "$PLATFORM" ]; then
        echo "Could not auto-detect platform."
        echo "Please specify: bash $(basename "$0") <platform>"
        echo "Run with --help for available platforms."
        exit 1
    fi
    echo "Auto-detected platform: $PLATFORM"
fi

# ─────────────────────────────────────────────
# Verify dist/ exists
# ─────────────────────────────────────────────
if [ ! -d "$DIST/$PLATFORM" ]; then
    echo "Distribution for '$PLATFORM' not found at $DIST/$PLATFORM"
    echo "Run 'bash scripts/build-dist.sh' from the PitchDocs repo first."
    exit 1
fi

# ─────────────────────────────────────────────
# Install
# ─────────────────────────────────────────────
log() { printf '  %s\n' "$1"; }

echo ""
echo "Installing PitchDocs for $PLATFORM"
echo "  Source: $DIST/$PLATFORM"
echo "  Target: $PROJECT_DIR"
echo ""

case "$PLATFORM" in
    codex)
        mkdir -p "$PROJECT_DIR/.agents/skills" "$PROJECT_DIR/.codex/agents"
        cp -r "$DIST/codex/.agents/skills/"* "$PROJECT_DIR/.agents/skills/"
        cp "$DIST/codex/.codex/agents/pitchdocs-writer.md" "$PROJECT_DIR/.codex/agents/"
        [ ! -f "$PROJECT_DIR/AGENTS.md" ] && cp "$DIST/codex/AGENTS.md" "$PROJECT_DIR/"
        log "Installed skills to .agents/skills/ (15 skills)"
        log "Installed pitchdocs-writer agent to .codex/agents/"
        log "Copied AGENTS.md (if not already present)"
        echo ""
        echo "Usage:"
        echo "  Ask Codex to use PitchDocs skills by name, e.g.:"
        echo "  > Generate a marketing-friendly README using the public-readme skill"
        echo ""
        echo "  Optional: copy command prompts for slash commands:"
        echo "  cp $DIST/codex/prompts/*.md ~/.codex/prompts/pitchdocs/"
        ;;

    gemini)
        # Gemini extensions go in ~/.gemini/extensions/
        ext_dir="${HOME}/.gemini/extensions/pitchdocs"
        mkdir -p "$ext_dir"
        cp -r "$DIST/gemini/"* "$ext_dir/"
        log "Installed Gemini extension to ~/.gemini/extensions/pitchdocs/"
        log "Skills, TOML commands, and manifest installed"
        echo ""
        echo "Usage:"
        echo "  Gemini CLI will load PitchDocs commands automatically."
        echo "  Try: /readme or /changelog in your Gemini CLI session."
        ;;

    cursor)
        mkdir -p "$PROJECT_DIR/.cursor/rules" "$PROJECT_DIR/.cursor/agents"
        cp "$DIST/cursor/.cursor/rules/"*.mdc "$PROJECT_DIR/.cursor/rules/"
        cp "$DIST/cursor/.cursor/agents/"*.md "$PROJECT_DIR/.cursor/agents/"
        log "Installed 2 rules to .cursor/rules/"
        log "Installed pitchdocs-writer agent to .cursor/agents/"
        echo ""
        echo "Usage:"
        echo "  Rules activate automatically when Cursor detects documentation tasks."
        echo "  Ask the pitchdocs-writer agent to generate docs."
        echo "  For skill details, reference PitchDocs SKILL.md files directly:"
        echo "  > Read $PITCHDOCS_ROOT/.claude/skills/public-readme/SKILL.md"
        ;;

    opencode)
        log "OpenCode reads .claude/skills/ natively — no installation needed!"
        log "Ensure PitchDocs is cloned or installed as a Claude Code plugin."
        echo ""
        echo "Verify: run OpenCode in a project with PitchDocs and check"
        echo "that skills are available by name."
        ;;

    cline)
        mkdir -p "$PROJECT_DIR/.clinerules"
        cp "$DIST/cline/.clinerules/"*.md "$PROJECT_DIR/.clinerules/"
        log "Installed 2 rules to .clinerules/"
        echo ""
        echo "Usage:"
        echo "  Rules are loaded automatically by Cline."
        echo "  Reference PitchDocs skills on demand:"
        echo "  > Read $PITCHDOCS_ROOT/.claude/skills/public-readme/SKILL.md"
        ;;

    windsurf)
        mkdir -p "$PROJECT_DIR/.windsurf/rules"
        cp "$DIST/windsurf/.windsurf/rules/pitchdocs.md" "$PROJECT_DIR/.windsurf/rules/"
        log "Installed distilled rule to .windsurf/rules/pitchdocs.md"
        echo ""
        echo "Usage:"
        echo "  Cascade loads the rule automatically."
        echo "  For detailed skill guidance, reference PitchDocs SKILL.md files:"
        echo "  > Read $PITCHDOCS_ROOT/.claude/skills/public-readme/SKILL.md"
        ;;

    goose)
        if [ -f "$PROJECT_DIR/.goosehints" ]; then
            echo ""
            echo "Existing .goosehints detected. Append PitchDocs standards? [y/N]"
            read -r answer
            if [ "$answer" = "y" ] || [ "$answer" = "Y" ]; then
                echo "" >> "$PROJECT_DIR/.goosehints"
                cat "$DIST/goose/.goosehints" >> "$PROJECT_DIR/.goosehints"
                log "Appended PitchDocs standards to .goosehints"
            fi
        else
            cp "$DIST/goose/.goosehints" "$PROJECT_DIR/.goosehints"
            log "Created .goosehints with PitchDocs standards"
        fi
        mkdir -p "$PROJECT_DIR/.goose/recipes"
        cp "$DIST/goose/recipes/"*.yaml "$PROJECT_DIR/.goose/recipes/" 2>/dev/null || true
        log "Installed 3 recipes to .goose/recipes/"
        echo ""
        echo "Usage:"
        echo "  Run recipes: goose run pitchdocs-readme"
        echo "  Update /path/to/pitchdocs in .goosehints and recipes"
        ;;

    aider)
        if [ -f "$PROJECT_DIR/.aider.conf.yml" ]; then
            echo "Existing .aider.conf.yml detected."
            echo "Add these lines to your read: section:"
            echo ""
            echo "read:"
            echo "  - $PITCHDOCS_ROOT/rules/doc-standards.md"
            echo "  # - $PITCHDOCS_ROOT/.claude/skills/public-readme/SKILL.md"
            echo "  # - $PITCHDOCS_ROOT/.claude/skills/feature-benefits/SKILL.md"
        else
            sed "s|/path/to/pitchdocs|$PITCHDOCS_ROOT|g" "$DIST/aider/.aider.conf.yml" > "$PROJECT_DIR/.aider.conf.yml"
            log "Created .aider.conf.yml with PitchDocs paths"
        fi
        echo ""
        echo "Usage:"
        echo "  Aider will load doc-standards automatically."
        echo "  For specific tasks: /read $PITCHDOCS_ROOT/.claude/skills/public-readme/SKILL.md"
        ;;
esac

echo ""
echo "Done! PitchDocs installed for $PLATFORM."
