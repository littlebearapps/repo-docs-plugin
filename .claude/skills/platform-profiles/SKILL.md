---
name: platform-profiles
description: Platform-specific equivalents for GitLab and Bitbucket when generating repository documentation. Lookup tables for file paths, badges, Markdown rendering, CI/CD, and CLI tools. Load this skill when working on non-GitHub repos or generating cross-platform docs.
version: "1.0.0"
---

# Platform Profiles

PitchDocs defaults to GitHub conventions. Load this skill when the target repository is hosted on GitLab or Bitbucket, or when generating docs that must work across platforms.

## Platform Detection

```bash
[ -f ".gitlab-ci.yml" ] && PLATFORM="gitlab"
[ -f "bitbucket-pipelines.yml" ] && PLATFORM="bitbucket"
[ -d ".github" ] && PLATFORM="github"
PLATFORM=${PLATFORM:-$(git remote get-url origin 2>/dev/null | grep -oE '(github|gitlab|bitbucket)' | head -1)}
```

## Markdown Rendering Compatibility

| Feature | GitHub | GitLab | Bitbucket |
|---------|--------|--------|-----------|
| `> [!NOTE]` callouts | Yes | Yes | **No** — use `**Note:**` bold inline |
| `<p align="center">` | Yes | Yes | Limited |
| `<picture>` dark mode | Yes | Yes | **No** — use single high-contrast image |
| `<details>`/`<summary>` | Yes | Yes | Limited |
| Mermaid diagrams | Yes | Yes (+ PlantUML) | **No** — use pre-rendered SVG |
| Task lists `- [ ]` | Yes | Yes | **No** — renders as plain text |
| Auto TOC | No (manual) | `[[_TOC_]]` | No (manual) |
| Heading anchor format | `#slug-format` | `#slug-format` | `#markdown-header-slug-format` |
| Nested list indentation | 2 spaces | 2 spaces | **4 spaces** |
| HTML permissiveness | Moderate (strips `style`) | More permissive | Restrictive |

## Quick Reference

- **GitLab**: Encode `/` as `%2F` in shields.io paths. Self-hosted instances need `?gitlab_url=` parameter.
- **Bitbucket**: No `<picture>`, no Mermaid, no task lists, use 4-space nested indentation, prefix heading anchors with `markdown-header-`.
- **MCP tools**: `mcp__github__*` are GitHub-specific. For GitLab/Bitbucket, use `glab` CLI, REST API, or git history.

For full lookup tables (template directory mapping, badge URLs, CLI tools, CI/CD, feature availability, raw file URLs, compare URLs, Bitbucket degradation), load `SKILL-tables.md` from this skill directory.
