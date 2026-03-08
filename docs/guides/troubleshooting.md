---
title: "Troubleshooting & FAQ"
description: "Common PitchDocs issues and solutions — content filter errors, score interpretation, badge issues, and cross-tool limitations."
type: how-to
difficulty: intermediate
last_verified: "1.11.0"
related:
  - guides/getting-started.md
  - guides/other-ai-tools.md
order: 6
---

# Troubleshooting & FAQ

> **Summary**: Common issues when using PitchDocs and how to resolve them — content filter errors, quality scores, feature extraction, badges, and cross-tool limitations.

Common issues when using PitchDocs and how to resolve them.

---

## Content Filter Errors (HTTP 400)

Claude Code's API content filter blocks output when generating certain standard open-source files. This is a context-blind copyright filter — it triggers on governance language, security keywords, and verbatim legal text even when the intent is entirely legitimate.

**High-risk files** (will almost always trigger):
- `CODE_OF_CONDUCT.md`
- `LICENSE`
- `SECURITY.md`

**Solution:** Fetch these files from canonical URLs instead of generating them:

```bash
# Contributor Covenant v3.0
curl -sL "https://www.contributor-covenant.org/version/3/0/code_of_conduct/code_of_conduct.md" -o CODE_OF_CONDUCT.md

# MIT License (substitute SPDX identifier as needed)
curl -sL "https://raw.githubusercontent.com/spdx/license-list-data/main/text/MIT.txt" -o LICENSE

# Security policy template
curl -sL "https://raw.githubusercontent.com/github/.github/main/SECURITY.md" -o SECURITY.md
```

After fetching, use `/pitchdocs:readme` or manual edits to customise placeholders like `[INSERT CONTACT METHOD]`.

**Medium-risk files** (`CHANGELOG.md`, `CONTRIBUTING.md`):
- Write in chunks — 5 to 10 entries at a time
- Start with project-specific content before generic sections
- Use Edit to append rather than Write to create large files

**If the filter triggers:**

1. Do **not** retry the same content — the filter is largely deterministic
2. Switch to a fetch-based strategy (commands above)
3. If subsequent unrelated writes also fail, the session may be poisoned — run `/clear` or start a new session
4. For medium-risk files, break into smaller chunks and rephrase

**Other known triggers:** ISO country/state code lists, character mapping tables (e.g. kana-to-romaji), and large lookup tables. The same chunked-writing strategy applies.

---

## Quality Score Interpretation

When you run `/pitchdocs:docs-verify score`, PitchDocs rates your documentation across 5 dimensions (total: 0–100):

| Dimension | Max Points | What It Measures |
|-----------|-----------|------------------|
| Completeness | 30 | Presence of essential files (README, LICENSE, CONTRIBUTING, issue/PR templates, CHANGELOG, SECURITY, llms.txt, AGENTS.md) |
| Structure | 20 | Heading hierarchy, hero section completeness, 4-question framework adherence, single H1 rule |
| Freshness | 15 | How recently files were updated relative to latest commits |
| Link Health | 20 | Broken internal links, dead external URLs, missing anchors |
| Evidence | 15 | Feature coverage (documented vs actual), benefit translations |
| AI Context Health | (deductions) | Line budgets, discoverable content, stale paths, cross-file consistency |

**Grade bands:**

| Score | Grade | Meaning |
|-------|-------|---------|
| 90–100 | A | Ship-ready |
| 80–89 | B | Minor fixes needed |
| 70–79 | C | Needs work |
| 60–69 | D | Significant gaps |
| Below 60 | F | Not ready |

**Improving your score:**
- **Completeness**: Run `/pitchdocs:docs-audit fix` to auto-generate missing files
- **Structure**: Ensure README has a hero section (logo + one-liner + badges), uses heading hierarchy without skipping levels (H1 > H2 > H3, never H1 > H3)
- **Freshness**: Run `/pitchdocs:doc-refresh` after releases or feature additions
- **Link Health**: Run `/pitchdocs:docs-verify links` and fix reported broken links
- **Evidence**: Run `/pitchdocs:features audit` to find undocumented features, then update README

---

## Feature Extraction Issues

### PitchDocs missed a feature

