---
name: changelog
description: Generates user-friendly changelogs from git history using conventional commits. Writes entries in benefit language ("You can now..." not "Refactored internal..."). Follows Keep a Changelog format. Use when creating or updating CHANGELOG.md.
version: "1.0.0"
upstream: "keep-a-changelog@1.1.1"
---

# Changelog Generator

## Format: Keep a Changelog

Follow [keepachangelog.com](https://keepachangelog.com/) with marketing-friendly language.

```markdown
# Changelog

All notable changes to this project are documented here.

The format is based on [Keep a Changelog](https://keepachangelog.com/),
and this project adheres to [Semantic Versioning](https://semver.org/).

## [Unreleased]

### Added
- You can now generate READMEs with marketing-friendly language (#42)

### Changed
- Changelog entries are now written in reader-centric language (#38)

### Fixed
- Badge URLs no longer break when the repo is transferred (#35)

## [1.2.0] - 2026-02-20

### Added
- New `/roadmap` command pulls data from GitHub Projects (#30)
- User-benefit language across all generated documents (#28)

### Changed
- Quickstart section now shows TypeScript examples by default (#27)

### Deprecated
- The `--format plain` flag will be removed in v2.0 — use `--format markdown` (#25)

### Security
- Dependencies updated to patch CVE-2026-1234 (#33)

[Unreleased]: https://github.com/org/repo/compare/v1.2.0...HEAD
[1.2.0]: https://github.com/org/repo/compare/v1.1.0...v1.2.0
```

**Compare URL patterns by platform** (load `platform-profiles` for full mapping):
- GitHub: `https://github.com/org/repo/compare/v1.1.0...v1.2.0`
- GitLab: `https://gitlab.com/org/repo/-/compare/v1.1.0...v1.2.0`
- Bitbucket: `https://bitbucket.org/org/repo/branches/compare/v1.2.0..v1.1.0` (note: reversed order)


## Categories (Keep a Changelog Standard)

| Category | When to Use | Conventional Commit Types |
|----------|-------------|--------------------------|
| **Added** | New features for users | `feat:` |
| **Changed** | Changes to existing functionality | `feat:` (modifications), `refactor:` (user-visible) |
| **Deprecated** | Features that will be removed | `feat:` with deprecation |
| **Removed** | Features that were removed | `feat:` (breaking) |
| **Fixed** | Bug fixes | `fix:` |
| **Security** | Vulnerability patches | `fix:` with security label |

## Language Rules

### Write for the USER, not the developer

**Internal changes that don't affect users should be EXCLUDED** from the changelog. Changelogs are for humans who USE the software.

| Don't Write | Write Instead |
|-------------|---------------|
| Refactored database layer | (Skip — internal change) |
| Updated dependencies | Dependencies updated to patch CVE-2026-1234 |
| Fixed bug in parser | Documents with special characters now render correctly |
| Added new API endpoint | You can now retrieve usage metrics via the `/metrics` endpoint |
| Improved performance | Page loads are now 40% faster on large datasets |
| Changed config format | Configuration files now use YAML instead of JSON — see migration guide |

### Sentence patterns

- **Added**: "You can now [do thing] (#issue)" or "New [feature] for [use case] (#issue)"
- **Changed**: "[Thing] now [behaves differently] (#issue)"
- **Fixed**: "[Thing] no longer [breaks in this way] (#issue)"
- **Security**: "Dependencies updated to patch [CVE] (#issue)" or "[Component] no longer exposes [data] (#issue)"
- **Deprecated**: "The [feature/flag] will be removed in [version] — use [alternative] (#issue)"

## Workflow

### Step 1: Analyse Git History

```bash
# Get commits since last tag
git log $(git describe --tags --abbrev=0 2>/dev/null || git rev-list --max-parents=0 HEAD)..HEAD --oneline --no-merges

# Get tags for version comparison links
git tag --sort=-v:refname | head -10

# Check for conventional commit format
git log --oneline -20 | grep -E '^[a-f0-9]+ (feat|fix|docs|style|refactor|perf|test|build|ci|chore|revert)(\(.+\))?:'
```

### Step 2: Classify Changes

For each commit:
1. Parse the conventional commit type
2. Determine if the change is **user-visible**
3. Map to the correct Keep a Changelog category
4. Rewrite the message in user-benefit language
5. Link to the relevant issue/PR number

### Step 3: Group by Version

- If there's no existing CHANGELOG.md, create one with all tagged releases
- If there's an existing one, only add the `[Unreleased]` section
- Always include comparison links at the bottom

### Step 4: Handle Non-Conventional Commits

If the repo doesn't use conventional commits:
1. Analyse the commit message content
2. Check if the commit touches tests, docs, config, or source code
3. Read the diff to understand the nature of the change
4. Classify manually based on the actual change

## Breaking Changes

When a version contains breaking changes (`BREAKING CHANGE:` footer or `feat!:`/`fix!:` prefix), place them prominently:

1. Add a **Breaking Changes** subsection at the top of the version entry, before `### Added`
2. Each entry must include: what changed, why, and a migration path
3. Link to a migration guide if the change affects multiple areas

```markdown
## [2.0.0] - 2026-03-15

### Breaking Changes

- Configuration format changed from JSON to YAML — run `npx migrate-config` to convert (#80)
- The `--format plain` flag has been removed — use `--format markdown` instead (#75)

### Added
...
```

For major versions with many breaking changes, recommend a standalone `docs/guides/migration-v2.md` and link to it from the CHANGELOG entry.

## Anti-Patterns

- **Don't include every commit** — changelogs are curated, not comprehensive
- **Don't include merge commits** — they're noise
- **Don't include internal refactors** — unless they change behaviour
- **Don't use past tense** — "Added" not "We added"
- **Don't duplicate the git log** — add context and user benefit
- **Don't forget comparison links** — they're essential for navigation

## Content Filter Awareness

**Risk level: MEDIUM.** CHANGELOG.md's template-like repetitive structure (version headers, category headers, bullet lists) can trigger Claude Code's content filter (HTTP 400) when writing large blocks.

**Mitigation:**

1. Write in chunks of 5–10 entries at a time — use Write for the initial file, then Edit for appending
2. Keep each write operation under 15 lines of template-like content
3. Start with `[Unreleased]` (most project-specific), then append older versions
4. If the filter triggers, break the blocked content into smaller pieces and rephrase
5. If the filter triggers repeatedly on unrelated content, the session may be poisoned — run `/clear` or start a new session

See the `docs-writer` agent (Content Filter Mitigation section) for the full strategy playbook.
