---
title: "Use PitchDocs with Other AI Tools"
description: "Set up PitchDocs with Codex CLI, Cursor, Windsurf, Cline, Gemini CLI, Aider, and Goose."
type: how-to
difficulty: intermediate
last_verified: "2.2.0"
related:
  - guides/getting-started.md
  - guides/troubleshooting.md
order: 7
---

# Use PitchDocs with Other AI Tools

> **Summary**: PitchDocs skills are plain Markdown — here's how to use them with Codex CLI, Cursor, Windsurf, Cline, Gemini CLI, Aider, and Goose. Use the automated setup script or follow the manual steps below.

PitchDocs is built as a Claude Code plugin, but the documentation knowledge it contains — skills, agent workflows, quality standards — is stored as plain Markdown files with YAML frontmatter. That makes it portable to other AI coding tools with minimal effort.

## Quick Setup (Automated)

PitchDocs includes a setup script that installs the right files for your platform:

```bash
# Clone PitchDocs
git clone https://github.com/littlebearapps/pitchdocs.git /path/to/pitchdocs

# Install for your platform (from your project directory)
bash /path/to/pitchdocs/scripts/setup.sh codex    # Codex CLI
bash /path/to/pitchdocs/scripts/setup.sh gemini   # Gemini CLI
bash /path/to/pitchdocs/scripts/setup.sh cursor    # Cursor
bash /path/to/pitchdocs/scripts/setup.sh cline     # Cline
bash /path/to/pitchdocs/scripts/setup.sh windsurf  # Windsurf
bash /path/to/pitchdocs/scripts/setup.sh goose     # Goose
bash /path/to/pitchdocs/scripts/setup.sh aider     # Aider

# Auto-detect platform (checks for .cursor/, .gemini/, .codex/, etc.)
bash /path/to/pitchdocs/scripts/setup.sh
```

The setup script copies platform-specific distributions from `dist/`. These are pre-built packages containing skills, rules, agents, and commands translated into each platform's native format.

## Manual Setup

If you prefer to set things up manually, the universal pattern is:

1. **Clone the PitchDocs repo** (or download just the `.claude/` directory):

   ```bash
   git clone https://github.com/littlebearapps/pitchdocs.git /path/to/pitchdocs
   ```

2. **Point your AI tool at a skill file** when you need it:

   ```
   Read /path/to/pitchdocs/.claude/skills/public-readme/SKILL.md and use it to generate a README for this project
   ```

3. **Copy the quality standards** into your tool's context file (`.cursorrules`, `.windsurfrules`, `.clinerules`, `GEMINI.md`, `.goosehints`, etc.):

   ```bash
   cp /path/to/pitchdocs/rules/doc-standards.md <your-tool-context-file>
   ```

Every skill file is self-contained Markdown with YAML frontmatter. Your AI tool reads the file, follows the instructions, and produces documentation. The per-tool sections below show the optimal setup for each tool.

---

## What's Inside

The source of truth lives in `.claude/`. Here's what each piece does:

| Directory | Contents | Purpose | Cross-Tool? |
|-----------|----------|---------|-------------|
| `.claude/skills/*/SKILL.md` | 15 skill files | Reference knowledge for all doc types | Yes — Claude Code, OpenCode, Codex CLI |
| `.claude/agents/docs-writer.md` | 1 agent file | Orchestration workflow: codebase scanning → feature extraction → doc writing → validation | Partial — Claude Code, OpenCode (may vary) |
| `rules/doc-standards.md` | 1 rule file | Core quality standards: 4-question framework, progressive disclosure, benefit-driven language, badges. Extended references in `visual-standards`, `geo-optimisation` skills | Installed per-project in Claude Code (`/pitchdocs:activate`); copy manually for other tools |
| `.claude/rules/content-filter.md` | 1 rule file | Content filter quick reference: risk levels, fetch commands, chunked writing for high-risk OSS files | Auto-loaded in Claude Code; copy manually for other tools |
| `rules/docs-awareness.md` | 1 rule file | Documentation trigger map: suggests PitchDocs commands when documentation-relevant work is detected | Installed per-project in Claude Code (`/pitchdocs:activate`); not applicable for other tools |
| `agents/docs-freshness.md` | 1 agent file | Read-only freshness checker with command suggestions | Installed per-project in Claude Code (`/pitchdocs:activate`); not applicable for other tools |
| `commands/*.md` | 16 command files | Slash command definitions for all PitchDocs commands | Yes — Claude Code, OpenCode |
| `hooks/*.sh` | 1 hook script | Content filter write guard for high-risk OSS files | **Claude Code only** |

