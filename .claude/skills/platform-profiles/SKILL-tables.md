# Platform Profiles — Lookup Tables

Full lookup tables for GitLab and Bitbucket equivalents split from SKILL.md. Load on demand when the target repo is not on GitHub.

## Template Directory Mapping

| File Type | GitHub | GitLab | Bitbucket |
|-----------|--------|--------|-----------|
| Bug report template | `.github/ISSUE_TEMPLATE/bug_report.yml` | `.gitlab/issue_templates/Bug.md` | N/A (Jira or project settings) |
| Feature request template | `.github/ISSUE_TEMPLATE/feature_request.yml` | `.gitlab/issue_templates/Feature.md` | N/A |
| Template chooser config | `.github/ISSUE_TEMPLATE/config.yml` | N/A | N/A |
| PR/MR template | `.github/PULL_REQUEST_TEMPLATE.md` | `.gitlab/merge_request_templates/Default.md` | N/A (project settings) |
| CI/CD config | `.github/workflows/*.yml` | `.gitlab-ci.yml` | `bitbucket-pipelines.yml` |
| Release config | `.github/release.yml` | N/A (use `release-cli` in CI) | N/A |
| Funding/sponsors | `.github/FUNDING.yml` | N/A | N/A |
| Discussion templates | `.github/DISCUSSION_TEMPLATE/` | N/A (use Issues + labels) | N/A |
| Code owners | `CODEOWNERS` or `.github/CODEOWNERS` | `CODEOWNERS` (root, `docs/`, or `.gitlab/`) | N/A |
| Copilot instructions | `.github/copilot-instructions.md` | N/A | N/A |

**Note:** GitLab issue templates use Markdown (not YAML forms like GitHub). GitLab MR templates support multiple files in `.gitlab/merge_request_templates/` — each `.md` file appears as a chooser option.

## Badge URL Mapping

| Badge | GitHub | GitLab | Bitbucket |
|-------|--------|--------|-----------|
| CI/Pipeline | `shields.io/github/actions/workflow/status/ORG/REPO/ci.yml` | `shields.io/gitlab/pipeline-status/ORG%2FREPO` | `shields.io/bitbucket/pipelines/ORG/REPO/main` |
| Coverage | `shields.io/codecov/c/github/ORG/REPO` | `shields.io/gitlab/coverage/ORG%2FREPO/main` | Use Codecov badge directly |
| Licence | `shields.io/github/license/ORG/REPO` | `shields.io/gitlab/license/ORG%2FREPO` | Static badge only |
| Stars | `shields.io/github/stars/ORG/REPO` | `shields.io/gitlab/stars/ORG%2FREPO` | N/A |
| Issues | `shields.io/github/issues/ORG/REPO` | `shields.io/gitlab/issues/open/ORG%2FREPO` | N/A |
| Last commit | `shields.io/github/last-commit/ORG/REPO` | `shields.io/gitlab/last-commit/ORG%2FREPO` | N/A |
| Version/Release | `shields.io/github/v/release/ORG/REPO` | `shields.io/gitlab/v/release/ORG%2FREPO` | N/A |

**GitLab note:** Encode `/` as `%2F` in shields.io paths (e.g. `org%2Frepo`). Self-hosted GitLab instances need the `?gitlab_url=` parameter.

## CLI Tool Mapping

| Operation | GitHub (`gh`) | GitLab (`glab`) | Bitbucket |
|-----------|---------------|-----------------|-----------|
| View repo metadata | `gh repo view --json` | `glab repo view` | `curl` REST API v2.0 |
| Edit description | `gh repo edit --description` | GitLab API (`PUT /projects/:id`) | `curl` REST API v2.0 |
| List issues | `gh issue list` | `glab issue list` | `curl` REST API v2.0 |
| List MRs/PRs | `gh pr list` | `glab mr list` | `curl` REST API v2.0 |
| Create release | `gh release create` | `glab release create` | N/A (manual or API) |
| Search repos | `gh search repos` | N/A | N/A |

**MCP tools:** The `mcp__github__*` tools in PitchDocs commands are GitHub-specific. For GitLab/Bitbucket, gather equivalent data via `glab` CLI, REST API (`curl`), or git history directly.

## CI/CD and Release Automation

| Concern | GitHub | GitLab | Bitbucket |
|---------|--------|--------|-----------|
| Release automation | release-please (GitHub Actions) | semantic-release or release-it with GitLab CI | semantic-release with Bitbucket Pipelines |
| Version marker | `x-release-please-version` | Depends on tool (semantic-release uses its own) | Depends on tool |
| Changelog generation | release-please auto-generates | GitLab Changelog API or conventional-changelog | conventional-changelog |
| Release artefacts | GitHub Releases | GitLab Releases (`release-cli`) | Bitbucket Downloads |
| Pages hosting | GitHub Pages | GitLab Pages | No native hosting |

## Feature Availability

| Feature | GitHub | GitLab | Bitbucket |
|---------|--------|--------|-----------|
| Discussions | Yes | No (use Issues + labels) | No |
| Sponsors/Funding | `.github/FUNDING.yml` | No equivalent | No |
| Project boards | GitHub Projects | GitLab Boards/Epics | Jira integration |
| CITATION.cff | Yes (renders "Cite this repo") | No special rendering | No |
| Security Advisories | Native (GHSA URLs) | Confidential Issues | No native equivalent |
| Topics/Tags | Topics (API/UI) | Project Topics (API/UI) | No |
| Wiki | Yes (separate tab) | Yes (separate repo) | Yes (separate repo) |
| Social preview image | Settings > Social preview | Settings > General | No |

## Raw File URL Patterns

| Platform | Pattern |
|----------|---------|
| GitHub | `https://raw.githubusercontent.com/ORG/REPO/main/path/to/file` |
| GitLab | `https://gitlab.com/ORG/REPO/-/raw/main/path/to/file` |
| Bitbucket | `https://bitbucket.org/ORG/REPO/raw/main/path/to/file` |

## Compare URL Patterns (for CHANGELOG)

| Platform | Pattern |
|----------|---------|
| GitHub | `https://github.com/ORG/REPO/compare/v1.0.0...v1.1.0` |
| GitLab | `https://gitlab.com/ORG/REPO/-/compare/v1.0.0...v1.1.0` |
| Bitbucket | `https://bitbucket.org/ORG/REPO/branches/compare/v1.1.0..v1.0.0` (note: reversed order) |

## Bitbucket Graceful Degradation

When targeting Bitbucket, apply these fallbacks automatically:

1. **Callouts** — Replace `> [!NOTE]` with `**Note:**` bold inline
2. **Mermaid** — Export diagrams as SVG and embed as `<img>` tags
3. **Task lists** — Use plain `- item` bullets instead of `- [ ] item`
4. **`<picture>` dark mode** — Use a single image with good contrast on both light and dark backgrounds
5. **`<figure>`/`<figcaption>`** — Use the cross-renderer `<p>` + `<em>` caption pattern
6. **Nested lists** — Use 4-space indentation (not 2)
7. **TOC anchors** — Prefix heading slugs with `markdown-header-` (e.g. `#markdown-header-quick-start`)
8. **Issue/PR templates** — Skip generation; note in output that Bitbucket uses project settings or Jira
9. **Funding/Sponsors** — Skip generation; no equivalent exists
10. **Pages** — Recommend Confluence or external static hosting
