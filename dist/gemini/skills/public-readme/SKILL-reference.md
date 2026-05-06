# Public README — Extended Reference

Detailed examples, templates, and tables split from SKILL.md to reduce token overhead. Load on demand when generating READMEs for complex projects.

## Time to Hello World (TTHW) Targets

Target TTHW for quick start sections by project type. State explicitly where evidence supports it.

| Project Type | TTHW Target | Quick Start Style |
|-------------|-------------|-------------------|
| library | 30 seconds | `npm install` + import + one function call |
| cli | 60 seconds | Install + one command with output |
| web-app | 2 minutes | Clone + install + `npm start` |
| api | 60 seconds | `curl` example with response body |
| plugin | 60 seconds | Plugin install command + verify |
| docs-site | 2 minutes | Clone + serve locally |
| monorepo | 3 minutes | Root install + key package usage |

## Hero Section Templates

**Project logo guidelines:**
- **Format**: SVG preferred (scales crisply on retina displays). PNG as fallback for complex raster logos.
- **Height**: `height="160"` to `height="240"` — scale to visual weight, not pixel count. Larger source images (1000x1000) use the lower end; smaller sources (300–500px) use the higher end. Never set both `width` and `height` unless the source aspect ratio requires it.
- **Background**: Transparent for README headers. Solid colour backgrounds are only for listing thumbnails (DevHunt, Product Hunt).
- **Breathing room**: Use separate `<p align="center">` blocks for the logo, tagline, badges, and links. Each `<p>` gets natural CSS margin from GitHub's stylesheet (~16px), creating consistent spacing without `<br>` hacks. Avoid `<br>` inside `<div>` blocks — GitHub's renderer collapses them unpredictably.
- **Dark mode support**: Use `<picture>` with `prefers-color-scheme` sources when the logo doesn't render well on both light and dark backgrounds:
  ```html
  <picture>
    <source media="(prefers-color-scheme: dark)" srcset="docs/assets/logo-dark.svg">
    <source media="(prefers-color-scheme: light)" srcset="docs/assets/logo-light.svg">
    <img src="docs/assets/logo-light.svg" height="200" alt="Project Name">
  </picture>
  ```
- **Wordmark logos**: If the logo contains the project name (a wordmark), omit the `# Project Name` heading to avoid duplication.
- **Storage**: `docs/assets/` or `.github/assets/` in the repo. For npm/PyPI-published packages, use absolute URLs — relative paths break on registry pages. URL pattern by platform: GitHub `https://raw.githubusercontent.com/org/repo/main/path`, GitLab `https://gitlab.com/org/repo/-/raw/main/path`, Bitbucket `https://bitbucket.org/org/repo/raw/main/path`. Load the `platform-profiles` skill for the full mapping.
- **Bitbucket limitations**: `<picture>` tags are not supported — use a single high-contrast image. Load `platform-profiles` for the full rendering compatibility matrix.
- **Alt text**: Always include descriptive alt text (the project name at minimum).

**Registry-specific badge guidance:**

For npm-published packages, include after CI/coverage badges:
```markdown
[![npm](https://img.shields.io/npm/v/PACKAGE-NAME)](https://www.npmjs.com/package/PACKAGE-NAME)
[![npm downloads](https://img.shields.io/npm/dm/PACKAGE-NAME)](https://www.npmjs.com/package/PACKAGE-NAME)
[![types](https://img.shields.io/npm/types/PACKAGE-NAME)](https://www.npmjs.com/package/PACKAGE-NAME)
```

For PyPI-published packages:
```markdown
[![PyPI](https://img.shields.io/pypi/v/PACKAGE-NAME)](https://pypi.org/project/PACKAGE-NAME/)
[![Python versions](https://img.shields.io/pypi/pyversions/PACKAGE-NAME)](https://pypi.org/project/PACKAGE-NAME/)
[![PyPI downloads](https://img.shields.io/pypi/dm/PACKAGE-NAME)](https://pypi.org/project/PACKAGE-NAME/)
```

Load the `package-registry` skill for the full badge inventory and cross-renderer compatibility guidance.

