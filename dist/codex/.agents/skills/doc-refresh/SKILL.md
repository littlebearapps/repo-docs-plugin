---
name: doc-refresh
description: Orchestrates documentation updates after version bumps, feature additions, or periodic maintenance. Analyses git history since the last release, identifies which docs are affected, and delegates to existing skills (changelog, feature-benefits, docs-verify, llms-txt, user-guides) for selective refresh. Delegates AI context updates to ContextDocs if installed. Use when releasing a new version or refreshing stale docs.
version: "1.0.0"
---

# Doc Refresh

## Philosophy

Generation is solved — PitchDocs handles that. Maintenance is the unsolved problem. After the initial docs suite is created, every release needs a coordinated update: CHANGELOG entries enhanced with benefit language, README features refreshed, user guides amended, AI context files synced, and llms.txt kept current.

`/doc-refresh` closes the maintenance loop. It works alongside release-please: release-please handles version strings and CHANGELOG scaffolding, `/doc-refresh` handles prose, features, context, and metrics.

## Change Detection Workflow

### Step 1: Identify the Boundary

```bash
# Latest tag (the "since" point for change detection)
git describe --tags --abbrev=0 2>/dev/null

# If no tags exist, fall back to initial commit
git rev-list --max-parents=0 HEAD

# All commits since boundary
git log $(git describe --tags --abbrev=0 2>/dev/null || git rev-list --max-parents=0 HEAD)..HEAD --oneline --no-merges

# If a version argument was provided (e.g., v1.5.0..v1.7.0)
git log v1.5.0..v1.7.0 --oneline --no-merges
```

If no tags exist at all, recommend running `/readme` and `/docs-audit fix` instead — a full generation is more appropriate than a refresh for a brand-new repo.

### Step 2: Parse Conventional Commits

Classify each commit into categories that map to documentation impacts:

| Commit Type | Doc Impact |
|-------------|-----------|
| `feat:` | CHANGELOG, README features, possibly user guides, release notes |
| `fix:` | CHANGELOG, possibly troubleshooting guides |
| `docs:` | Verify existing docs are consistent with changes |
| `refactor:` | AI context files (if architecture changed) |
| `perf:` | CHANGELOG, README metrics if benchmarks cited |
| `chore:` | Usually none, unless dependencies changed significantly |
| `BREAKING CHANGE:` | CHANGELOG with migration note, README, migration guide, release notes |

If the repo does not use conventional commits, fall back to `git diff --stat` analysis — classify changes by which files they touch (source, tests, config, docs) rather than commit message prefix.

### Step 3: Detect File-Level Changes

```bash
# Which areas of the project changed?
git diff --name-only $(git describe --tags --abbrev=0 2>/dev/null || git rev-list --max-parents=0 HEAD)..HEAD | head -50

# Specifically check for structural changes (new commands, skills, agents, config)
git diff --name-only $(git describe --tags --abbrev=0 2>/dev/null || git rev-list --max-parents=0 HEAD)..HEAD | grep -E '(commands/|skills/|agents/|rules/|\.config|package\.json|pyproject\.toml)'
```

### Step 4: Build the Refresh Plan

Map detected changes to specific doc files. Output a structured plan before executing:

```
📋 Documentation Refresh Plan: [project-name]

Boundary: v1.6.0..HEAD (15 commits: 8 feat, 4 fix, 2 docs, 1 chore)

Docs to update:
  → CHANGELOG.md — 8 feat + 4 fix entries to enhance with benefit language
  → README.md — 2 new features detected, metrics need updating
  → docs/guides/getting-started.md — new command added, guide needs amendment
  → AGENTS.md — commands table out of date
  → llms.txt — 2 new files to add
  ⊘ .cursorrules — no drift detected
  ⊘ Package registry — no metadata changes
```

In `plan` mode, stop here and report. Otherwise, proceed to execution.

## Refresh Actions Table

| What Changed | CHANGELOG | README Features | README Metrics | User Guides | AI Context | llms.txt | Release Notes |
|-------------|-----------|-----------------|---------------|-------------|------------|----------|---------------|
| New feature (`feat:`) | Append | Update/add | Update counts | Add/update relevant guide | If architecture changed | If new files added | Include |
| Bug fix (`fix:`) | Append | No | No | Update troubleshooting if relevant | No | No | Include |
| New command or skill | Append | Update tables | Update "By the Numbers" | Add to guides hub | Update | Update | Include |
| Dependency change | Conditional | No | No | No | If major dependency | No | Conditional |
| Performance improvement | Append | Update if metrics cited | Update benchmarks | No | No | No | Include |
| Breaking change | Append with migration | Update | No | Add migration guide | Update | No | Include prominently |
| File renamed/moved | No | Update if referenced | No | Update paths | Update paths | Update paths | No |

