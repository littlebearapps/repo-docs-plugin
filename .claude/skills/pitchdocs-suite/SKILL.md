---
name: pitchdocs-suite
description: One-command generation and audit of the full public repository documentation set — README, CHANGELOG, ROADMAP, CONTRIBUTING, CODE_OF_CONDUCT, SECURITY, issue templates, PR template, and discussion templates. Use when setting up a new repo or auditing an existing one.
version: "1.0.0"
upstream: "contributor-covenant@3.0"
---

# Repository Documentation Suite

## Complete Docs Inventory

A well-documented public repository should have these files:

**Platform note:** The file paths below use GitHub conventions. For GitLab or Bitbucket repositories, load the `platform-profiles` skill for equivalent paths (e.g. `.gitlab/issue_templates/` instead of `.github/ISSUE_TEMPLATE/`).

### Tier 1: Essential (Every Public Repo)

| File | Purpose | Generator |
|------|---------|-----------|
| `README.md` | First impression, value proposition, quickstart | `public-readme` skill |
| `LICENSE` | Legal terms for usage — see LICENSE Selection Framework below | Auto-detect from package.json |
| `CONTRIBUTING.md` | How to contribute code, report bugs, suggest features | This skill |
| `.github/ISSUE_TEMPLATE/bug_report.yml` | Structured bug reports | This skill |
| `.github/ISSUE_TEMPLATE/feature_request.yml` | Feature proposals | This skill |
| `.github/PULL_REQUEST_TEMPLATE.md` | PR checklist and description template | This skill |

### Tier 2: Professional (Active Projects)

| File | Purpose | Generator |
|------|---------|-----------|
| `CHANGELOG.md` | User-facing change history | `changelog` skill |
| `SUPPORT.md` | Where to get help — issues, discussions, external channels | This skill |
| `.github/release.yml` | Auto-generated release note categories | This skill |
| `llms.txt` | LLM-friendly content index for AI tools (Cursor, Windsurf, Claude Code) | `llms-txt` skill |
| `AGENTS.md` | Cross-tool AI agent context — conventions, architecture, key commands | `ai-context` skill |
| `.github/copilot-instructions.md` | GitHub Copilot repository-level instructions | `ai-context` skill |
| `.windsurfrules` | Windsurf (Cascade AI) project-level context | `ai-context` skill |
| `.clinerules` | Cline VS Code extension project-level context | `ai-context` skill |
| `CODE_OF_CONDUCT.md` | Community behaviour standards | This skill |
| `SECURITY.md` | Vulnerability reporting process | This skill |
| `.github/ISSUE_TEMPLATE/config.yml` | Issue template chooser config | This skill |
| `.github/FUNDING.yml` | Sponsorship links (GitHub only) | This skill |
| `docs/README.md` | Documentation hub page | `user-guides` skill |
| `docs/guides/getting-started.md` | Expanded quickstart for new users | `user-guides` skill |

### Tier 3: Mature (Established Projects)

| File | Purpose | Generator |
|------|---------|-----------|
| `ROADMAP.md` | Public development roadmap | `roadmap` skill |
| `CLAUDE.md` | Project-specific Claude Code context — coding standards, architecture, key paths | `ai-context` skill |
| `.cursorrules` | Cursor-specific rules derived from codebase conventions | `ai-context` skill |
| `GEMINI.md` | Gemini CLI project context (or `.gemini/GEMINI.md`) | `ai-context` skill |
| `docs/guides/configuration.md` | All config options explained | `user-guides` skill |
| `docs/guides/deployment.md` | Production deployment guide | `user-guides` skill |
| `docs/guides/troubleshooting.md` | Common issues and solutions | `user-guides` skill |
| `.github/DISCUSSION_TEMPLATE/` | Structured discussion categories (GitHub only) | This skill |
| `.github/CODEOWNERS` | Automatic review assignment | Manual |
| `CITATION.cff` | Machine-readable citation for academic/research repos (GitHub shows "Cite this repository" button) | This skill |

### Repository Metadata (Hosting Platform Settings)

Beyond files, a well-configured repo also needs correct platform-level metadata for discoverability. The commands below use `gh` CLI (GitHub). For GitLab, use `glab`. For Bitbucket, use the REST API. Load the `platform-profiles` skill for full CLI mapping.

| Setting | Purpose | Limit |
|---------|---------|-------|
| **Topics** | Drive GitHub search and discovery — appear in repo header and topic browse pages | Up to 20 |
| **Description** | Short text under repo name in GitHub search results and repo header | ~350 characters |
| **Website URL** | Linked from repo header — directs users to docs site, homepage, or package registry | Single URL |

#### Reading Current Metadata