## Tool Compatibility Summary

Not all PitchDocs features work in every tool. Here's what's portable and what's Claude Code-specific:

| Feature | Claude Code | OpenCode | Codex CLI | Cursor / Windsurf / Cline / Gemini CLI |
|---------|------------|----------|-----------|----------------------------------------|
| Skills (16 SKILL.md files) | Native | Native (`.claude/skills/` fallback) | Copy to `.agents/skills/` | Reference on demand |
| Slash commands (16) | Native | Native (`.claude/commands/` fallback) | Copy to prompts | Not supported |
| Docs-writer agent | Native | Likely supported | Reference manually | Cursor: `.cursor/agents/` |
| Doc-standards rule | Per-project (`/pitchdocs:activate`) | Copy to context | Copy to context | Cursor: `.cursor/rules/`; others: copy to context file |
| Content-filter rule | Auto-loaded | Copy to context | Copy to context | Copy to tool-specific context file |
| Docs-awareness rule | Per-project (`/pitchdocs:activate`) | Not applicable | Not applicable | Not applicable |
| Docs-freshness agent | Per-project (`/pitchdocs:activate`) | Not supported | Not supported | Not supported |
| Content filter hook | Per-project (`/pitchdocs:activate install strict`) | Not supported | Not supported | Not supported |
| AGENTS.md | Loaded | Primary context file | Primary context file | Not used |
| CLAUDE.md | Loaded | Fallback (if no AGENTS.md) | Not used | Not used |

---

## OpenCode

