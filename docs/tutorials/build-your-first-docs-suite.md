---
title: "Build Your First Documentation Suite"
description: "Learn PitchDocs by building a complete documentation suite from scratch — from README to user guides using a real example project."
type: tutorial
difficulty: beginner
time_to_complete: "20 minutes"
last_verified: "2.0.0"
related:
  - guides/getting-started.md
  - guides/workflows.md
  - guides/command-reference.md
order: 1
---

# Build Your First Documentation Suite

> **What You'll Learn**: In this tutorial, you'll build a complete documentation suite for a sample project — generating a README, changelog, roadmap, user guides, and verification reports. By the end, you'll understand PitchDocs workflows end-to-end and be ready to use it on your own projects.

**Time to completion:** ~20 minutes. No prior knowledge of PitchDocs required.

---

## Before You Start

### Prerequisites

- [Claude Code](https://code.claude.com/) or [OpenCode](https://opencode.ai/) installed
- A project repository with at least a `README.md` and some structure (or use our sample below)
- Terminal access

### What You'll Build

By the end of this tutorial, your project will have:
- ✅ A marketing-friendly README with hero section, features, and quick start
- ✅ A changelog documenting changes from your git history
- ✅ A roadmap showing future direction
- ✅ User guides explaining how to use key features
- ✅ A docs hub page linking everything together
- ✅ A quality score showing where your documentation stands

---

## Step 1: Set Up PitchDocs

First, install PitchDocs as a plugin.

Open Claude Code and run:

```bash
/plugin marketplace add littlebearapps/lba-plugins
/plugin install pitchdocs@lba-plugins
```

You should see confirmation that the plugin and all skills are loaded.

**Verify it worked:** Start a new session and you should see PitchDocs skills available in autocomplete.

<details>
<summary><strong>Troubleshooting: Plugin not loading</strong></summary>

If you don't see PitchDocs skills:

```bash
# List installed plugins
/plugin list

# If pitchdocs is missing, reinstall
/plugin uninstall pitchdocs
/plugin install pitchdocs@lba-plugins
```

If you're using OpenCode, the install command is identical.

</details>

---

## Step 2: Create or Navigate to a Sample Project

For this tutorial, we'll work with a sample project. Choose one:

**Option A: Use an existing project**
```bash
cd /path/to/your/project
```

**Option B: Create a minimal sample project**
```bash
mkdir pitchdocs-tutorial
cd pitchdocs-tutorial
git init

# Create a basic project structure
cat > package.json << 'EOF'
{
  "name": "data-transform-lib",
  "version": "1.0.0",
  "description": "Fast JSON and CSV transformation library",
  "main": "src/index.js",
  "scripts": {
    "test": "jest",
    "build": "tsc",
    "dev": "nodemon src/index.js"
  },
  "keywords": ["json", "csv", "transform"],
  "author": "Your Name",
  "license": "MIT"
}
EOF

mkdir -p src docs
cat > src/index.js << 'EOF'
// Core transformation functions
export function transformJSON(data, rules) {
  // Applies rules to transform JSON data
  return processRules(data, rules);
}

export function transformCSV(csvString, options) {
  // Converts CSV to JSON or vice versa
  return convertCSV(csvString, options);
}

export function createRule(selector, transformer) {
  // Allows custom transformation rules
  return { selector, transformer };
}
EOF

cat > README.md << 'EOF'
# Data Transform Library

A JavaScript library for transforming JSON and CSV data.

## Installation

npm install data-transform-lib

## Usage

See documentation.
EOF

git add -A
git commit -m "feat: initial commit with core transformation functions"
```

**Expected output:** A new git repository with a basic project structure.

If you already have a project, skip to the next step.

---

## Step 3: Extract Features and Understand Your Project

Now, let PitchDocs scan your project and identify what's worth documenting.

```bash
/pitchdocs:features
```

PitchDocs will scan across 10 signal categories: CLI commands, public API, configuration, integrations, performance, security, TypeScript/DX, testing, extensibility, and documentation.

**What to look for in the output:**
- **Evidence** — each feature links to a file path (e.g., `src/index.js` line 5)
- **Signal categories** — which parts of your code are "interesting" enough to document
- **Tier classification** — Hero (standout), Core (essential), Supporting (nice-to-have)

<details>
<summary><strong>Example: If the scan found your features...</strong></summary>

You might see something like:

```
🎯 Hero Features (1–3 standout capabilities)
  - Fast JSON transformation with automatic type detection (src/index.js:8)

📋 Core Features (4–8 essential capabilities)
  - CSV-to-JSON converter (src/index.js:15)
  - Custom transformation rules API (src/index.js:22)
  - Streaming support for large files (src/transform.js:45)

🔧 Supporting Features
  - Error handling with detailed messages
  - Optional type validation
```

These become the basis for your README features section.

</details>

**Next step:** If the features look accurate, continue to Step 4. If you want to refine them, run:

```bash
/pitchdocs:features benefits
```

This lets you "talk it out" — answer 4 questions to help PitchDocs understand your project's value from a user's perspective.

---

## Step 4: Generate Your First README

With features extracted, generate a professional README:

```bash
/pitchdocs:readme
```

PitchDocs will create (or improve) a `README.md` with:
- **Hero section** — your project's logo, description, and badges
- **Quick start** — install and first code example (30-60 seconds to working code)
- **Features table** — Hero + Core features in benefit-driven language
- **Comparison** — how you compare to alternatives
- **Contribution and support links** — next steps for visitors

**Verify it worked:**
```bash
head -n 50 README.md
```

You should see a well-formatted hero section with your project name, description, and badges.

<details>
<summary><strong>If the README needs refinement</strong></summary>

PitchDocs accepts natural language guidance:

```bash
# Focus on a specific section
/pitchdocs:readme focus on the comparison table

# Regenerate with a different tone
/pitchdocs:readme for a more technical audience

# Emphasize a particular feature
/pitchdocs:readme highlight the CSV transformation feature
```

Each run refines the output — you're not overwriting; you're improving.

</details>

---

## Step 5: Audit What Else Your Project Needs

Your README is done, but there are usually 15+ other documentation files worth creating. Let PitchDocs scan your project against a comprehensive checklist:

```bash
/pitchdocs:docs-audit
```

This produces a **3-tier checklist**:
- **Tier 1 (Critical)** — README, LICENSE, CONTRIBUTING
- **Tier 2 (Essential)** — CHANGELOG, SECURITY, ROADMAP
- **Tier 3 (Nice-to-have)** — user guides, issue templates, PR templates

**What to look for:** The output will show which files exist ✅ and which are missing ❌.

---

## Step 6: Generate Missing Documentation (All at Once)

Instead of creating each file manually, generate everything that's missing:

```bash
/pitchdocs:docs-audit fix
```

This command:
1. Checks which docs are missing
2. Generates them automatically
3. Handles Claude Code's content filter (so `CODE_OF_CONDUCT` and `LICENSE` don't fail)
4. Creates a `docs/` folder with guides and supporting documentation

