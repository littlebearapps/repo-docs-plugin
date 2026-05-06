---
name: launch-artifacts
description: Transforms README and CHANGELOG into platform-specific launch content — Dev.to articles, Hacker News posts, Reddit posts, Twitter/X threads, and awesome list submission PRs. Keeps promotion tethered to code artifacts, not generic marketing. Use when launching or announcing a project release.
version: "1.0.0"
---

# Launch Artifacts Generator

## Philosophy

Great documentation is useless if nobody finds it. This skill transforms existing PitchDocs-generated content (README, CHANGELOG, features) into platform-specific posts for launch and promotion.

**Scope boundary:** This skill generates content from existing code artifacts — it does not create generic marketing playbooks. Every artifact traces back to the README, CHANGELOG, or codebase features.

## Prerequisites

Before generating launch artifacts, ensure the project has:
- A PitchDocs-generated README with hero section and features
- A CHANGELOG with the release being announced (if applicable)
- Feature extraction completed via the `feature-benefits` skill

## Platform Templates

### Dev.to Article

Transform README + CHANGELOG into a Dev.to blog post. Dev.to uses Liquid tags for frontmatter.

```markdown
---
title: "[Project Name]: [Value proposition from README hero]"
published: false
description: "[README explanatory sentence, condensed to 100 chars]"
tags: [up to 4 relevant tags]
canonical_url: https://github.com/org/repo
---

[Opening hook — rewrite the README "Why" section as a narrative problem statement]

## The Problem

[Expand on the problem from the README's "Why" section — use reader-centric language]

## What [Project Name] Does

[Condense the README features into 3-5 key capabilities with code examples]

### [Feature 1]

[Brief explanation with code example from README quickstart]

\`\`\`typescript
// Copy the most compelling code example from the quickstart
\`\`\`

### [Feature 2]

[Another key feature with a practical example]

## Getting Started

\`\`\`bash
[Installation command from README]
\`\`\`

[Minimal usage example — keep it under 10 lines]

## What's Next

[Link to ROADMAP or upcoming features]

---

*[Project Name] is open source ([licence]) — [link to repo]. Contributions welcome!*
```

**Dev.to tag selection:**
- Use existing popular tags (check dev.to/tags)
- Maximum 4 tags per article
- Include language tag (`typescript`, `python`), category tag (`opensource`, `devtools`), and 1-2 topic tags

### Hacker News "Show HN" Post

Title + description optimised for Hacker News submission.

**Title format:**
```
Show HN: [Project Name] – [One-line value proposition from README hero]
```

**Rules:**
- Maximum 80 characters for the title
- No exclamation marks, no ALL CAPS, no emoji
- Lead with what it does, not what it is
- Include the key differentiator

**Description (first comment):**
```
Hi HN,

I built [Project Name] to solve [problem from README "Why" section].

[2-3 sentences on the technical approach — what makes this different from alternatives. Include a concrete metric or benchmark if available.]

[1 sentence on the tech stack — language, framework, key dependencies.]

Key features:
- [Feature 1 — from README features, condensed]
- [Feature 2]
- [Feature 3]

[Link to repo] | [Link to docs/demo if available]

Happy to answer questions about [the most technically interesting aspect].
```

**Timing guidance:**
- Best days: Tuesday–Thursday
- Best times: 9:00–11:00 AM US Eastern (14:00–16:00 UTC)
- Avoid weekends, US holidays, and major tech conference days
- Source: academic study of 138 repo launches showed +121 stars within 24 hours of HN exposure

### Reddit Post

Formatted for relevant subreddits. Each subreddit has different norms.

**r/programming** (technical audience, link post preferred):
```
Title: [Project Name]: [technical description, not marketing]
URL: https://github.com/org/repo
```

Add a first comment explaining the motivation:
```
Author here. I built this because [problem].

Technical highlights:
- [Technical detail 1]
- [Technical detail 2]

Built with [tech stack]. Feedback welcome, especially on [specific area].
```

**r/webdev** (web developer audience, self-post OK):
```
Title: I built [Project Name] to [solve problem] — open source
Body: [Condensed README with focus on practical usage and DX]
```

**r/opensource** (open source community):
```
Title: [Project Name] — [description] [language/framework]
Body: [Focus on contribution opportunities, roadmap, and community]
```