[OpenCode](https://opencode.ai/) reads `.claude/skills/` natively — PitchDocs works out of the box with no extra setup.

**Install** the same way as Claude Code (clone or add as a plugin), then invoke skills by name in your OpenCode session. The 16 SKILL.md files, the docs-writer agent, and the doc-standards rule are all picked up automatically.

OpenCode also supports MCP servers, so if you have the GitHub MCP server configured, the docs-writer agent can access repository metadata, issues, and releases just as it does in Claude Code.

---

## Codex CLI

[Codex CLI](https://codex.openai.com/) (OpenAI) uses the same SKILL.md format as Claude Code but looks for skills at a different path: `.agents/skills/` instead of `.claude/skills/`. PitchDocs provides a pre-built Codex distribution with all skills, a portable agent, and command prompts.

**Automated setup:**

```bash
bash /path/to/pitchdocs/scripts/setup.sh codex
```

This installs 15 skills to `.agents/skills/`, a `pitchdocs-writer` agent to `.codex/agents/`, and copies AGENTS.md.

**Manual setup:**

```bash
# From your project root (not the PitchDocs repo)
PITCHDOCS="/path/to/pitchdocs"

# Copy all 15 skills
cp -r "$PITCHDOCS/.claude/skills/"* .agents/skills/

# Copy the quality standards as AGENTS.md (Codex reads this automatically)
cp "$PITCHDOCS/AGENTS.md" ./AGENTS.md

# Copy the portable docs-writer agent
mkdir -p .codex/agents
cp "$PITCHDOCS/agents/docs-writer-flat.md" .codex/agents/pitchdocs-writer.md
```

**Use the skills:**

Codex CLI loads SKILL.md files automatically when they're in `.agents/skills/`. Ask it to generate documentation and it will have access to the PitchDocs frameworks:

```
> Generate a marketing-friendly README for this project using the public-readme skill
> Extract features and benefits from this codebase using the feature-benefits skill
```

**(Optional) Add slash commands:**

Copy PitchDocs command files into your Codex prompts directory to get `/prompts:readme`, `/prompts:changelog`, etc.:

```bash
cp "$PITCHDOCS/commands/"*.md ~/.codex/prompts/pitchdocs/
```

---

## Cursor

[Cursor](https://cursor.com/) uses `.cursor/rules/*.mdc` files for contextual rules and `.cursor/agents/*.md` for subagents. It doesn't read SKILL.md files, but PitchDocs provides pre-built `.mdc` rules and a portable agent.

**Automated setup:**

```bash
bash /path/to/pitchdocs/scripts/setup.sh cursor
```

This installs 2 rules (`pitchdocs-standards.mdc`, `pitchdocs-filter.mdc`) and a `pitchdocs-writer` agent.

**Manual setup:**

Copy the pre-built files from `dist/cursor/`:

```bash
PITCHDOCS="/path/to/pitchdocs"
mkdir -p .cursor/rules .cursor/agents
cp "$PITCHDOCS/dist/cursor/.cursor/rules/"*.mdc .cursor/rules/
cp "$PITCHDOCS/dist/cursor/.cursor/agents/"*.md .cursor/agents/
```

The rules use **agent-selected** activation — Cursor includes them automatically when it detects documentation tasks.

**Reference skills on demand:**

Cursor doesn't have a skills directory, but you can reference PitchDocs skill files directly:

```
> Read the file at /path/to/pitchdocs/.claude/skills/public-readme/SKILL.md and use it to generate a README for this project
```

Or paste specific skill content into additional `.cursor/rules/*.mdc` files for the skills you use most often.

---

## Windsurf

[Windsurf](https://codeium.com/windsurf) (by Codeium) uses `.windsurf/rules/*.md` for project-level context. Windsurf has a 6,000 character per rule limit, so PitchDocs provides a distilled rule that fits within it.

**Automated setup:**

```bash
bash /path/to/pitchdocs/scripts/setup.sh windsurf
```

This installs a distilled `pitchdocs.md` rule to `.windsurf/rules/` containing the core standards (4-question framework, banned phrases, benefit-driven language, progressive disclosure).

**Manual setup:**

```bash
mkdir -p .windsurf/rules
cp /path/to/pitchdocs/dist/windsurf/.windsurf/rules/pitchdocs.md .windsurf/rules/
```

Or install [ContextDocs](https://github.com/littlebearapps/contextdocs) and use `/contextdocs:ai-context windsurf` to generate a tailored `.windsurfrules` from your codebase analysis.

**Reference skills on demand:**

Windsurf can read files from your workspace. Ask Cascade to load specific skill files:

```
> Read /path/to/pitchdocs/.claude/skills/public-readme/SKILL.md and use it to generate a README for this project
```

---

## Cline

[Cline](https://github.com/cline/cline) (VS Code extension) uses `.clinerules/` directory for project-level context. It has skill support, 8 hook types, and MCP integration.

**Automated setup:**

```bash
bash /path/to/pitchdocs/scripts/setup.sh cline
```

This installs documentation standards and content filter rules to `.clinerules/`.

**Manual setup:**

```bash
mkdir -p .clinerules
cp /path/to/pitchdocs/dist/cline/.clinerules/*.md .clinerules/
```

Or install [ContextDocs](https://github.com/littlebearapps/contextdocs) and use `/contextdocs:ai-context cline` to generate a tailored `.clinerules` from your codebase analysis.

**Reference skills on demand:**

Cline can read files from your workspace. Reference PitchDocs skill files directly in your Cline session:

```
Read /path/to/pitchdocs/.claude/skills/public-readme/SKILL.md and use it to generate a README for this project
```

---

## Gemini CLI

[Gemini CLI](https://github.com/google-gemini/gemini-cli) uses `GEMINI.md` for project context and supports a full extension framework with skills, TOML commands, and hooks. PitchDocs provides a pre-built Gemini extension with all 15 skills and 14 TOML command wrappers.

**Automated setup:**

```bash
bash /path/to/pitchdocs/scripts/setup.sh gemini
```

This installs a Gemini extension to `~/.gemini/extensions/pitchdocs/` with skills, TOML commands, and a manifest.

**Manual setup (context file only):**

```bash
mkdir -p .gemini
cp /path/to/pitchdocs/rules/doc-standards.md .gemini/GEMINI.md
```

Then ask Gemini to read specific skill files when needed:

```
> Read /path/to/pitchdocs/.claude/skills/public-readme/SKILL.md and use it to generate a README
```

**Manual setup (TOML commands):**

PitchDocs pre-generates all 14 TOML command files in `dist/gemini/commands/`. Copy them to get `/readme`, `/changelog`, `/features`, etc.:

```bash
mkdir -p .gemini/commands
cp /path/to/pitchdocs/dist/gemini/commands/*.toml .gemini/commands/
```

---

## Aider

[Aider](https://aider.chat/) doesn't have a plugin or skill system, but it can load reference files into its context via the `read` config option.

**Add to `.aider.conf.yml` in your project:**

```yaml
read:
  - /path/to/pitchdocs/rules/doc-standards.md
```

This loads the documentation quality standards into every Aider session. For specific tasks, load skill files directly in chat:

```
/read /path/to/pitchdocs/.claude/skills/public-readme/SKILL.md
Generate a README for this project following the skill instructions.
```

---

## Goose

[Goose](https://github.com/block/goose) (by Block) uses `.goosehints` for project context, YAML recipes for reusable workflows, and MCP servers for tool access.

**Automated setup:**

```bash
bash /path/to/pitchdocs/scripts/setup.sh goose
```

This creates a `.goosehints` file with PitchDocs standards and installs 3 recipes (readme, changelog, features) to `.goose/recipes/`.

**Manual setup:**

```bash
# Append the doc-standards rule to your project hints
cat /path/to/pitchdocs/rules/doc-standards.md >> .goosehints
```

For specific documentation tasks, reference skill files in your Goose session. If you have the GitHub MCP server configured, Goose can access repository metadata just as Claude Code does.

---

## Portable Agent

PitchDocs provides a portable docs-writer agent at `agents/docs-writer-flat.md` that combines the full research-write-review pipeline in a single agent. This is designed for platforms that don't support sub-agent spawning (Codex CLI, Cursor, Gemini CLI, Cline, Goose, Windsurf, Aider).

The portable agent includes:
- Codebase research workflow (platform detection, feature extraction, lobby split planning)
- Writing framework (4-question test, progressive disclosure, benefit-driven language)
- Quality review checklist (structure, content, GEO readiness, technical accuracy)
- Content filter mitigation strategies for high-risk OSS files

The setup script installs this agent automatically for platforms that support custom agents (Codex CLI, Cursor).

---

## Machine-Readable Manifest

PitchDocs includes a `pitchdocs.json` manifest at the repository root — a platform-neutral index of all skills, commands, agents, and rules with their file paths and descriptions. Build tools and scripts can parse this file to discover PitchDocs components programmatically.

---

## Discovering Available Skills

PitchDocs includes an `llms.txt` file at the repository root — an AI-readable index of all skills, commands, and documentation files. If your AI tool supports `llms.txt` (or can read files from disk), point it at this file to discover everything PitchDocs offers:

```
Read /path/to/pitchdocs/llms.txt to see all available PitchDocs skills and documentation
```

This is especially useful when you're not sure which skill to use — `llms.txt` maps each file to a short description so your AI tool can pick the right one.

---

## Platform Support Tiers

| Tier | Platforms | What Works |
|------|-----------|------------|
| **Native** | Claude Code, OpenCode | Skills, commands, agents, rules, hooks — full experience |
| **Supported** | Codex CLI, Gemini CLI, Cursor, Cline | Skills (native or via reference), commands (translated), portable agent, rules |
| **Basic** | Windsurf, Goose, Aider | Distilled rules, skill reference on demand, recipes (Goose) |

### Claude Code Only Features

These features depend on Claude Code-specific infrastructure:
- Sub-agent spawning in docs-writer (portable agent is the alternative)
- Per-project activation (`/pitchdocs:activate`)
- Content filter write guard hook
- Docs-awareness rule (suggests commands at documentation moments)
- Docs-freshness agent (session-start freshness checks)