`/pitchdocs:features` scans 10 signal categories. If it missed something:

1. Check that the feature has code evidence — PitchDocs requires file-level proof (a file path, function name, or config option) for every feature claim
2. Ensure the feature falls within the 10 signal categories: CLI commands, public API, configuration, integrations, performance, security, TypeScript/DX, testing, middleware/plugins/extensibility, and documentation
3. Try running `/pitchdocs:features` with a specific focus: describe the feature area in your prompt (e.g., `/pitchdocs:features focus on the webhook integration`)
4. For features only visible at runtime (e.g. env-var-controlled behaviour), add an `.env.example` or config schema — PitchDocs scans these

### PitchDocs listed a feature that doesn't exist

Run `/pitchdocs:features audit` to compare extracted features against what's documented in README. Over-documented features (claimed but not found in code) are flagged. Remove them from README or add the missing implementation.

---

## Badge and Link Failures

### Shields.io badges not rendering

- Check the badge URL directly in a browser — shields.io returns SVGs, so a 404 or error SVG indicates a misconfigured URL
- Common causes: incorrect repo owner/name, wrong package name for npm/PyPI badges, expired tokens for private repos
- Run `/pitchdocs:docs-verify links` — it validates badge URLs alongside regular links

### Cross-renderer Markdown issues

Markdown that renders on GitHub may break on npm or PyPI:

| Feature | GitHub | npm | PyPI |
|---------|--------|-----|------|
| `<details>` / `<summary>` | Works | Works | Broken |
| `> [!NOTE]` callouts | Works | Broken | Broken |
| `<picture>` for dark mode | Works | Works | Broken |
| Relative image links | Works | Broken (needs absolute) | Broken (needs absolute) |
| HTML `align="center"` | Works | Works | Stripped |

**Solution:** Use bold inline callouts (`**Note:**`) instead of GitHub callout syntax. For npm/PyPI, use absolute image URLs pointing to your GitHub repo's raw content.

---

## llms.txt Sync Issues

`/pitchdocs:docs-verify` checks that every file referenced in `llms.txt` exists on disk. Common issues:

- **File renamed but llms.txt not updated** — Run `/pitchdocs:llms-txt` to regenerate
- **New file added but not listed** — Run `/pitchdocs:llms-txt` to pick up new docs
- **Orphaned entries** — Files listed in llms.txt that were deleted. Run `/pitchdocs:llms-txt` to regenerate a clean version

---

## Cross-Tool Limitations

Not all PitchDocs features work outside Claude Code:

| Feature | Claude Code | OpenCode | Codex CLI | Cursor / Others |
|---------|------------|----------|-----------|-----------------|
| Skills (14 SKILL.md files) | Native | Native | Copy to `.agents/skills/` | Reference on demand |
| Slash commands (12) | Native | Native | Copy to prompts | Not supported |
| Quality rules (auto-loaded) | Yes | No | No | Cursor: `.cursor/rules/` |
| Context Guard hooks | Yes (opt-in) | No | No | No |
| AGENTS.md context | Loaded | Primary context | Primary context | Not used |

If you're using a non-Claude tool and a command or workflow doesn't behave as expected, check the [Other AI Tools guide](other-ai-tools.md) for tool-specific setup instructions.

---

## Common Questions

### Can I run PitchDocs on a private repo?

Yes. PitchDocs works entirely locally — it reads your codebase via file system access. GitHub MCP integration (for milestones, releases, issues) requires `gh` CLI authentication but never exposes your code to external services.

### Does PitchDocs overwrite my existing README?

When a README.md already exists, PitchDocs reads it first and improves it rather than replacing from scratch. It preserves custom sections and content you've added manually.

### How do I use PitchDocs with a monorepo?

Point commands at specific packages: `/pitchdocs:readme packages/api` or `/pitchdocs:features packages/ui`. Each package can have its own documentation set.

### What if I disagree with PitchDocs' suggestions?

PitchDocs generates docs based on its quality standards, but the output is always editable. Run commands iteratively with specific focus areas to steer the output (see the [Customising Output guide](customising-output.md)).

---

**Need more help?** See [SUPPORT.md](../../SUPPORT.md) for contact details and response times.
