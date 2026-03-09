---
name: visual-standards
description: Visual formatting standards for repository documentation — emoji heading prefixes, horizontal rules, TOC anchors, callouts, screenshots (device dimensions, HTML patterns, captions, shadows), and image optimisation. Load when generating READMEs with visual elements or working with screenshots.
version: "1.0.0"
---

# Visual Standards

## Emoji Heading Prefixes

Use a single emoji before each H2 heading to create visual anchors when scrolling. This helps readers scan a long document and locate sections quickly.

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
| Acknowledgements | 🙏 | `## 🙏 Acknowledgements` |
| Security | 🔒 | `## 🔒 Security` |
| Integrations / Plugins | 🔌 | `## 🔌 Integrations` |
| How it compares | ⚖️ | `## ⚖️ How it compares` |
| Roadmap | 🗺️ | `## 🗺️ Roadmap` |
| What it does / Use cases | 🚀 | `## 🚀 What ProjectName Does` |
| Cross-platform / Other tools | 🔀 | `## 🔀 Use with Other Tools` |

**Rules:**
- One emoji per heading — never two
- Use the same emoji consistently for the same section type across projects
- H3 sub-features within a Features section may also use emoji prefixes for visual grouping (`### 📡 Progress streaming`)
- Inline bullet emoji is the recommended format for feature lists (`- 🎙️ **Voice notes** — description`)
- Choose emoji that relate to the section content — decorative randomness hurts more than it helps
- Skip emoji prefixes for READMEs under 5 sections — the visual overhead outweighs the navigation benefit

## Horizontal Rules as Section Separators

Use `---` between major H2 sections to create visual breathing room. This is especially effective in long READMEs (200+ lines).

**When to use:**
- After the hero/badge section (before the first content section)
- After the table of contents
- Between each top-level H2 section
- Before the licence/footer

**When to skip:**
- Between H3 subsections within a single H2 section
- In short documents (under 150 lines) where they add more noise than clarity
- In files other than README.md (CONTRIBUTING, SECURITY, etc. are typically shorter)

## Table of Contents with Emoji Anchors

When a README uses emoji heading prefixes and has a table of contents, the anchor links must account for the emoji. GitHub and GitLab strip the emoji character but retain the leading hyphen. Bitbucket prefixes all heading anchors with `markdown-header-` (e.g. `#markdown-header--quick-start`) — load the `platform-profiles` skill when targeting Bitbucket.

**Pattern:**
```markdown
## Table of contents

- [Quick start](#-quick-start)
- [Why ProjectName?](#-why-projectname)
- [Features](#-features)
- [Configuration](#%EF%B8%8F-configuration)
```

Include a TOC for READMEs with 7+ sections. Below 7 sections, the hero quick-links row (`[Docs](link) · [Examples](link) · [Discord](link)`) is sufficient.

## Bold Inline Callouts

For brief warnings, tips, and notes within a section, use bold inline callouts rather than GitHub-specific `[!NOTE]` syntax (which breaks on npm and PyPI).

**Pattern:**
```markdown
**Note:** This only applies when running in production mode.

**Tip:** Pass `--verbose` to see detailed output.

**Warning:** Never commit this file — it contains credentials.
```

Reserve GitHub callout syntax (`> [!NOTE]`, `> [!WARNING]`) for GitHub-only documents (issue templates, PR templates) where cross-renderer compatibility is not a concern.

## Screenshots & Device Images

Guidelines for including screenshots and device-specific captures in documentation. These complement the general image rules in the `pitchdocs-suite` skill (format, storage, alt text).

### Capture Dimensions & Display Sizes

Capture at native resolution (or 2× for retina) but always set an explicit display `width` in HTML so the image renders at a consistent, readable size across screens.

| Device | Capture Size (logical px) | Display HTML | Notes |
|--------|--------------------------|-------------|-------|
| Desktop / laptop | 1280×800 | `width="700"` | Standard width; use `width="800"` for full-width hero screenshots |
| Mobile (iPhone) | 390×844 | `width="280"` | Centre-align; narrow images look odd left-aligned |
| Tablet (iPad) | 820×1180 | `width="400"` | Portrait orientation default |
| Terminal / CLI | 80 columns wide | `width="700"` | Use `asciinema`, `vhs`, or `terminalizer` for recordings |

### HTML Patterns

**Desktop screenshot (standard):**
```html
<p align="center">
  <img src="docs/images/dashboard-desktop.png" width="700" alt="Dashboard showing project metrics and recent activity" />
</p>
```

**Mobile screenshot (centred, narrow):**
```html
<p align="center">
  <img src="docs/images/dashboard-mobile.png" width="280" alt="Dashboard mobile view with collapsed navigation" />
</p>
```

