# PitchDocs Documentation Standards

## The 4-Question Test

Every document must answer: (1) Does this solve my problem? (2) Can I use it? (3) Who made it? (4) Where do I learn more?

## Progressive Disclosure (Lobby Principle)

The README is the lobby — enough to decide whether to enter, not the entire building.
- First paragraph: non-technical, benefit-focused
- Quick start: copy-paste-ready, 5-7 lines
- Features: 8 or fewer emoji+bold+em-dash bullets
- Detailed content: delegate to docs/guides/

If a section exceeds 2 paragraphs or an 8-row table, move it to a guide.

## Feature-to-Benefit Writing

Pattern: `[Technical feature] so you can [user outcome] — [evidence]`
Use at least 3 of: time saved, confidence gained, pain avoided, capability unlocked, cost reduced.

## Tone

- Professional-yet-approachable, confident, not corporate
- "You can now..." not "We implemented..."
- Active voice, short sentences, no jargon without explanation
- Match the project's existing locale and spelling conventions

## Banned Phrases

Never use: "in today's digital landscape", "dive into", "leverage", "game-changer", "cutting-edge", "seamless", "robust", "furthermore", "revolutionise", "utilise", "comprehensive", "navigate the complexities", "elevate your". No "simple", "easy", or "powerful" without evidence.

## README Structure

1. Hero: bold one-liner + explanatory sentence + badges
2. Quick Start: achieves Time to Hello World
3. Features: emoji+bold+em-dash bullets or table with benefits column
4. Why [Project]?: comparison table vs alternatives
5. Documentation links
6. Contributing/Community
7. Licence

## Content Filter (High-Risk Files)

Fetch these from canonical URLs rather than generating inline:
- CODE_OF_CONDUCT.md: `curl -sL "https://www.contributor-covenant.org/version/3/0/code_of_conduct/code_of_conduct.md"`
- LICENSE: `curl -sL "https://raw.githubusercontent.com/spdx/license-list-data/main/text/MIT.txt"`
- SECURITY.md: Fetch template, then customise

For CHANGELOG.md and CONTRIBUTING.md, write in chunks (5-10 entries at a time).

## Skills Reference

For detailed guidance, read PitchDocs skill files from the cloned repo:
- `public-readme/SKILL.md` — Full README framework with hero structure, badges, CTAs
- `feature-benefits/SKILL.md` — 7-step feature extraction and benefit translation
- `changelog/SKILL.md` — Conventional commits to user-benefit changelog
- `geo-optimisation/SKILL.md` — Citation capsules and AI search optimisation