**Reddit rules:**
- Don't post to more than 2-3 subreddits for the same project
- Space posts across different subreddits by at least 24 hours
- Engage genuinely in comments — don't just post and leave
- Read each subreddit's rules before posting (some ban self-promotion)

### Twitter/X Thread

Convert README features into a 5-tweet thread.

```
Tweet 1 (hook):
🚀 Introducing [Project Name]

[One-line value proposition from README hero]

Thread 👇

---

Tweet 2 (problem):
The problem: [Problem from README "Why" section]

[1-2 sentences expanding on the pain point]

---

Tweet 3 (features):
What it does:

• [Feature 1] — [benefit]
• [Feature 2] — [benefit]
• [Feature 3] — [benefit]

---

Tweet 4 (proof):
[Concrete metric, benchmark, or social proof]

[Code snippet or screenshot if applicable]

---

Tweet 5 (CTA):
Try it now:

[install command]

GitHub: [repo URL]
Docs: [docs URL]

Star ⭐ if you find it useful — it helps others discover it too.
```

**Twitter/X rules:**
- 280 characters per tweet
- Use line breaks for readability
- Include a code snippet image or screenshot in tweet 3 or 4
- Thread should be self-contained — each tweet makes sense alone

### Awesome List Submission PR

Template for submitting the project to relevant awesome lists.

**Step 1: Find relevant awesome lists**

```bash
# Search GitHub for awesome lists in your category (GitHub CLI — for GitLab/Bitbucket, search manually)
gh search repos "awesome-[category]" --sort stars --limit 10
```

**Step 2: Check contribution guidelines**

Every awesome list has its own rules. Before submitting:
- Read the list's CONTRIBUTING.md or PULL_REQUEST_TEMPLATE.md
- Check the format of existing entries (description length, link style)
- Verify the project meets the list's quality criteria (stars, maintenance, docs)

**Step 3: PR body template**

```markdown
## Add [Project Name]

**Description:** [One-line description matching the list's existing entry format]

**Link:** https://github.com/org/repo

**Why it belongs:** [1-2 sentences on why this project fits the list's criteria]

**Checklist:**
- [ ] Read the contribution guidelines
- [ ] Project is actively maintained
- [ ] Project has documentation
- [ ] Entry format matches existing entries
```

**Awesome list entry format** (adapt to match the specific list):
```markdown
- [Project Name](https://github.com/org/repo) — One-line description matching the list's style.
```

### GitHub Discussions Announcement

For projects using GitHub Discussions (GitHub-only feature — GitLab and Bitbucket do not have an equivalent), template for a release announcement.

```markdown
Title: [Project Name] v[X.Y.Z] released — [headline feature]

## What's New

[Condense CHANGELOG entries into 3-5 user-facing highlights]

### [Highlight 1]

[1-2 sentences with a code example if applicable]

### [Highlight 2]

[1-2 sentences]

## Upgrade

\`\`\`bash
[upgrade command]
\`\`\`

[Link to migration guide if breaking changes]

## What's Next

[Link to ROADMAP or mention upcoming features]

---

Full changelog: [link to CHANGELOG.md or GitHub release]
```

## Social Preview Image Guidance

GitHub uses the repository's social preview image when links are shared on Twitter/X, Slack, Discord, and LinkedIn.

**Specifications:**
- **Size:** 1280 x 640 pixels (2:1 ratio)
- **File size:** Under 1MB, ideally <300KB
- **Format:** PNG or JPEG
- **Set via:** Repository Settings > Social preview (manual upload)

**Design recommendations:**
- Project name in large, readable text (survives thumbnail cropping)
- One-line value proposition below the name
- Key visual element — logo, icon, or illustrative graphic
- Keep critical content centred (platforms crop differently)
- Use project brand colours for recognition

**Tools for creation:**
- [Canva](https://canva.com/) — Templates for GitHub social cards
- [Figma](https://figma.com/) — Custom designs with precise dimensions
- [og-image generators](https://github.com/vercel/og-image) — Programmatic generation

## Anti-Patterns

- **Don't spam multiple platforms simultaneously** — space posts across 2-3 days
- **Don't use identical content across platforms** — adapt tone and format for each audience
- **Don't make claims not backed by the README** — every feature mentioned must trace to code evidence
- **Don't post and disappear** — engage with comments and questions on every platform
- **Don't buy stars or upvotes** — artificial engagement is detectable and erodes trust
- **Don't submit to awesome lists before your docs are ready** — list maintainers check quality
