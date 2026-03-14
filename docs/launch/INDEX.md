# Launch Artifacts for PitchDocs

Generated platform-specific launch and promotion content from README and CHANGELOG.

> **Status:** All artifacts generated and ready for review before publishing.

---

## 📋 Artifacts

| File | Platform | Purpose | Status |
|------|----------|---------|--------|
| **devto-article.md** | Dev.to | Long-form narrative article with code examples | ✅ Ready |
| **hackernews-post.md** | Hacker News | "Show HN" title + first comment with technical focus | ✅ Ready |
| **reddit-posts.md** | Reddit | Three subreddit variants (r/programming, r/webdev, r/opensource) | ✅ Ready |
| **twitter-thread.md** | Twitter/X | 5-tweet thread (hook → problem → features → proof → CTA) | ✅ Ready |
| **awesome-list-submissions.md** | Awesome Lists | 6 relevant lists with PR templates and submission strategy | ✅ Ready |
| **social-preview-guide.md** | GitHub | 1280×640 social preview image specs and design guidance | ✅ Ready |

---

## 🚀 Publishing Timeline

### Phase 1: Internal Review (Before Publishing)
- [ ] Review Dev.to article — check tone, examples, CTAs
- [ ] Review HN post — verify title is under 80 chars, content is technical
- [ ] Review Reddit posts — check each subreddit's submission rules
- [ ] Review Twitter thread — confirm all tweets are under 280 chars
- [ ] Design social preview image — 1280×640 PNG, <300 KB
- [ ] Upload social preview to GitHub Settings

### Phase 2: Launch (Staggered)
- [ ] **Day 1 (Tue–Thu, 9–11 AM US Eastern):** Post on HN (target window)
- [ ] **Day 2:** Post on r/programming + r/webdev (space by 24 hours)
- [ ] **Day 3:** Post on r/opensource
- [ ] **Day 3:** Launch Twitter thread
- [ ] **Day 4–7:** Submit to awesome lists (3 at a time, space by 48 hours)
- [ ] **Ongoing:** Engage in comments on all platforms for first 48 hours

### Phase 3: Follow-Up
- [ ] Pin HN post if it trends (50+ upvotes in first 2 hours)
- [ ] Share HN results on Twitter
- [ ] Track awesome list PR status
- [ ] Update docs with metrics (stars, discussion, feedback)

---

## 📊 Content Summary

### Dev.to Article
- **Length:** ~2500 words
- **Tone:** Narrative, reader-centric, problem-first
- **CTA:** "Try It Out" section with install command
- **Published:** `published: false` (draft mode) — set to `true` before publishing

### Hacker News Post
- **Title:** 73 characters (under 80 limit)
- **First comment:** Technical depth, 10 signal categories explained, tech stack, 3 key features
- **Format:** Title + URL + first comment (posted as immediate reply)
- **Timing:** Tue–Thu, 9–11 AM US Eastern (14:00–16:00 UTC)

### Reddit Posts
- **r/programming:** Technical angle, link to GitHub repo, focus on feature extraction
- **r/webdev:** Practical angle, emphasis on DX and time savings
- **r/opensource:** Community angle, contribution opportunities, ROADMAP link

### Twitter Thread
- **Format:** 5 tweets (hook, problem, features with screenshot, proof/social, CTA)
- **Total characters:** All under 280 each
- **Image needed:** Screenshot of `/pitchdocs:readme` output in Tweet 3
- **Hashtags:** Use in replies only (#OpenSource, #DevTools, #AI, #Documentation, #GitHub)

### Awesome List Submissions
- **Lists:** 6 curated (ai-code-assistants, github-tools, documentation, open-source, readme, devtools)
- **Strategy:** Submit 1 every 2–3 days to avoid spam
- **Checklist:** Read each list's CONTRIBUTING guide, adapt entry format, be prepared for feedback

### Social Preview
- **Size:** 1280 × 640 pixels (2:1 ratio)
- **Design:** Typography-focused with PitchDocs logo/icon
- **Upload:** GitHub Settings > Social preview (manual)
- **Testing:** Share on Twitter, LinkedIn, Slack, Discord after uploading

---

## 🎯 Key Messaging

**Headline:** "Turn any codebase into professional, marketing-ready documentation with AI"

**Problem:** Your code is ready for the world, but your docs aren't.

**Solution:** PitchDocs auto-generates the entire docs suite (README, CHANGELOG, guides, policies) in 60 seconds.

**Evidence:** Every feature claim traces to code. Professional standards (4-question test, Lobby Principle, GEO optimisation) built in.

**Proof:**
- 10 signal categories for feature extraction
- Quality scoring (0–100)
- Works with 9 AI tools
- GitHub/GitLab/Bitbucket support
- MIT licensed, actively maintained

---

## ⚠️ Pre-Publishing Checklist

- [ ] **Version current:** All artifacts reference v2.1.0 or latest
- [ ] **Links verified:** GitHub repo, docs, ROADMAP, Getting Started guide all live
- [ ] **Social preview designed:** 1280×640 PNG, uploaded to repo Settings
- [ ] **Code examples accurate:** Quick start commands match README
- [ ] **Tone consistent:** All platforms use benefit-driven language, not feature dump
- [ ] **No claims without evidence:** Every feature mentioned links to code or README
- [ ] **Timeline set:** Days/times for each platform post scheduled
- [ ] **Engagement plan:** Will respond to comments within 2 hours of posting

---

## 📈 Success Metrics

### Dev.to
- Target: 100+ views in first week
- Success: Appears in dev.to trending (top 500)

### Hacker News
- Target: 50+ upvotes within 24 hours
- Success: Front page, active discussion

### Reddit
- Target: 100+ upvotes per post
- Success: Hits subreddit top 10 of the day

### Twitter
- Target: 500+ impressions, 20+ likes
- Success: 5+ retweets, conversation starts

### Awesome Lists
- Target: 3+ accepted PRs
- Success: Listed in 5+ relevant awesome lists

---

## 📝 Notes

- **Keep artifacts in `docs/launch/`** — not committed by default (review before committing)
- **Update after each major release** — artifacts should reflect current version
- **Test links before posting** — verify all GitHub/docs URLs are live
- **Engage authentically** — respond to comments, answer questions, accept feedback
- **Don't spam platforms** — space posts across 3–5 days, one per platform per day
- **Measure results** — track stars, discussion, feedback after launch

Generated: 2026-03-14 | PitchDocs v2.1.0
