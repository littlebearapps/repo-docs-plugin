# Repository Documentation Suite — Reference

Companion file for the `pitchdocs-suite` skill. Load this file when you need topic suggestions, metadata guidance, social preview specs, visual assets advice, licence selection, or licence validation checks.

## Topic Suggestion Framework

Suggest topics by scanning the project and picking from these categories. Aim for 5-10 topics total.

| Category | Source | Examples |
|----------|--------|----------|
| Language/runtime | Manifest file (`package.json`, `pyproject.toml`, `go.mod`) | `typescript`, `python`, `go`, `rust`, `javascript` |
| Framework | Dependencies and config files | `react`, `nextjs`, `fastapi`, `django`, `cloudflare-workers` |
| Category | What the project IS | `documentation`, `cli`, `api`, `devtools`, `plugin`, `library` |
| Ecosystem | Platform or tool ecosystem it belongs to | `claude-code`, `openai`, `llm`, `github-actions`, `terraform` |
| Purpose | What problem it solves | `testing`, `monitoring`, `deployment`, `developer-tools`, `code-generation` |

**Rules:**
- Use lowercase, hyphenated (GitHub enforces this)
- Be specific: `claude-code-plugin` over `plugin`
- Include the primary language even if obvious
- Don't pad with generic topics like `awesome` or `open-source`
- Match topics that real users would search for

## Social Preview Image

The social preview appears when sharing repo links on Twitter/X, Slack, Discord, and LinkedIn. Without a custom image, GitHub auto-generates a bland preview from the repo name.

- **Recommended size**: 1280x640px (minimum 640x320)
- **File size**: under 1MB, ideally <300KB
- **Set via**: Settings > Social preview (manual upload — no CLI or API)
- **Design tip**: keep key text centred to survive cropping on different platforms
- **Cannot be audited programmatically** — the audit should remind users to check

## LICENSE Selection Framework

The plugin checks for LICENSE presence but does not generate the file content — use GitHub's built-in license picker or [choosealicense.com](https://choosealicense.com/).

| License | Best For | Key Feature |
|---------|----------|-------------|
| MIT | Libraries, tools, general OSS | Maximum freedom, minimal restrictions |
| Apache-2.0 | Libraries with patent concerns | Explicit patent grant |
| GPL-3.0 | Projects that must stay open | Copyleft — derivatives must be GPL too |
| AGPL-3.0 | SaaS/server-side projects | Network copyleft — even hosted use triggers sharing |
| ISC | Minimal alternative to MIT | Functionally identical, shorter text |
| Unlicense | Public domain dedication | No restrictions at all |

**Decision guidance:**
- Default to MIT for most open-source projects
- Use Apache-2.0 if contributors may hold patents
- Use GPL/AGPL only with clear intent — it limits adoption by commercial users
- Check `license` field in `package.json`/`pyproject.toml` matches the LICENSE file content
- Proprietary projects may omit LICENSE or include custom terms

## Description Guidance

The GitHub repo description should match or condense the README one-liner:
- Maximum ~350 characters (GitHub truncates beyond this)
- Benefit-focused, not feature-focused
- No markdown — plain text only
- Should make sense standalone in search results

## Website URL Guidance

Set to the most useful entry point for new users, in priority order:
1. Dedicated docs site (e.g., `docs.project.com`)
2. Project homepage (e.g., `project.com`)
3. Package registry page (e.g., `npmjs.com/package/name`)
4. GitHub Pages docs (e.g., `org.github.io/repo`)

## Package Registry Configuration

For projects published to npm or PyPI, the package registry page is often the second most-visited page after the GitHub repo. Registry metadata affects search ranking, trust signals, and first impressions.

Load the `package-registry` skill for:
- Complete field inventories (what metadata affects the npm/PyPI page)
- README cross-renderer compatibility (what Markdown features break on npm/PyPI)
- Registry-specific badge templates (version, downloads, types, Python versions)
- Trusted publishing and provenance guidance (npm OIDC, PyPI Trusted Publisher)
- Audit checklists for registry metadata completeness

## Visual Assets Guidance

Store visual assets in-repo (`docs/images/` or `assets/`) for files under 5MB, or use GitHub user-content URLs (drag-drop into any issue/PR) to keep repo size small. Prefer SVG for diagrams, PNG for screenshots, GIF for demos (<10MB). Always include descriptive alt text, optimise to <300KB, and use kebab-case naming (`demo-quick-start.gif`).

For device-specific capture dimensions, HTML display patterns, captions, shadows, and annotation conventions, load the `visual-standards` skill.

## License Validation

Three checks to catch common license issues:

1. **LICENSE file exists** — flag if the file uses `.md` extension (`LICENSE.md`). GitHub's licence detection prefers extensionless `LICENSE` or `LICENSE.txt`.

2. **Manifest matches LICENSE** — cross-reference the `license` field in `package.json` or `pyproject.toml` against the LICENSE file header:
   ```bash
   # npm
   node -e "console.log(require('./package.json').license)" 2>/dev/null
   # PyPI
   python3 -c "import tomllib; f=open('pyproject.toml','rb'); print(tomllib.load(f).get('project',{}).get('license'))" 2>/dev/null
   ```
   Flag mismatches (e.g., manifest says `MIT` but LICENSE file contains Apache-2.0 text).

3. **No verbatim license text in context files** — AI-generated context files sometimes accidentally embed full license text. Scan for license preamble patterns:
   ```bash
   grep -rl "Permission is hereby granted, free of charge" .claude/ .cursorrules AGENTS.md .clinerules .windsurfrules GEMINI.md 2>/dev/null
   grep -rl "Licensed under the Apache License" .claude/ .cursorrules AGENTS.md .clinerules .windsurfrules GEMINI.md 2>/dev/null
   ```
   Flag any matches — license text belongs in LICENSE, not in skill/rule/context files.
