# Documentation Awareness

When working on a project with PitchDocs installed, recognise documentation-relevant moments and suggest the appropriate command. This is advisory — never block work, just surface the right tool at the right time.

## Documentation Trigger Map

| You Notice | Suggest | Why |
|-----------|---------|-----|
| New feature added (new exports, commands, routes, API endpoints) | `/pitchdocs:features audit` then `/pitchdocs:readme` | README features section may be out of date |
| Workflow or CLI args changed | `/pitchdocs:user-guide` to refresh guides | User guides may reference old behaviour |
| Version bump or new git tag | `/pitchdocs:doc-refresh` | Changelog, README metrics, and guides need updating |
| Release prep or changelog discussion | `/pitchdocs:changelog` then `/pitchdocs:launch` | Ship release notes and promotion content together |
| Merging a release-please PR | Remind: run activation evals first (`Actions → Activation Evals → Run workflow`) | Confirm skill activation hasn't regressed (target 80%+) |
| Project going public (no README or thin README) | `/pitchdocs:readme` | First impressions — generate the full marketing framework |
| Missing docs detected (no `docs/guides/`, no llms.txt) | `/pitchdocs:docs-audit` | Identify all documentation gaps at once |
| User asks "why should someone use this?" or discusses positioning | `/pitchdocs:features benefits` | Surface the two-path user benefits extraction (auto-scan or conversational) |
| README section growing beyond 2 paragraphs or 8-row table | Suggest delegating to `docs/guides/` | Lobby Principle — keep README scannable |
| User mentions "talk it out" or wants to explain their project's value | `/pitchdocs:features benefits` (conversational path) | The 4-question interview produces the most authentic user benefits |
| User asks "are my docs up to date?" or similar | Launch the `docs-freshness` agent | Quick triage with specific command suggestions |
| Session start in a project with PitchDocs activated | Launch the `docs-freshness` agent | Quick freshness check before diving into work |

## When NOT to Suggest

- During debugging, testing, or CI troubleshooting — stay focused on the immediate problem
- When the user is mid-flow on a complex coding task — wait for a natural pause
- When the same suggestion was already made this session — don't repeat
- For trivial code changes (typos, formatting) that don't affect documentation
