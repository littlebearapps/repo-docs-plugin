# Package Registry Reference Tables

Companion to `SKILL.md`. Contains registry metadata field tables, badge templates, and audit checklists.

## npm Registry Metadata Fields

### package.json Fields That Affect the npm Page

| Field | Affects | Priority | Notes |
|-------|---------|----------|-------|
| `name` | Package name in header and URL | Required | Scoped (`@org/name`) preferred for organisations |
| `version` | Version display, install command | Required | Must follow semver |
| `description` | Search results, package header | High | First ~200 chars shown in search; match README value proposition |
| `keywords` | npm search discovery | High | Array of strings, aim for 5–10 relevant terms |
| `homepage` | "Homepage" sidebar link | High | Docs site or project page |
| `repository` | "Repository" sidebar link, GitHub integration | High | Must be `{ "type": "git", "url": "git+https://github.com/org/repo.git" }` |
| `bugs` | "Issues" sidebar link | Medium | `{ "url": "https://github.com/org/repo/issues" }` |
| `license` | Licence badge in sidebar | High | SPDX identifier string (e.g., `"MIT"`, `"Apache-2.0"`) |
| `author` | Displayed on package page | Medium | `{ "name": "...", "email": "...", "url": "..." }` |
| `funding` | "Fund this package" button | Low | URL string or `{ "type": "github", "url": "..." }` |
| `types` / `typings` | TypeScript indicator (TS badge) | High (for TS) | Path to `.d.ts` file; npm won't show TS badge without explicit field |
| `files` | What gets published in tarball | High | Whitelist approach preferred; README/LICENSE/CHANGELOG always included |

**Critical for trusted publishing:** `repository.url` must **exactly match** the GitHub repository URL (case-sensitive) for npm OIDC trusted publishing to work.

### npm Always-Included Files

Regardless of the `files` field or `.npmignore`, npm always includes:
- `package.json`
- `README` (any case, any extension)
- `LICENSE` / `LICENCE` (any case, any extension)
- `CHANGELOG` (any case, any extension)
- The file referenced by `main`

Use `npm pack` to inspect tarball contents before publishing.

## PyPI Registry Metadata Fields

### pyproject.toml Fields That Affect the PyPI Page

| Field | Section | Affects | Notes |
|-------|---------|---------|-------|
| `name` | `[project]` | Package name and URL | PEP 503 normalisation (hyphens = underscores) |
| `version` | `[project]` | Version display | Or dynamic via build backend |
| `description` | `[project]` | Search results summary | Single line, plain text |
| `readme` | `[project]` | Full description on project page | `"README.md"` or `{ file = "README.md", content-type = "text/markdown" }` |
| `license` | `[project]` | Licence display | PEP 639: SPDX expression preferred (`"MIT"`, `"Apache-2.0 OR MIT"`) |
| `requires-python` | `[project]` | Python version badge | `">=3.10"` |
| `keywords` | `[project]` | Search discovery | Array of strings |
| `classifiers` | `[project]` | Category browsing on PyPI | Trove classifiers (still relevant for non-licence metadata) |
| `urls` | `[project.urls]` | Sidebar links with custom icons | Use well-known labels below |

### Well-Known PyPI URL Labels

PyPI recognises specific URL labels and displays them with **custom icons** instead of generic links. Labels are normalised (punctuation/whitespace removed, lowercased).

| Label | Icon | Example URL |
|-------|------|-------------|
| `Homepage` | House | `https://project.com` |
| `Repository` or `Source` | Code | `https://github.com/org/repo` |
| `Documentation` or `Docs` | Book | `https://docs.project.com` |
| `Changelog` or `Changes` | List | `https://github.com/org/repo/blob/main/CHANGELOG.md` |
| `Issues` or `Bug Tracker` | Bug | `https://github.com/org/repo/issues` |
| `Funding` or `Sponsor` | Heart | `https://github.com/sponsors/org` |
| `Download` | Download | `https://github.com/org/repo/releases` |

Example:
```toml
[project.urls]
Homepage = "https://project.com"
Repository = "https://github.com/org/repo"
Documentation = "https://docs.project.com"
Changelog = "https://github.com/org/repo/blob/main/CHANGELOG.md"
Issues = "https://github.com/org/repo/issues"
```

### PEP 639: SPDX Licence Expressions

The new standard for licence metadata in Python. Replaces trove classifier licence identifiers.

**New approach (recommended):**
```toml
[project]
license = "MIT"              # SPDX expression
license-files = ["LICENSE"]  # Explicit file paths
```

**Old approach (deprecated):**
```toml
[project]
license = {text = "MIT License"}
```

SPDX expressions are more precise than trove classifiers (e.g., distinguishes BSD-2-Clause from BSD-3-Clause).

## Registry-Specific Badges

### npm Badges

```markdown
[![npm version](https://img.shields.io/npm/v/PACKAGE-NAME)](https://www.npmjs.com/package/PACKAGE-NAME)
[![npm downloads](https://img.shields.io/npm/dm/PACKAGE-NAME)](https://www.npmjs.com/package/PACKAGE-NAME)
[![npm bundle size](https://img.shields.io/bundlephobia/minzip/PACKAGE-NAME)](https://bundlephobia.com/package/PACKAGE-NAME)
[![types](https://img.shields.io/npm/types/PACKAGE-NAME)](https://www.npmjs.com/package/PACKAGE-NAME)
```

### PyPI Badges

```markdown
[![PyPI version](https://img.shields.io/pypi/v/PACKAGE-NAME)](https://pypi.org/project/PACKAGE-NAME/)
[![Python versions](https://img.shields.io/pypi/pyversions/PACKAGE-NAME)](https://pypi.org/project/PACKAGE-NAME/)
[![PyPI downloads](https://img.shields.io/pypi/dm/PACKAGE-NAME)](https://pypi.org/project/PACKAGE-NAME/)
[![PyPI status](https://img.shields.io/pypi/status/PACKAGE-NAME)](https://pypi.org/project/PACKAGE-NAME/)
```

Badge order (after CI/coverage badges):
1. Registry version (npm or PyPI)
2. Downloads
3. Type support (npm types) or Python versions (PyPI)
4. Bundle size (npm only) or status (PyPI only)

## Audit Checklist

### npm Project (package.json exists)

- [ ] `description` present and matches README value proposition
- [ ] `keywords` present with at least 3 relevant entries
- [ ] `repository` present with correct URL format (`{ "type": "git", "url": "git+https://..." }`)
- [ ] `homepage` present (docs site, project page, or npm page)
- [ ] `bugs` present (GitHub issues URL)
- [ ] `license` present and matches LICENSE file (SPDX identifier)
- [ ] `types` or `typings` present if TypeScript project (check for tsconfig.json)
- [ ] `files` whitelist present (preferred over .npmignore)
- [ ] `author` or `contributors` present
- [ ] `funding` present (if sponsorship available)
- [ ] README avoids npm-incompatible Markdown (relative images, Mermaid, footnotes)

### PyPI Project (pyproject.toml exists)

- [ ] `[project].description` present and non-empty
- [ ] `[project].readme` points to README.md with correct content-type
- [ ] `[project].keywords` present with at least 3 entries
- [ ] `[project].license` present (SPDX expression preferred per PEP 639)
- [ ] `[project].requires-python` present
- [ ] `[project.urls]` has at least Homepage, Repository, and Issues (using well-known labels)
- [ ] `[project].classifiers` includes relevant trove classifiers (development status, language, topic)
- [ ] `[project].authors` or `[project].maintainers` present
- [ ] README avoids PyPI-incompatible Markdown (heading anchors, relative images, callouts, details/summary)