**Expected output:** Your repo now has:
- ✅ `CHANGELOG.md` — from your git history
- ✅ `ROADMAP.md` — future direction
- ✅ `CONTRIBUTING.md` — how to contribute
- ✅ `CODE_OF_CONDUCT.md` — community standards
- ✅ `SECURITY.md` — security policy
- ✅ `docs/guides/` — user guides for key workflows
- ✅ `docs/README.md` — documentation hub

**Verify the docs were created:**
```bash
ls -la docs/guides/
cat docs/README.md | head -n 20
```

---

## Step 7: Generate User Guides

The `docs/guides/` folder created in Step 6 contains auto-generated task-oriented guides. If you want to create guides for additional workflows, you can generate them explicitly:

```bash
/pitchdocs:user-guide
```

This scans your project and generates guides based on common questions and features:
- **Getting Started** — installation and first steps
- **Configuration** — all config options explained
- **[Feature-specific guides]** — one per major feature
- **Troubleshooting** — common issues and solutions

**Verify the guides:**
```bash
ls docs/guides/
head -n 30 docs/guides/getting-started.md
```

Each guide follows a numbered-steps format with verification steps so users know they've succeeded.

---

## Step 8: Create a CHANGELOG from Your Git History

PitchDocs extracts your commit messages and converts them into user-friendly change notes:

```bash
/pitchdocs:changelog
```

