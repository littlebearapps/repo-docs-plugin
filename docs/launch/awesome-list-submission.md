# Awesome List Submission Template

## Step 1: Find Relevant Awesome Lists

PitchDocs fits into several categories. Search for these awesome lists:

```bash
# Search GitHub for relevant awesome lists (requires GitHub CLI: gh)
gh search repos "awesome-documentation" --sort stars --limit 10
gh search repos "awesome-ai" --sort stars --limit 5
gh search repos "awesome-devtools" --sort stars --limit 5
gh search repos "awesome-plugins" --sort stars --limit 5
gh search repos "awesome-markdown" --sort stars --limit 5
```

**Top targets:**

1. **awesome-documentation** — Documentation generators, tools, frameworks
2. **awesome-ai** — AI-powered developer tools
3. **awesome-devtools** — Development tools and utilities
4. **awesome-plugins** — Plugin ecosystems for editors and IDEs
5. **awesome-markdown** — Markdown tools and generators

---

## Step 2: Check Contribution Guidelines

Before submitting, read:
- `CONTRIBUTING.md` (most awesome lists have this)
- `README.md` — Check the entry format and category structure
- `PULL_REQUEST_TEMPLATE.md` — Follow their PR template if it exists

**Common requirements:**
- Project must be maintained (commits in last 6 months)
- Project must have documentation
- Project must have >100 stars (varies by list)
- Description must be 1 line, under ~80 characters
- Links must be HTTPS only

---

## Step 3: Prepare Your PR

### awesome-documentation

**Category:** "Documentation Generators" or "Static Site Generators"

**Entry format:**
```markdown
- [PitchDocs](https://github.com/littlebearapps/pitchdocs) - Generate professional repository documentation (README, CHANGELOG, ROADMAP, user guides) from your codebase using AI coding assistants. Works with Claude Code, OpenCode, and 7+ other tools.
```

**PR title:**
```
Add PitchDocs – AI-powered documentation generator
```

**PR body:**
```markdown
## Add PitchDocs

**Description:** PitchDocs is an AI-powered documentation generator that creates professional repository docs (README, CHANGELOG, ROADMAP, user guides) from your codebase.

**Link:** https://github.com/littlebearapps/pitchdocs

**Why it belongs:** PitchDocs solves a key documentation problem — most open source projects ship with generic docs. It's used by Untether, Outlook Assistant, and other active projects. Actively maintained (latest release v1.19.3), comprehensive docs, 100+ GitHub stars.

**Checklist:**
- [x] Checked contribution guidelines
- [x] Project is actively maintained (commits within 6 months)
- [x] Project has documentation (README, guides, troubleshooting)
- [x] Description is concise and follows the list's style
- [x] HTTPS links only
```

---

### awesome-ai (or awesome-ai-tools)

**Category:** "Developer Tools" or "Code Assistants"

**Entry format:**
```markdown
- [PitchDocs](https://github.com/littlebearapps/pitchdocs) - Claude Code and OpenCode plugin for evidence-based documentation generation. Scans codebases for 10+ signal categories and generates professional README, CHANGELOG, roadmaps, and user guides with quality scoring.
```

**PR title:**
```
Add PitchDocs – AI documentation generation for open source
```

**PR body:**
```markdown
## Add PitchDocs

**Description:** PitchDocs is an AI-powered documentation plugin that leverages Claude and other AI assistants to generate professional repository documentation automatically.

**Link:** https://github.com/littlebearapps/pitchdocs

**Why it belongs:** PitchDocs demonstrates applied AI for documentation — it uses structured codebase analysis (10 signal categories) and generative AI to solve a real developer pain point. Active development, strong community, production use in multiple projects.

**Checklist:**
- [x] Checked contribution guidelines
- [x] Project is actively maintained
- [x] Works with major AI tools (Claude Code, OpenCode, Cursor)
- [x] Solves a real problem (documentation bottleneck)
- [x] Has comprehensive documentation
```

---

### awesome-devtools (or awesome-developer-tools)

**Category:** "Documentation" or "Code Generation"

**Entry format:**
```markdown
- [PitchDocs](https://github.com/littlebearapps/pitchdocs) - Generate professional repository documentation with AI. Creates READMEs, CHANGELOGs, roadmaps, user guides, and more from codebase analysis. Multi-platform (GitHub, GitLab, Bitbucket), 9+ AI tool support.
```

**PR title:**
```
Add PitchDocs – Documentation generation from code analysis
```

**PR body:**
```markdown
## Add PitchDocs

**Description:** PitchDocs is a developer tool that automates repository documentation generation using AI-assisted codebase analysis.

**Link:** https://github.com/littlebearapps/pitchdocs

**Why it belongs:** Solves the documentation maintenance problem by automating doc generation from code. Supports multiple platforms and integrates with popular AI coding tools. Active project with proven use in real repositories.

**Checklist:**
- [x] Actively maintained
- [x] Solves a real developer problem
- [x] Well documented
- [x] Multi-platform support
- [x] Community contributions welcome
```

---

### awesome-plugins

**Category:** "IDE Plugins" or "Editor Extensions"

**Entry format:**
```markdown
- [PitchDocs](https://github.com/littlebearapps/pitchdocs) - Claude Code and OpenCode plugin for generating professional repository documentation (README, CHANGELOG, ROADMAP, user guides) from codebase analysis. Zero dependencies, portable to 7+ other AI tools.
```

**PR title:**
```
Add PitchDocs – Documentation generation plugin for Claude Code and OpenCode
```

**PR body:**
```markdown
## Add PitchDocs

**Description:** PitchDocs is a plugin for Claude Code and OpenCode that generates professional repository documentation using AI-assisted codebase analysis.

**Link:** https://github.com/littlebearapps/pitchdocs

**Why it belongs:** High-quality plugin that extends Claude Code and OpenCode with practical documentation generation. Pure Markdown implementation, zero runtime dependencies, portable to other tools. Active development and maintenance.

**Checklist:**
- [x] Checked contribution guidelines
- [x] Plugin is actively maintained
- [x] Works with Claude Code and OpenCode
- [x] Solves a real problem
- [x] Has excellent documentation
```

---

## Step 4: Post Your PR

1. **Fork the awesome list repository**
2. **Create a new branch:** `git checkout -b add-pitchdocs`
3. **Add the entry** to the appropriate section (alphabetical order is common)
4. **Commit:** `git commit -m "Add PitchDocs to documentation section"`
5. **Push:** `git push origin add-pitchdocs`
6. **Open a PR** — use the template above

---

## Expected Outcomes

- Most awesome lists take 2–7 days to review submissions
- Expect 1–2 feedback rounds (e.g., "make the description shorter", "add a link to docs")
- Once merged, your project gains visibility in GitHub searches for that category
- Each awesome list PR gets ~50–200 additional GitHub stars over 3–6 months

---

## Anti-Patterns to Avoid

- ❌ Don't submit to 10+ awesome lists at once — looks like spam
- ❌ Don't use marketing language ("revolutionary", "state-of-the-art") — awesome lists prefer neutral, descriptive language
- ❌ Don't submit before your project has documentation — list maintainers check
- ❌ Don't submit to lists outside your category — stay focused
- ❌ Don't argue with reviewers — they're volunteers. Take feedback gracefully.

---

## Timing

- **Space submissions 3–7 days apart** — one per week is sustainable
- **Start with the most relevant lists** — awesome-documentation and awesome-ai
- **Follow up on PRs after 7 days** if no response — gentle reminder, not demanding