```bash
gh repo view --json topics,homepageUrl,description
```

#### Setting Metadata

```bash
# Topics — add individually
gh repo edit --add-topic typescript --add-topic documentation --add-topic cli

# Description
gh repo edit --description "Generate repository documentation that sells as well as it informs."

# Website URL
gh repo edit --homepage "https://docs.example.com"
```

#### Topic Suggestion Framework

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

#### Description Guidance

The GitHub repo description should match or condense the README one-liner:
- Maximum ~350 characters (GitHub truncates beyond this)
- Benefit-focused, not feature-focused
- No markdown — plain text only
- Should make sense standalone in search results

#### Website URL Guidance

Set to the most useful entry point for new users, in priority order:
1. Dedicated docs site (e.g., `docs.project.com`)
2. Project homepage (e.g., `project.com`)
3. Package registry page (e.g., `npmjs.com/package/name`)
4. GitHub Pages docs (e.g., `org.github.io/repo`)

#### Package Registry Configuration

For projects published to npm or PyPI, the package registry page is often the second most-visited page after the GitHub repo. Registry metadata affects search ranking, trust signals, and first impressions.

Load the `package-registry` skill for:
- Complete field inventories (what metadata affects the npm/PyPI page)
- README cross-renderer compatibility (what Markdown features break on npm/PyPI)
- Registry-specific badge templates (version, downloads, types, Python versions)
- Trusted publishing and provenance guidance (npm OIDC, PyPI Trusted Publisher)
- Audit checklists for registry metadata completeness

#### Social Preview Image

The social preview appears when sharing repo links on Twitter/X, Slack, Discord, and LinkedIn. Without a custom image, GitHub auto-generates a bland preview from the repo name.

- **Recommended size**: 1280x640px (minimum 640x320)
- **File size**: under 1MB, ideally <300KB
- **Set via**: Settings > Social preview (manual upload — no CLI or API)
- **Design tip**: keep key text centred to survive cropping on different platforms
- **Cannot be audited programmatically** — the audit should remind users to check

### Visual Assets Guidance

Store visual assets in-repo (`docs/images/` or `assets/`) for files under 5MB, or use GitHub user-content URLs (drag-drop into any issue/PR) to keep repo size small. Prefer SVG for diagrams, PNG for screenshots, GIF for demos (<10MB). Always include descriptive alt text, optimise to <300KB, and use kebab-case naming (`demo-quick-start.gif`).

For device-specific capture dimensions, HTML display patterns, captions, shadows, and annotation conventions, load the `visual-standards` skill.

## Audit Workflow

### Step 1: Scan Existing Docs

```bash
# Check for all expected files
for f in README.md LICENSE CONTRIBUTING.md CHANGELOG.md ROADMAP.md CODE_OF_CONDUCT.md SECURITY.md SUPPORT.md llms.txt AGENTS.md CLAUDE.md .cursorrules .windsurfrules .clinerules; do
  [ -f "$f" ] && echo "✓ $f" || echo "✗ $f (missing)"
done

# Check .github templates and AI context files
for f in .github/ISSUE_TEMPLATE/bug_report.yml .github/ISSUE_TEMPLATE/feature_request.yml .github/PULL_REQUEST_TEMPLATE.md .github/ISSUE_TEMPLATE/config.yml .github/copilot-instructions.md; do
  [ -f "$f" ] && echo "✓ $f" || echo "✗ $f (missing)"
done

# Check for common alternatives
[ -f ".github/ISSUE_TEMPLATE/bug_report.md" ] && echo "⚠ bug_report.md found (consider migrating to YAML forms)"
```

### Step 2: Quality Check Existing Files

For each existing file, check:
- **README.md**: Does it pass the 4-question test? Does it have badges? Is the quickstart working?
- **CONTRIBUTING.md**: Does it match the actual development workflow?
- **CHANGELOG.md**: Is it up to date with the latest release?
- **SECURITY.md**: Does it include a responsible disclosure process?

#### License Validation

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

### Step 3: Generate Missing Files

Use the appropriate skill/template for each missing file. Generate in priority order:
1. README.md (if missing or needs overhaul)
2. CONTRIBUTING.md
3. Issue templates
4. PR template
5. CHANGELOG.md
6. Everything else

## Templates

Templates for CONTRIBUTING.md, CODE_OF_CONDUCT.md, SECURITY.md, issue templates, PR template, FUNDING.yml, SUPPORT.md, release.yml, and CITATION.cff are in the companion file `SKILL-templates.md`. Load it when generating specific files from the inventory.

**Content filter note:** Several templates trigger Claude Code's content filter. See `SKILL-templates.md` for per-file generation strategies (fetch vs chunked write).

### LICENSE Selection Framework

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
