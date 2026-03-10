---
title: "Use PitchDocs with Other AI Tools"
description: "Set up PitchDocs with Codex CLI, Cursor, Windsurf, Cline, Gemini CLI, Aider, and Goose."
type: how-to
difficulty: intermediate
last_verified: "2.0.0"
related:
  - guides/getting-started.md
  - guides/troubleshooting.md
order: 7
---

# Use PitchDocs with Other AI Tools

> **Summary**: PitchDocs skills are plain Markdown — here's how to use them with Codex CLI, Cursor, Windsurf, Cline, Gemini CLI, Aider, and Goose.

PitchDocs is built as a Claude Code plugin, but the documentation knowledge it contains — skills, agent workflows, quality standards — is stored as plain Markdown files with YAML frontmatter. That makes it portable to other AI coding tools with minimal effort.

## Universal Pattern

Regardless of which AI tool you use, the workflow is the same:

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
   cp /path/to/pitchdocs/.claude/rules/doc-standards.md <your-tool-context-file>
   ```

Every skill file is self-contained Markdown with YAML frontmatter. Your AI tool reads the file, follows the instructions, and produces documentation. The per-tool sections below show the optimal setup for each tool.

---

## What's Inside

The source of truth lives in `.claude/`. Here's what each piece does:

| Directory | Contents | Purpose | Cross-Tool? |
|-----------|----------|---------|-------------|
| `.claude/skills/*/SKILL.md` | 16 skill files | Reference knowledge for all doc types | Yes — Claude Code, OpenCode, Codex CLI |
| `.claude/agents/docs-writer.md` | 1 agent file | Orchestration workflow: codebase scanning → feature extraction → doc writing → validation | Partial — Claude Code, OpenCode (may vary) |
| `.claude/rules/doc-standards.md` | 1 rule file | Core quality standards: 4-question framework, progressive disclosure, benefit-driven language, badges. Extended references in `visual-standards`, `geo-optimisation`, `skill-authoring` skills | Auto-loaded in Claude Code; copy manually for other tools |
| `.claude/rules/content-filter.md` | 1 rule file | Content filter quick reference: risk levels, fetch commands, chunked writing for high-risk OSS files | Auto-loaded in Claude Code; copy manually for other tools |
| `.claude/rules/docs-awareness.md` | 1 rule file | Documentation trigger map: suggests PitchDocs commands when documentation-relevant work is detected | Auto-loaded in Claude Code; copy manually for other tools |
| `commands/*.md` | 15 command files | Slash command definitions for all PitchDocs commands | Yes — Claude Code, OpenCode |
| `hooks/*.sh` | 1 hook script | Content filter write guard for high-risk OSS files | **Claude Code only** |

## Tool Compatibility Summary

Not all PitchDocs features work in every tool. Here's what's portable and what's Claude Code-specific:

| Feature | Claude Code | OpenCode | Codex CLI | Cursor / Windsurf / Cline / Gemini CLI |
|---------|------------|----------|-----------|----------------------------------------|
| Skills (16 SKILL.md files) | Native | Native (`.claude/skills/` fallback) | Copy to `.agents/skills/` | Reference on demand |
| Slash commands (15) | Native | Native (`.claude/commands/` fallback) | Copy to prompts | Not supported |
| Docs-writer agent | Native | Likely supported | Reference manually | Cursor: `.cursor/agents/` |
| Doc-standards rule | Auto-loaded | Copy to context | Copy to context | Cursor: `.cursor/rules/`; others: copy to context file |
| Content-filter rule | Auto-loaded | Copy to context | Copy to context | Copy to tool-specific context file |
| Docs-awareness rule | Auto-loaded | Not applicable | Not applicable | Not applicable |
| Content filter hook | Native (opt-in) | Not supported | Not supported | Not supported |
| AGENTS.md | Loaded | Primary context file | Primary context file | Not used |
| CLAUDE.md | Loaded | Fallback (if no AGENTS.md) | Not used | Not used |

---

## OpenCode

[OpenCode](https://opencode.ai/) reads `.claude/skills/` natively — PitchDocs works out of the box with no extra setup.

**Install** the same way as Claude Code (clone or add as a plugin), then invoke skills by name in your OpenCode session. The 16 SKILL.md files, the docs-writer agent, and the doc-standards rule are all picked up automatically.

OpenCode also supports MCP servers, so if you have the GitHub MCP server configured, the docs-writer agent can access repository metadata, issues, and releases just as it does in Claude Code.

---

## Codex CLI

[Codex CLI](https://codex.openai.com/) (OpenAI) uses the same SKILL.md format as Claude Code but looks for skills at a different path: `.agents/skills/` instead of `.claude/skills/`.

**Step 1 — Copy skills into your project:**

```bash
# From your project root (not the PitchDocs repo)
PITCHDOCS="/path/to/pitchdocs"

# Copy all 16 skills
cp -r "$PITCHDOCS/.claude/skills/"* .agents/skills/

# Copy the quality standards as AGENTS.md (Codex reads this automatically)
cp "$PITCHDOCS/AGENTS.md" ./AGENTS.md
```

**Step 2 — Use the skills:**

Codex CLI loads SKILL.md files automatically when they're in `.agents/skills/`. Ask it to generate documentation and it will have access to the PitchDocs frameworks:

```
> Generate a marketing-friendly README for this project using the public-readme skill
> Extract features and benefits from this codebase using the feature-benefits skill
```

**Step 3 (optional) — Add slash commands:**

Copy PitchDocs command files into your Codex prompts directory to get `/prompts:readme`, `/prompts:changelog`, etc.:

```bash
cp "$PITCHDOCS/commands/"*.md ~/.codex/prompts/pitchdocs/
```

---

## Cursor

[Cursor](https://cursor.com/) uses `.cursor/rules/*.mdc` files for contextual rules and `.cursor/agents/*.md` for subagents. It doesn't read SKILL.md files, but you can adapt PitchDocs content to Cursor's format.

**Step 1 — Add the documentation standards as a Cursor rule:**

Create `.cursor/rules/doc-standards.mdc` in your project:

```
---
description: PitchDocs documentation quality standards — 4-question framework, benefit-driven language, progressive disclosure, marketing-friendly structure
---

(Paste the contents of .claude/rules/doc-standards.md here, without its YAML frontmatter)
```

Because this rule has a `description` but no `globs` or `alwaysApply`, Cursor treats it as an **agent-selected rule** — it gets included automatically when the AI determines it's relevant to your request.

**Step 2 — Add the docs-writer agent:**

Create `.cursor/agents/docs-writer.md` in your project:

```
---
name: docs-writer
description: Generates high-quality public-facing repository documentation with marketing appeal
---

(Paste the contents of .claude/agents/docs-writer.md here, without its YAML frontmatter)
```

**Step 3 — Reference skills on demand:**

Cursor doesn't have a skills directory, but you can reference PitchDocs skill files directly. Clone the PitchDocs repo somewhere accessible, then ask Cursor:

```
> Read the file at /path/to/pitchdocs/.claude/skills/public-readme/SKILL.md and use it to generate a README for this project
```

Or paste specific skill content into additional `.cursor/rules/*.mdc` files for the skills you use most often.

---

## Windsurf

[Windsurf](https://codeium.com/windsurf) (by Codeium) uses `.windsurfrules` for project-level context. Its Cascade AI reads this file from the project root automatically.

**Step 1 — Add the documentation standards:**

Create `.windsurfrules` in your project root:

```bash
# Copy the doc-standards rule as Windsurf context
cp /path/to/pitchdocs/.claude/rules/doc-standards.md .windsurfrules
```

Or install [ContextDocs](https://github.com/littlebearapps/contextdocs) and use `/contextdocs:ai-context windsurf` to generate a tailored `.windsurfrules` from your codebase analysis.

**Step 2 — Reference skills on demand:**

Windsurf can read files from your workspace. Ask Cascade to load specific skill files:

```
> Read /path/to/pitchdocs/.claude/skills/public-readme/SKILL.md and use it to generate a README for this project
```

---

## Cline

[Cline](https://github.com/cline/cline) (VS Code extension) uses `.clinerules` for project-level context. It supports richer Markdown with task checklists.

**Step 1 — Add the documentation standards:**

Create `.clinerules` in your project root:

```bash
# Copy the doc-standards rule as Cline context
cp /path/to/pitchdocs/.claude/rules/doc-standards.md .clinerules
```

Or install [ContextDocs](https://github.com/littlebearapps/contextdocs) and use `/contextdocs:ai-context cline` to generate a tailored `.clinerules` from your codebase analysis.

**Step 2 — Reference skills on demand:**

Cline can read files from your workspace. Reference PitchDocs skill files directly in your Cline session:

```
Read /path/to/pitchdocs/.claude/skills/public-readme/SKILL.md and use it to generate a README for this project
```

---

## Gemini CLI

[Gemini CLI](https://github.com/google-gemini/gemini-cli) uses `GEMINI.md` for project context and `.gemini/commands/*.toml` for custom commands. It doesn't read SKILL.md files directly, but the knowledge transfers easily.

**Option A — Quick setup (context file):**

Copy the documentation standards into your project's Gemini context:

```bash
# Create .gemini/ directory
mkdir -p .gemini

# Use the doc-standards rule as your base context
cp /path/to/pitchdocs/.claude/rules/doc-standards.md .gemini/GEMINI.md
```

Then ask Gemini to read specific skill files when needed:

```
> Read /path/to/pitchdocs/.claude/skills/public-readme/SKILL.md and use it to generate a README
```

**Option B — Custom commands (TOML):**

For frequently used workflows, create TOML command files. For example, `.gemini/commands/readme.toml`:

```toml
description = "Generate a marketing-friendly README using PitchDocs standards"
prompt = """
Read the PitchDocs public-readme skill at /path/to/pitchdocs/.claude/skills/public-readme/SKILL.md
and the feature-benefits skill at /path/to/pitchdocs/.claude/skills/feature-benefits/SKILL.md.

Then analyse this codebase and generate a README.md following the skill instructions.
Use the 4-question framework, progressive disclosure, and benefit-driven language.
"""
```

This gives you a `/readme` command in Gemini CLI.

---

## Aider

[Aider](https://aider.chat/) doesn't have a plugin or skill system, but it can load reference files into its context via the `read` config option.

**Add to `.aider.conf.yml` in your project:**

```yaml
read:
  - /path/to/pitchdocs/.claude/rules/doc-standards.md
```

This loads the documentation quality standards into every Aider session. For specific tasks, load skill files directly in chat:

```
/read /path/to/pitchdocs/.claude/skills/public-readme/SKILL.md
Generate a README for this project following the skill instructions.
```

---

## Goose

[Goose](https://github.com/block/goose) (by Block) uses `.goosehints` for project context and MCP servers for tool access.

**Add PitchDocs context to `.goosehints`:**

```bash
# Append the doc-standards rule to your project hints
cat /path/to/pitchdocs/.claude/rules/doc-standards.md >> .goosehints
```

For specific documentation tasks, reference skill files in your Goose session. If you have the GitHub MCP server configured, Goose can access repository metadata just as Claude Code does.

---

## Discovering Available Skills

PitchDocs includes an `llms.txt` file at the repository root — an AI-readable index of all skills, commands, and documentation files. If your AI tool supports `llms.txt` (or can read files from disk), point it at this file to discover everything PitchDocs offers:

```
Read /path/to/pitchdocs/llms.txt to see all available PitchDocs skills and documentation
```

This is especially useful when you're not sure which skill to use — `llms.txt` maps each file to a short description so your AI tool can pick the right one.
