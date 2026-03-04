---
title: "Workflow Cookbook"
description: "Step-by-step recipes for common PitchDocs workflows: public-ready repos, releases, launches, and maintenance."
type: how-to
difficulty: intermediate
time_to_complete: "varies per workflow"
last_verified: "1.11.0"
related:
  - guides/getting-started.md
  - guides/command-reference.md
  - guides/customising-output.md
order: 2
---

# Workflow Cookbook

> **Summary**: Step-by-step recipes for common PitchDocs workflows — making repos public-ready, preparing releases, launching on platforms, and keeping docs fresh.

Each recipe lists the commands in order with brief notes — see the [Command Reference](command-reference.md) for full argument details.

---

## Make a Repo Public-Ready

Generate the full documentation set for a project you're about to open-source or publish.

1. **Generate README first** — this establishes the project's voice and features:
   ```
   /pitchdocs:readme
   ```

2. **Audit for missing docs** — check what else the repo needs:
   ```
   /pitchdocs:docs-audit
   ```

3. **Auto-generate everything missing** — fill all gaps in one go:
   ```
   /pitchdocs:docs-audit fix
   ```

4. **Generate AI context files** — help other developers' AI tools understand your project:
   ```
   /pitchdocs:ai-context
   ```

5. **Generate llms.txt** — make the repo AI-discoverable:
   ```
   /pitchdocs:llms-txt full
   ```

6. **Verify everything** — check links, freshness, and quality:
   ```
   /pitchdocs:docs-verify
   ```

7. **Review the quality score** — aim for 80+ (Grade B or above):
   ```
   /pitchdocs:docs-verify score
   ```

**Tip:** If your score is below 80, run `/pitchdocs:docs-verify` without arguments to see which dimensions need improvement, then address them individually.

---

## Prepare a Release

Update documentation after cutting a new version.

1. **Update the changelog** for the new version:
   ```
   /pitchdocs:changelog v1.5.0
   ```

2. **Refresh all affected docs** — analyses git changes since the last tag and updates what's needed:
   ```
   /pitchdocs:doc-refresh
   ```

3. **Verify nothing is broken** — check for stale content and broken links:
   ```
   /pitchdocs:docs-verify
   ```

4. **Update badges** — if your version badge is hardcoded, update it in README. If it uses shields.io dynamic badges, it updates automatically.

**Using release-please?** Run `/pitchdocs:doc-refresh` before merging the release-please PR. Release-please owns version strings; `/pitchdocs:doc-refresh` owns prose, features, metrics, and guides.

---

## Launch on a Platform

Generate launch content for Dev.to, Hacker News, Reddit, Twitter/X, or awesome lists.

1. **Ensure README is polished** — launch artifacts are derived from it:
   ```
   /pitchdocs:readme
   ```

2. **Generate all launch artifacts**:
   ```
   /pitchdocs:launch
   ```

   Or target a specific platform:
   ```
   /pitchdocs:launch devto    # Dev.to article
   /pitchdocs:launch hn       # Hacker News "Show HN" post
   /pitchdocs:launch reddit   # Reddit post templates
   /pitchdocs:launch social   # Twitter/X thread + social preview guide
   /pitchdocs:launch awesome  # Awesome list submission PR
   ```

3. **Review before posting** — all artifacts are written to `docs/launch/` for human review. Check for:
   - Accuracy of feature claims
   - Tone appropriate to the platform (HN values technical depth; Reddit varies by subreddit)
   - Links are correct and publicly accessible
   - Social preview image is set (GitHub Settings → Social preview)

4. **Post and engage** — launch artifacts are starting points, not copy-paste-ready. Adapt to the platform's culture and your audience.

---

## Keep Docs Fresh Over Time

Prevent documentation drift with regular maintenance.

### Recommended cadence

| Trigger | Action |
|---------|--------|
| After every release | `/pitchdocs:doc-refresh` (or `/pitchdocs:doc-refresh v1.x.0`) |
| Monthly (active projects) | `/pitchdocs:docs-verify` to check for staleness |
| Quarterly | `/pitchdocs:features audit` to catch undocumented features |
| After major refactors | `/pitchdocs:ai-context audit` to check context file accuracy |

### Set up Context Guard (Claude Code only)

Install hooks that automatically warn about stale docs:

```
/pitchdocs:context-guard install
```

This adds three hooks:
- **Drift detection** — warns after commits if AI context files are stale
- **Structural change reminders** — nudges you when commands, skills, or config change
- **Content filter guard** — prevents HTTP 400 errors on high-risk file writes

Check status anytime:
```
/pitchdocs:context-guard status
```

### Add docs verification to CI

Run `/pitchdocs:docs-verify ci` to get a CI-friendly output format. Add to GitHub Actions:

```yaml
# .github/workflows/docs.yml
name: Docs Verification
on:
  pull_request:
    paths: ['**.md', 'docs/**', 'llms.txt']

jobs:
  verify:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v4
      - uses: DavidAnson/markdownlint-cli2-action@v18
      - uses: lycheeverse/lychee-action@v2
        with:
          args: --no-progress '**.md'
```

For PitchDocs-specific checks (quality score, feature coverage, llms.txt sync), run `/pitchdocs:docs-verify ci --min-score 70` in a Claude Code session or CI agent.

---

## Document a New Feature

After adding a feature to your codebase, update docs to reflect it.

1. **Check what PitchDocs detects**:
   ```
   /pitchdocs:features audit
   ```

2. **Update README features section**:
   ```
   /pitchdocs:readme focus on features
   ```

3. **Update affected guides** (if any):
   ```
   /pitchdocs:doc-refresh guides
   ```

4. **Refresh AI context files**:
   ```
   /pitchdocs:doc-refresh context
   ```

5. **Verify everything is consistent**:
   ```
   /pitchdocs:docs-verify
   ```

---

**Looking for command details?** See the [Command Reference](command-reference.md). Having trouble? See the [Troubleshooting guide](troubleshooting.md).
