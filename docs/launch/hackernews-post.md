# Hacker News "Show HN" Post

## Title

```
Show HN: PitchDocs – Generate professional docs from your codebase with AI
```

**Length:** 73 characters (under 80 limit)

---

## First Comment (Posted as top-level reply)

Hi HN,

I built PitchDocs to solve a problem every open source maintainer faces: writing good documentation is *hard*, and most projects ship with thin, generic docs that don't sell the project or help users get started.

PitchDocs is a Claude Code and OpenCode plugin that gives your AI assistant the skills to scan your codebase, extract what's valuable, and generate your entire documentation suite automatically. One command (`/pitchdocs:readme`) generates a professional marketing-ready README. One more command (`/pitchdocs:docs-audit fix`) generates all the supporting docs — CHANGELOG, ROADMAP, CONTRIBUTING, user guides, security policies, issue templates, and more.

The secret sauce is evidence-based feature extraction. Instead of generic bullet points, PitchDocs scans 10 signal categories (exports, CLI commands, API endpoints, configuration, integrations, errors, auth, security, performance, accessibility), infers target personas, and extracts user benefits backed by file paths. Every claim in the docs traces to code.

**Technical highlights:**

- Scans 10 signal categories for evidence-based feature extraction
- Applies proven documentation frameworks (4-question test, lobby principle, Time to Hello World targets)
- GEO optimised for AI citation (ChatGPT, Perplexity, Google AI will cite your project accurately)
- Quality scoring (0–100) across 5 dimensions: completeness, structure, freshness, link health, evidence
- Handles Claude Code's content filter automatically so you never hit HTTP 400 when generating sensitive docs

Built with Markdown skills (100% plugin, zero runtime dependencies). Works with Claude Code, OpenCode, Cursor, Codex CLI, Windsurf, Cline, Gemini CLI, Aider, and Goose.

**GitHub:** https://github.com/littlebearapps/pitchdocs
**Install:** `/plugin marketplace add littlebearapps/lba-plugins` then `/plugin install pitchdocs@lba-plugins`

Happy to answer questions about feature extraction patterns or documentation standards. Feedback on the quality scoring system especially welcome!

---

## Posting Tips

- **Best days:** Tuesday–Thursday
- **Best times:** 9:00–11:00 AM US Eastern (14:00–16:00 UTC)
- **Avoid:** Weekends, US holidays, major tech conference days
- **Expected:** 50–150 upvotes within 24 hours for a well-received HN post
- **Engagement:** Reply to every comment within the first 2 hours — early engagement boosts ranking
