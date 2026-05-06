---
name: package-registry
description: Documentation guidance for projects published to npm and PyPI package registries. Covers metadata fields that affect registry pages, README cross-renderer compatibility, trusted publishing, provenance badges, and audit checks. Use when a project has package.json or pyproject.toml and is published publicly.
version: "1.0.0"
---

# Package Registry Documentation Guidance

## When This Applies

These checks are **conditional** — only run when the project is published to a package registry.

| File Present | Registry | Action |
|-------------|----------|--------|
| `package.json` | npm (npmjs.com) | Check npm metadata fields, badge templates |
| `pyproject.toml` | PyPI (pypi.org) | Check PyPI metadata fields, Markdown compatibility |
| Both | npm + PyPI | Check both; cross-renderer compatibility is critical |

Detection:
```bash
[ -f "package.json" ] && echo "npm project detected"
[ -f "pyproject.toml" ] && echo "PyPI project detected"
```

## npm Registry Metadata

The README displayed on npmjs.com comes from the **published tarball**, not live from GitHub. Changes to your README on GitHub do not update the npm page until you publish a new version.

See `SKILL-reference.md` for the full `package.json` field table and always-included files list.

## PyPI Registry Metadata

See `SKILL-reference.md` for the full `pyproject.toml` field table, well-known URL labels, and PEP 639 SPDX licence guidance.

### Verified vs Unverified Details

PyPI's sidebar splits project information into two sections:
- **Verified details** (green checkmark): URLs verified through Trusted Publisher. GitHub statistics (stars, forks) only shown here.
- **Unverified details**: URLs and metadata that cannot be automatically verified.

Configuring a Trusted Publisher automatically verifies the repository URL.

## README Cross-Renderer Compatibility

READMEs render on multiple platforms. What works on GitHub may break on npm or PyPI.

| Markdown Feature | GitHub | npm | PyPI | Workaround |
|-----------------|--------|-----|------|------------|
| Heading anchors (`#section`) | Yes | Yes | **No** | Use full URLs to GitHub README |
| Relative images (`./docs/img.png`) | Yes | **No** | **No** | Use absolute `raw.githubusercontent.com` URLs |
| GitHub callouts (`[!NOTE]`) | Yes | **No** | **No** | Use bold text or blockquotes |
| `<details>`/`<summary>` | Yes | Yes | **Unreliable** | Avoid for critical content |
| `colspan`/`rowspan` in tables | Partial | Partial | **No** | Use simpler table structures |
| `<div align="center">` | Yes | Yes | **No** | Acceptable loss; PyPI strips most HTML alignment |
| Mermaid diagrams | Yes | **No** | **No** | Use pre-rendered SVG/PNG images |
| Task lists (`- [ ]`) | Yes | Yes | **No** | Use bullet lists with emoji checkmarks |
| Footnotes | Yes | **No** | **No** | Use inline parenthetical notes |

### Key Rules for Multi-Renderer READMEs

1. **Always use absolute URLs for images** — relative paths break on both npm and PyPI
2. **Avoid GitHub-specific callouts** (`[!NOTE]`, `[!WARNING]`) — plain text elsewhere
3. **Avoid heading anchor links** if PyPI rendering matters — broken on PyPI
4. **Avoid `<details>`/`<summary>`** for critical content — unreliable on PyPI
5. **Test before publishing**: `twine check dist/*` validates PyPI README rendering

### Solving GitHub vs PyPI Differences

For Python projects needing optimised READMEs on both platforms, consider `hatch-fancy-pypi-readme`:
- Assembles PyPI READMEs from fragments
- Runs regex substitutions to transform GitHub-specific content
- Converts relative links to absolute links

## Trusted Publishing and Provenance

This section covers documentation-relevant aspects. The plugin does NOT create publish workflows (that's DevOps).

### npm Trusted Publishing

- **OIDC trusted publishing went GA July 2025** — replaces long-lived tokens entirely
- Classic tokens permanently revoked December 2025; granular tokens max 90 days
- Publishing with `--provenance` flag adds a **Sigstore badge** on npmjs.com linking to the exact source commit and build workflow
- Requires `id-token: write` permission in GitHub Actions
- `repository.url` in package.json must exactly match the GitHub repo URL (case-sensitive)

### PyPI Trusted Publishing

- **Trusted Publisher since April 2023** — first major registry to support OIDC
- **Digital attestations (PEP 740) since November 2024** — Sigstore signing for package files
- "Verified details" sidebar badge appears automatically when trusted publisher is configured
- Repository URL in `[project.urls]` must match the GitHub repo for verification
- `pypa/gh-action-pypi-publish` handles publishing when configured as a trusted publisher

### What to Audit (Not Configure)

- Check if `repository.url` (npm) or `[project.urls].Repository` (PyPI) matches the actual GitHub repo URL
- Flag opportunity to add provenance/attestation badges to README if not present
- Link to trusted publishing setup docs in audit output

## Registry-Specific Badges

See `SKILL-reference.md` for npm and PyPI badge templates and recommended badge order.

## Audit Checklist

See `SKILL-reference.md` for the full npm and PyPI audit checklists.
