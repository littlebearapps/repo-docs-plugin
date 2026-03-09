# Visual Standards — Extended Reference

Detailed screenshot specs, HTML patterns, annotation conventions, and optimisation guidelines split from SKILL.md. Load on demand when working with screenshots or device-specific captures.

## Capture Dimensions & Display Sizes

Capture at native resolution (or 2× for retina) but always set an explicit display `width` in HTML so the image renders at a consistent, readable size across screens.

| Device | Capture Size (logical px) | Display HTML | Notes |
|--------|--------------------------|-------------|-------|
| Desktop / laptop | 1280×800 | `width="700"` | Standard width; use `width="800"` for full-width hero screenshots |
| Mobile (iPhone) | 390×844 | `width="280"` | Centre-align; narrow images look odd left-aligned |
| Tablet (iPad) | 820×1180 | `width="400"` | Portrait orientation default |
| Terminal / CLI | 80 columns wide | `width="700"` | Use `asciinema`, `vhs`, or `terminalizer` for recordings |

## HTML Patterns

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

## Retina / HiDPI Handling

- **Capture at 2× resolution** (e.g., 2560×1600 for a desktop screenshot) to ensure crisp rendering on retina displays
- **Always set an explicit `width`** in the HTML — without it, the 2× image displays at double size
- Do not use `srcset` in GitHub Markdown — it is not supported. The explicit `width` attribute handles scaling.

## Annotation Conventions

When annotating screenshots with callouts, arrows, or highlights:

- **Colour**: red (#E34234) for callout arrows and highlight boxes — high contrast on most UI backgrounds
- **Stroke**: 2px for arrows and boxes; 3px for emphasis
- **Style**: rounded rectangles for area highlights; straight arrows with solid heads for pointing
- **Text labels**: white text on red background pill, 14px minimum — must be legible at the display `width`
- **Tool recommendations**: Cleanshot X (macOS), Flameshot (Linux), or ShareX (Windows) all support annotation presets

## Captions

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

## Shadows & Borders

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

## Browser Chrome

- **Exclude** browser chrome (address bar, tabs) for focused UI screenshots — readers care about the app, not the browser
- **Include** browser chrome when demonstrating URL patterns, browser extensions, or full-page context
- **Include** browser chrome for marketing hero screenshots where the browser frame adds perceived realism

## File Naming

Pattern: `{feature}-{device}-{variant}.{ext}`

Examples:
- `dashboard-desktop.png` — desktop screenshot of the dashboard
- `dashboard-mobile-dark.png` — mobile screenshot with dark mode
- `setup-terminal.gif` — terminal recording of setup process
- `login-tablet-annotated.png` — annotated tablet screenshot of login

## Optimisation

- Run PNG screenshots through `optipng` or `pngquant` before committing
- Keep GIFs under 5MB (10MB GitHub limit, but large GIFs load slowly); prefer `vhs` SVG recordings for terminal demos
- Target under 300KB per image where possible
