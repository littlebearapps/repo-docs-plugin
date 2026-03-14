# Documentation Standards

When generating public-facing repository documentation, follow these principles:

## The 4-Question Test (Banesullivan Framework)

Every document must answer these questions for the reader:

1. **Does this solve my problem?** — Clear problem statement and value proposition in the first paragraph
2. **Can I use it?** — Installation, prerequisites, and quickstart within 30 seconds of reading
3. **Who made it?** — Credibility signals: author, contributors, badges, community size
4. **Where do I learn more?** — Links to docs, examples, community, and support channels

## Progressive Disclosure (The Lobby Principle)

The README is the **lobby** of the repository — it gives visitors enough to decide whether they want to enter the building, but it should not contain the entire building. Detailed content belongs in separate docs and guides, linked from the README.

- First paragraph: non-technical, benefit-focused, anyone can understand
- Second section: quick start for developers who want to try it NOW
- Deeper sections: technical details, API reference, architecture
- A familiar user should be able to refresh their memory without scrolling past the fold

**Lobby content (belongs in README):**
- Value proposition (2–3 paragraphs max)
- Quick start with 5–7 examples
- Top features (8 or fewer emoji+bold+em-dash bullets)
- Comparison table (top 3–4 competitors, top 5–8 distinguishing capabilities)
- Credibility signals (badges, security, social proof)
- Links to docs, contributing, and licence

**Building content (delegate to `docs/guides/` or separate files):**
- Per-tool or per-platform setup instructions
- Exhaustive feature inventories or API surface docs
- Multi-step tutorials longer than 5–7 lines
- Configuration reference tables
- Architecture deep-dives
- Upstream specification details

**The delegation test:** If a README section exceeds 2 paragraphs of prose or a table exceeds 8 rows, it likely belongs in a dedicated guide linked from the README with a 2–3 line summary.

## Time to Hello World

Target a measurable Time to Hello World (TTHW) in every quick start section. State it explicitly where evidence supports it (e.g. "Get your first README in under 60 seconds"). Concrete before abstract, one concept per step, all commands copy-paste-ready. The `public-readme` skill's `SKILL-reference.md` has TTHW target tables by project type.

## Tone & Language

- Consistent language — follow the project's existing locale and spelling conventions
- Professional-yet-approachable — confident, not corporate
- Benefit-driven: describe what users GAIN, not just what the software DOES
- "You can now..." not "We implemented..." — reader-centric framing
- Active voice. Short sentences. No jargon without explanation.

**Banned phrases:** Avoid these AI-detectable patterns entirely — "in today's digital landscape", "it's important to note", "dive into" / "deep dive", "leverage", "game-changer", "cutting-edge" / "state-of-the-art", "seamless" / "seamlessly", "robust", "in conclusion" / "to summarise", "furthermore" / "moreover", "revolutionise", "utilise", "comprehensive", "navigate the complexities", "elevate your". No "simple", "easy", or "powerful" without evidence — show simplicity through short examples, show power through benchmarks.

## Feature-to-Benefit Writing

Pattern: `[Technical feature] so you can [user outcome] — [evidence]`. Every feature needs evidence (file path, function, config option). Use at least 3 of the 5 benefit categories (time saved, confidence gained, pain avoided, capability unlocked, cost reduced). No "simple", "easy", or "powerful" without evidence — show simplicity through short examples, show power through benchmarks. Load the `feature-benefits` skill for the full framework, user benefits, signal gate, and formatting options.

## Marketing Principles for Technical Docs

Hero section: logo + one-liner + badges. Every doc ends with a clear next step. Load `public-readme` for hero structure and badge guidance; `platform-profiles` for platform-specific URLs.

## File Naming

- `README.md` — Always uppercase
- `CHANGELOG.md` — Always uppercase
- `ROADMAP.md` — Always uppercase
- `CONTRIBUTING.md` — Always uppercase
- `CODE_OF_CONDUCT.md` — Always uppercase with underscores
- `SECURITY.md` — Always uppercase
- `.github/ISSUE_TEMPLATE/` — GitHub convention
- `.github/PULL_REQUEST_TEMPLATE.md` — GitHub convention

## Extended References

Load on-demand: `visual-standards` (emoji, screenshots), `geo-optimisation` (AI citation), `skill-authoring` (token budgets).
