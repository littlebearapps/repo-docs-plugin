---
description: "Generate platform-specific launch and promotion artifacts from README/CHANGELOG: $ARGUMENTS"
argument-hint: "[devto|hn|reddit|social|awesome] or no args for all"
allowed-tools:
  - Read
  - Glob
  - Grep
  - Bash
  - Write
  - Edit
  - mcp__github__search_repositories
---

# /launch

Transform your README and CHANGELOG into platform-specific posts for launching or announcing your project. Every artifact is derived from existing code and documentation — no generic marketing.

## Behaviour

1. Load the `launch-artifacts` skill for platform templates
2. Load the `feature-benefits` skill for feature extraction (if not already done)
3. If GitHub MCP tools are unavailable (GitLab/Bitbucket), search for awesome lists manually or via web search
4. Read README.md and CHANGELOG.md for source content
5. Generate the requested artifact(s) from the source content
6. Write artifacts to `docs/launch/` directory (not committed by default — review before posting)

## Arguments

- **No arguments**: Generate all applicable launch artifacts
- `devto`: Dev.to article only
- `hn`: Hacker News "Show HN" post only
- `reddit`: Reddit post templates only
- `social`: Social preview image guidance + Twitter/X thread
- `awesome`: Awesome list submission PR template (searches for relevant awesome lists)

## Output

Generated artifacts are written to `docs/launch/`:

```
docs/launch/
├── devto-article.md          # Dev.to article with frontmatter
├── hackernews-post.md         # HN title + first comment
├── reddit-post.md             # Reddit posts for relevant subreddits
├── twitter-thread.md          # 5-tweet thread
├── awesome-list-submission.md # PR template for awesome list submissions
└── social-preview-guide.md    # Social preview image specifications
```

```
📋 Launch Artifacts: [project-name]

  ✓ docs/launch/devto-article.md — 45 lines (review tags before publishing)
  ✓ docs/launch/hackernews-post.md — title: 72 chars (under 80 limit)
  ✓ docs/launch/reddit-post.md — 3 subreddit variants
  ✓ docs/launch/twitter-thread.md — 5 tweets (all under 280 chars)
  ✓ docs/launch/awesome-list-submission.md — 2 relevant lists found
  ✓ docs/launch/social-preview-guide.md — dimensions and design tips

Timing recommendation:
  Best HN posting window: Tue–Thu, 9–11 AM US Eastern
  Space Reddit posts across subreddits by 24+ hours
```