## Value Proposition — Extended Formats

**Credibility row pattern** (for security/compliance/enterprise appeal). Place inside the "Why" section — they serve the decision-maker track alongside the developer-facing problem/solution rows:

```markdown
| Trust signal | What it demonstrates | Where to verify |
|-------------|---------------------|----------------|
| SECURITY.md present | Transparent vulnerability process | [Security Policy](SECURITY.md) |
| Test coverage N% | Code quality and reliability | `npm test -- --coverage` |
```

**Placement guidance:** For most projects, credibility rows belong inside the "Why" section as a subheading ("### For decision makers") or a second table. Only create a standalone "Security & Trust" section after Features if the project has 4+ security signals (auth, encryption, compliance, dependency scanning) — otherwise the thin section hurts more than it helps.

**Alternative format: Bold-outcome bullets** (recommended for workflow/lifestyle tools with 3+ user benefits):

```markdown
## Why [Project]?

[One sentence framing the problem or status quo.]

- **[Outcome 1]** — mechanism description. Constraint if needed.
- **[Outcome 2]** — mechanism description.
- **[Outcome 3]** — mechanism description.
```

This format works best when user benefits come from the developer's lived experience. Use the conversational path in the `feature-benefits` skill (Step 4, Path B) to capture authentic use cases.

**Choosing a format:** If the `feature-benefits` skill produced 3+ user benefits, recommend bold-outcome bullets. For purely technical projects or when fewer user benefits emerged, recommend the problem/solution table or bullets. Present both options to the developer and let them decide.

## Use-Case Framing (Section 3.5)

For projects with multiple capabilities, add a "What [Project] Does" section between the hero and the detailed features. Frame each capability as a **reader-centric scenario** — start with the user's situation, then explain how the project helps.

```markdown
## 🚀 What ProjectName Does

### [Use case A — short title]

You've finished your MVP. The repo is about to go public. You need [thing the user needs]...

ProjectName [does X], [does Y], and [does Z]. Run `command` and get [outcome].

### [Use case B — short title]

Beyond [thing A], a professional project needs [thing B, C, D]...

Run `command` to [do everything], or use `individual-command` for just what you need.

### [Use case C — short title]

Great [thing] is useless if nobody finds it. ProjectName handles [discovery]:

- **Feature A** — benefit
- **Feature B** — benefit
```

**Rules:**
- 2–3 use cases maximum — keep each under 3 sentences plus a concrete action
- Each scenario opens with reader context ("You've finished...", "Beyond X, you need...")
- Each scenario ends with a concrete action (a command, a link, a next step)
- Use H3 subheadings within the section for each scenario
- Skip this section for single-purpose tools — the "Why" section is sufficient

## Visual Element Guidance

- Screenshot, demo GIF, or terminal recording
- Architecture diagram for infrastructure projects
- Before/after comparison for tools
- Keep under 800px wide, optimised for GitHub's renderer

```markdown
<p align="center">
  <img src="docs/images/demo.gif" alt="Quick start demo showing project setup in 30 seconds" width="700" />
</p>
```

**For device-specific screenshots, captions, and shadow/border styling**, load the `visual-standards` skill.

**Where to store visual assets:**
- **In-repo** (`docs/images/` or `assets/`): version-controlled, always accessible. Best for files under 5MB.
- **GitHub user-content**: drag-drop an image into any GitHub issue or PR to get a permanent `user-images.githubusercontent.com` URL. Keeps repo size small.
- **GitHub Release assets**: for larger files (>5MB) without bloating git history.

**Format guidance:**
- SVG for diagrams and architecture charts (scales perfectly)
- PNG for screenshots and UI captures (lossless)
- GIF for demo recordings (<10MB GitHub limit, aim for ~10fps)
- Always include descriptive alt text for accessibility

## Cross-Renderer Compatibility

If published to npm or PyPI, load the `package-registry` skill for the full compatibility matrix. Key rules: use absolute image URLs, avoid GitHub callouts (`[!NOTE]`), avoid heading anchors on PyPI, test with `twine check dist/*` before PyPI upload.