This scans your git history and creates a `CHANGELOG.md` where:
- ✅ Features say "You can now..."
- ✅ Bug fixes say "Fixed..."
- ✅ Breaking changes are flagged clearly
- ✅ Each entry is user-benefit-driven, not developer-jargon

**Verify it:**
```bash
head -n 50 CHANGELOG.md
```

---

## Step 9: Verify Quality and Check for Issues

Before you ship your docs, run a comprehensive verification:

```bash
/pitchdocs:docs-verify
```

This checks:
- ✅ All links are valid (internal and external)
- ✅ No stale content (files updated recently)
- ✅ Heading hierarchy is correct (no level skipping)
- ✅ All referenced files exist
- ✅ Security issues (no leaked credentials or internal paths)
- ✅ Quality score (0–100 across 6 dimensions)

**What a good score looks like:**
- 80–100 — Excellent documentation
- 60–79 — Good, with minor gaps
- 40–59 — Needs attention, missing sections
- Below 40 — Significant gaps or errors

<details>
<summary><strong>If your score is low</strong></summary>

The verification output suggests specific improvements. Common issues:

- **Broken links** — Fix with `Edit` tool or re-run the command that generated them
- **Stale content** — Update files that haven't changed in 90+ days
- **Missing prerequisites** — Add setup/install instructions to user guides
- **Poor heading hierarchy** — Ensure H1 → H2 → H3, no skipping levels

After fixing, run `/pitchdocs:docs-verify` again to confirm improvements.

</details>

---

## Step 10: Set Up AI Context Files (Optional)

Your documentation is complete! If you want to manage AI context files (AGENTS.md, CLAUDE.md, .cursorrules), install [ContextDocs](https://github.com/littlebearapps/contextdocs) separately:

```bash
/plugin install contextdocs@lba-plugins
/contextdocs:ai-context init
```

This bootstraps your AI context files with best practices for your project type.

---

## What You've Built

Congratulations! Your project now has:

1. **README.md** — Marketing-friendly, with features and quick start
2. **CHANGELOG.md** — User-benefit-driven change notes
3. **ROADMAP.md** — Future direction and priorities
4. **docs/guides/** — Task-oriented user guides
5. **docs/README.md** — Documentation hub
6. **CONTRIBUTING.md** — How to contribute
7. **CODE_OF_CONDUCT.md** — Community standards
8. **SECURITY.md** — Security policy
9. **Quality score** — Confidence that your docs are complete

All generated with **evidence from your actual code** — nothing is fabricated. Every claim traces back to a file path.

---

## Next Steps

Now that you've built a complete documentation suite, here are your options:

### Keep Docs Fresh

When you add new features or prepare a release:

```bash
/pitchdocs:doc-refresh
```

This updates README features, CHANGELOG, user guides, and quality scores in one command.

### Customize Output

Steer PitchDocs to match your project's voice:

```bash
/pitchdocs:readme focus on the security features
/pitchdocs:changelog for a non-technical audience
/pitchdocs:user-guide for DevOps engineers
```

### Launch Your Project

When you're ready to go public, generate platform-specific content:

```bash
/pitchdocs:launch
```

This creates Dev.to articles, Hacker News posts, Reddit posts, and Twitter threads — all from your new documentation.

### Explore Advanced Features

Learn more about what PitchDocs can do:

- [Command Reference](../guides/command-reference.md) — All 15 commands with arguments and examples
- [Workflows](../guides/workflows.md) — Recipes for releases, launches, and maintenance
- [Customising Output](../guides/customising-output.md) — How to steer documentation toward your vision
- [How PitchDocs Thinks](../guides/concepts.md) — Design frameworks and philosophies

---

## Summary

You've learned:
- ✅ How to install and use PitchDocs
- ✅ How to extract features with evidence
- ✅ How to generate professional README, CHANGELOG, and guides
- ✅ How to audit and fill documentation gaps
- ✅ How to verify documentation quality
- ✅ How to keep docs fresh with each release

**You're ready to use PitchDocs on any project.** Start with `/pitchdocs:readme` for your next project and build from there.

**Questions?** See the [Getting Started Guide](../guides/getting-started.md) for common patterns, or [Troubleshooting](../guides/troubleshooting.md) for specific issues.
