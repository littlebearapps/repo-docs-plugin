---
name: visual-standards
description: Visual formatting standards for repository documentation — emoji heading prefixes, horizontal rules, TOC anchors, callouts, screenshots (device dimensions, HTML patterns, captions, shadows), and image optimisation. Load when generating READMEs with visual elements or working with screenshots.
version: "1.0.0"
---

# Visual Standards

## Emoji Heading Prefixes

Use a single emoji before each H2 heading to create visual anchors when scrolling.

**Pattern:** `## {emoji} Section Title`

**Recommended emoji by section type:**

| Section Type | Emoji | Example |
|-------------|-------|---------|
| Quick start / Getting started | ⚡ | `## ⚡ Quick start` |
| Why / Value proposition | 💡 | `## 💡 Why ProjectName?` |
| Features | 🎯 | `## 🎯 Features` |
| Commands / API / Usage | 🤖 | `## 🤖 Commands` |
| Configuration | ⚙️ | `## ⚙️ Configuration` |
| Requirements / Prerequisites | 📦 | `## 📦 Requirements` |
| Documentation links | 📚 | `## 📚 Documentation` |
| Contributing | 🤝 | `## 🤝 Contributing` |
| Licence / License | 📄 | `## 📄 Licence` |
| Security | 🔒 | `## 🔒 Security` |
| Integrations / Plugins | 🔌 | `## 🔌 Integrations` |
| How it compares | ⚖️ | `## ⚖️ How it compares` |
| Roadmap | 🗺️ | `## 🗺️ Roadmap` |
| What it does / Use cases | 🚀 | `## 🚀 What ProjectName Does` |

**Rules:**
- One emoji per heading — never two
- Use the same emoji consistently for the same section type across projects
- Skip emoji prefixes for READMEs under 5 sections

## Horizontal Rules as Section Separators

Use `---` between major H2 sections to create visual breathing room (especially in 200+ line READMEs).

**When to use:** After hero/badge section, after TOC, between H2 sections, before licence/footer.
**When to skip:** Between H3 subsections, in short documents (under 150 lines), in non-README files.

## Table of Contents with Emoji Anchors

GitHub and GitLab strip the emoji character but retain the leading hyphen. Bitbucket prefixes all heading anchors with `markdown-header-` — load the `platform-profiles` skill when targeting Bitbucket.

```markdown
- [Quick start](#-quick-start)
- [Why ProjectName?](#-why-projectname)
- [Features](#-features)
- [Configuration](#%EF%B8%8F-configuration)
```

Include a TOC for READMEs with 7+ sections.

## Bold Inline Callouts

For brief warnings, tips, and notes, use bold inline callouts rather than GitHub-specific `[!NOTE]` syntax (which breaks on npm and PyPI).

```markdown
**Note:** This only applies when running in production mode.
**Tip:** Pass `--verbose` to see detailed output.
**Warning:** Never commit this file — it contains credentials.
```

Reserve GitHub callout syntax for GitHub-only documents (issue templates, PR templates).

## Screenshots & Device Images

For device-specific capture dimensions, HTML display patterns, retina handling, annotation conventions, captions, shadows/borders, browser chrome, file naming, and optimisation guidance, load `SKILL-reference.md` from this skill directory.