**Side-by-side desktop + mobile (responsive comparison):**
```html
<p align="center">
  <img src="docs/images/dashboard-desktop.png" width="480" alt="Dashboard desktop view" />
  &nbsp;&nbsp;&nbsp;&nbsp;
  <img src="docs/images/dashboard-mobile.png" width="200" alt="Dashboard mobile view" />
</p>
```

**Terminal recording (GIF or SVG):**
```html
<p align="center">
  <img src="docs/images/demo-quick-start.gif" width="700" alt="Terminal recording: installing and running first command in 30 seconds" />
</p>
```

### Retina / HiDPI Handling

- **Capture at 2× resolution** (e.g., 2560×1600 for a desktop screenshot) to ensure crisp rendering on retina displays
- **Always set an explicit `width`** in the HTML — without it, the 2× image displays at double size
- Do not use `srcset` in GitHub Markdown — it is not supported. The explicit `width` attribute handles scaling.

### Annotation Conventions

When annotating screenshots with callouts, arrows, or highlights:

- **Colour**: red (#E34234) for callout arrows and highlight boxes — high contrast on most UI backgrounds
- **Stroke**: 2px for arrows and boxes; 3px for emphasis
- **Style**: rounded rectangles for area highlights; straight arrows with solid heads for pointing
- **Text labels**: white text on red background pill, 14px minimum — must be legible at the display `width`
- **Tool recommendations**: Cleanshot X (macOS), Flameshot (Linux), or ShareX (Windows) all support annotation presets

### Captions

Add a caption beneath a screenshot when the image needs context that alt text alone can't convey — workflow diagrams, multi-part screenshots, or before/after comparisons. Captions are optional for straightforward UI screenshots.

**Cross-renderer pattern** (works on GitHub, npm, and PyPI):
```html
<p align="center">
  <img src="docs/images/dashboard-desktop.png" width="700" alt="Dashboard showing project metrics" />
</p>
<p align="center"><em>Figure 1: Dashboard overview showing project health metrics and recent activity</em></p>
```

**GitHub-preferred pattern** (semantic HTML — stripped on npm/PyPI):
```html
<figure align="center">
  <img src="docs/images/dashboard-desktop.png" width="700" alt="Dashboard showing project metrics" />
  <figcaption><em>Figure 1: Dashboard overview showing project health metrics and recent activity</em></figcaption>
</figure>
```

**Rules:**
- Use the cross-renderer `<p>` + `<em>` pattern for README and any file published to registries
- Use `<figure>`/`<figcaption>` for GitHub-only docs (guides, tutorials, explanation pages)
- Caption format: `Figure N: description` — keep descriptions under one sentence
- Italic formatting (`<em>`) visually distinguishes captions from body text
- Don't caption every screenshot — only when the image needs explanation beyond its alt text

### Shadows & Borders

GitHub strips all CSS `style` attributes, so `box-shadow` and `border` do **not** render in GitHub Markdown (or npm/PyPI). Shadows and borders must be baked into the image at capture time.

**Baked shadow (recommended for hero/marketing screenshots):**
- Capture tools with built-in shadow presets: Cleanshot X (macOS), Flameshot (Linux), ShareX (Windows)
- Shadow style: soft drop shadow, 10–20px blur, 40–60% opacity black, 0px horizontal / 4–8px vertical offset
- Export with a white or transparent background behind the shadow — GitHub renders on white, so white is safest
- Use shadows for hero/marketing screenshots in README where polish matters; skip for in-guide screenshots where content clarity takes priority

**Baked border (for flat screenshots that bleed into the page):**
- When a screenshot has a white or light background, add a 1px #E0E0E0 border at capture/export time to separate it from the page
- Terminal screenshots and dark-themed UI don't need borders — their inherent dark background provides contrast

**Anti-patterns:**
- Don't use inline `style="box-shadow:..."` — stripped on all renderers
- Don't use `<div>` wrapper styling — stripped on GitHub
- Don't add shadows to terminal recordings (GIF/SVG) — dark backgrounds provide natural contrast

### Browser Chrome

- **Exclude** browser chrome (address bar, tabs) for focused UI screenshots — readers care about the app, not the browser
- **Include** browser chrome when demonstrating URL patterns, browser extensions, or full-page context
- **Include** browser chrome for marketing hero screenshots where the browser frame adds perceived realism

### File Naming

Pattern: `{feature}-{device}-{variant}.{ext}`

Examples:
- `dashboard-desktop.png` — desktop screenshot of the dashboard
- `dashboard-mobile-dark.png` — mobile screenshot with dark mode
- `setup-terminal.gif` — terminal recording of setup process
- `login-tablet-annotated.png` — annotated tablet screenshot of login

### Optimisation

- Run PNG screenshots through `optipng` or `pngquant` before committing
- Keep GIFs under 5MB (10MB GitHub limit, but large GIFs load slowly); prefer `vhs` SVG recordings for terminal demos
- Target under 300KB per image where possible