## Orchestration Workflow

Execute in this order. Each step loads the relevant skill on demand.

### Step 1: Analyse (always runs first)

Run the change detection workflow above. Produce the refresh plan. In `plan` mode, report and stop.

### Step 2: CHANGELOG

Load the `changelog` skill. If release-please has already created CHANGELOG entries for this version, **enhance** them with benefit language rather than duplicating. If no release-please entries exist, generate from scratch using conventional commits.

Detection: check if a version header (e.g., `## [1.7.0]`) or `## [Unreleased]` section already exists in CHANGELOG.md with entries for the commits in scope.

### Step 3: README

Load the `feature-benefits` skill. Run a features audit to compare current README features against the codebase. Update:
- Features section (add new, mark deprecated)
- "By the Numbers" metrics table (command counts, skill counts, etc.)
- Badge version references (note: release-please handles the version badge via `x-release-please-version` — do not duplicate)

### Step 4: User Guides

Load the `user-guides` skill. Identify which guides are affected by checking if changed files relate to documented workflows. Update affected sections. Add new guides if a major new feature warrants one. Update the docs hub page if guides were added.

### Step 5: AI Context Files (ContextDocs)

If [ContextDocs](https://github.com/littlebearapps/contextdocs) is installed (`[ -d ".claude/skills/ai-context" ]`), delegate to it:

```bash
# Check if ContextDocs is available
if [ -d ".claude/skills/ai-context" ]; then
  echo "ContextDocs detected — run /contextdocs:ai-context audit to check for drift"
fi
```

If ContextDocs is not installed, print an advisory:
```
ℹ AI context file refresh skipped — install ContextDocs for AI context management:
  /plugin install contextdocs@lba-plugins
```

### Step 6: llms.txt

Load the `llms-txt` skill. Regenerate if files were added, removed, or renamed since the boundary. If no structural changes, skip.

### Step 7: Package Registry

Load the `package-registry` skill. Verify that package.json/pyproject.toml metadata (description, keywords, repository, homepage) is still current. Flag any drift.

### Step 7.5: Plugin Manifest (if applicable)

If the project has a `.claude-plugin/plugin.json`, verify the `description` and `keywords` fields still match the current README one-liner and features. CLAUDE.md notes "update on every release" — flag stale descriptions that no longer reflect the project's scope.

### Step 8: Verify (always runs last)

Load the `docs-verify` skill. Run full verification: broken links, stale content, llms.txt sync, heading hierarchy, badge URLs, feature coverage, quality score. Report the score and any issues found.

### Step 9: Release Notes (optional)

If `release-notes` argument was provided or running in `full` mode, generate a GitHub release body from the CHANGELOG entry for this version. Format with benefit-driven language and include migration notes for breaking changes.

## Release Automation Integration

The table below shows the split of responsibilities between your release automation tool and `/doc-refresh`. release-please (GitHub Actions) is the default; for GitLab use `semantic-release` with GitLab CI or `release-it`; for Bitbucket use `semantic-release` with Bitbucket Pipelines. Load the `platform-profiles` skill for CI/CD equivalents.

| Responsibility | Release automation tool | `/doc-refresh` |
|---------------|------------------------|----------------|
| Version strings in manifests | Yes | No |
| Version badge in README | Yes (e.g. `x-release-please-version`) | No |
| CHANGELOG scaffolding | Yes (from commit messages) | Enhance with benefit language |
| README prose, features, metrics | No | Yes |
| User guides | No | Yes |
| AI context files | No | Yes |
| llms.txt | No | Yes |
| Release notes body | Basic (from commits) | Enhanced with benefit language |

**Timing:** Run `/doc-refresh` before merging the release PR:
1. Your release tool creates a PR with version bumps and CHANGELOG skeleton
2. Run `/doc-refresh` to enhance CHANGELOG, update README, guides, context files
3. Commit the refreshed docs to the release branch
4. Merge the PR — the release tool creates the platform release

## Anti-Patterns

- **Do not run `/doc-refresh` and `/readme` in the same session** — `/doc-refresh` updates README surgically (affected sections only), while `/readme` regenerates from scratch. Choose one.
- **Do not duplicate CHANGELOG entries** — if release-please already generated entries, enhance them with benefit language rather than creating parallel entries.
- **Do not update user guides for internal refactors** — only update guides when user-facing behaviour changes.
- **Do not regenerate all AI context files** — audit first, update only the files with actual drift.
- **Do not manually update the version badge** — release-please owns the `x-release-please-version` marker.
