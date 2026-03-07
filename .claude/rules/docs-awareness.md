# Documentation Awareness

When working on a project with PitchDocs installed, recognise documentation-relevant moments and suggest the appropriate command. This is advisory — never block work, just surface the right tool at the right time.

## Documentation Trigger Map

| You Notice | Suggest | Why |
|-----------|---------|-----|
| New feature added (new exports, commands, routes, API endpoints) | `/pitchdocs:features audit` then `/pitchdocs:readme` | README features section may be out of date |
| Workflow or CLI args changed | `/pitchdocs:user-guide` to refresh guides | User guides may reference old behaviour |
| Version bump or new git tag | `/pitchdocs:doc-refresh` | Changelog, README metrics, and guides need updating |
| Release prep or changelog discussion | `/pitchdocs:changelog` then `/pitchdocs:launch` | Ship release notes and promotion content together |
| Project going public (no README or thin README) | `/pitchdocs:readme` | First impressions — generate the full marketing framework |
| Missing docs detected (no `docs/guides/`, no llms.txt) | `/pitchdocs:docs-audit` | Identify all documentation gaps at once |
| User asks "why should someone use this?" or discusses positioning | `/pitchdocs:features benefits` | Surface the two-path user benefits extraction (auto-scan or conversational) |
| Structural files changed (skills, commands, agents, rules, config) | `/pitchdocs:ai-context audit` | AI context files may reference stale paths or counts |
| New dependency or framework added | `/pitchdocs:ai-context` | Context files should reflect the current tech stack |
| README section growing beyond 2 paragraphs or 8-row table | Suggest delegating to `docs/guides/` | Lobby Principle — keep README scannable |
| MEMORY.md contains repeated project conventions or stable patterns | `/pitchdocs:ai-context claude` | Promote stable auto-memory insights to CLAUDE.md where the whole team benefits |
| User mentions "talk it out" or wants to explain their project's value | `/pitchdocs:features benefits` (conversational path) | The 4-question interview produces the most authentic user benefits |

## When NOT to Suggest

- During debugging, testing, or CI troubleshooting — stay focused on the immediate problem
- When the user is mid-flow on a complex coding task — wait for a natural pause
- When the same suggestion was already made this session — don't repeat
- For trivial code changes (typos, formatting) that don't affect documentation
