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
| `AGENTS.md` | Cross-tool AI agent context — conventions, architecture, key commands | [ContextDocs](https://github.com/littlebearapps/contextdocs) plugin (install separately) |
| `.github/copilot-instructions.md` | GitHub Copilot repository-level instructions | [ContextDocs](https://github.com/littlebearapps/contextdocs) plugin (install separately) |
| `.windsurfrules` | Windsurf (Cascade AI) project-level context | [ContextDocs](https://github.com/littlebearapps/contextdocs) plugin (install separately) |
| `.clinerules` | Cline VS Code extension project-level context | [ContextDocs](https://github.com/littlebearapps/contextdocs) plugin (install separately) |
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
| `CLAUDE.md` | Project-specific Claude Code context — coding standards, architecture, key paths | [ContextDocs](https://github.com/littlebearapps/contextdocs) plugin (install separately) |
| `.cursorrules` | Cursor-specific rules derived from codebase conventions | [ContextDocs](https://github.com/littlebearapps/contextdocs) plugin (install separately) |
| `GEMINI.md` | Gemini CLI project context (or `.gemini/GEMINI.md`) | [ContextDocs](https://github.com/littlebearapps/contextdocs) plugin (install separately) |
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

See `SKILL-reference.md` for the full topic category table and rules. Aim for 5-10 topics, lowercase and hyphenated.

See `SKILL-reference.md` for description guidance, website URL priorities, package registry configuration, social preview specs, and visual assets guidance.

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

See `SKILL-reference.md` for the three licence validation checks (file exists, manifest matches, no verbatim text in context files).

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

See `SKILL-reference.md` for the licence comparison table and decision guidance. Default to MIT for most projects; use [choosealicense.com](https://choosealicense.com/) or GitHub's built-in licence picker to generate the file.
