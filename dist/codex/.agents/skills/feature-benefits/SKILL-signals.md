# Feature-Benefits — Signal Categories & Patterns

Detailed scanning hints and pattern libraries split from SKILL.md to reduce token overhead. Load on demand when performing deep feature extraction on large codebases.

## Full Signal Category Scan Lists

### 2.1 CLI Commands
- `bin/` directory, `package.json#bin`, `[project.scripts]`
- `src/cli*`, `src/commands/`, `cmd/`
- **What to record**: command names, flags, subcommands

### 2.2 Public API
- `src/index.*`, `lib/index.*`, `exports` in manifest
- `src/api/`, `routes/`, `handlers/`
- TypeScript: `.d.ts` files, `export` statements
- Python: `__init__.py`, `__all__`
- **What to record**: exported functions/classes, parameter types, return types

### 2.3 Configuration
- Config files: `*.config.js`, `*.config.ts`, `.rc` files
- Schema files: JSON Schema, Zod schemas, Pydantic models
- Environment: `.env.example`, `wrangler.toml`
- **What to record**: config options, defaults, validation

### 2.4 Integrations
- Dependencies in manifest (group by purpose: HTTP, database, auth, etc.)
- MCP servers (`.mcp.json`), plugin systems
- Webhook handlers, event listeners
- **What to record**: what external systems it connects to

### 2.5 Performance
- Caching: Redis, Memcached, in-memory cache implementations
- Async/concurrent: worker threads, async patterns, queue systems
- Benchmarks: `bench/`, `benchmark/`, performance tests
- **What to record**: performance claims with evidence (benchmark results, cache strategies)

### 2.6 Security
- Auth: OAuth, JWT, API keys, session management
- Validation: input sanitisation, schema validation
- Encryption, CORS, CSP, rate limiting
- **What to record**: security features with implementation location

### 2.7 TypeScript / Developer Experience
- Type safety: strict mode, no `any`, generics
- Code generation, auto-completion support
- Error messages, debug utilities
- **What to record**: DX features that save developer time

### 2.8 Testing
- Test files: `*.test.*`, `*.spec.*`, `test/`, `tests/`
- Coverage config, CI test steps
- E2E tests, integration tests
- **What to record**: test coverage %, test types present

### 2.9 Middleware / Plugins / Extensibility
- Plugin system, middleware chain, hook system
- Extension points, event emitters
- **What to record**: extensibility mechanisms and what they enable

### 2.10 Documentation
- `docs/`, `examples/`, API docs generation
- JSDoc/docstrings coverage
- **What to record**: documentation completeness

## Common Patterns Library

Quick-reference scanning hints per ecosystem.

### Node.js / TypeScript
- `package.json#exports` → public API surface
- `tsconfig.json#strict` → type safety level
- `vitest.config.*` or `jest.config.*` → testing setup
- `src/index.ts` exports → main feature set
- `bin/` or `package.json#bin` → CLI tools

### Python
- `pyproject.toml#[project.scripts]` → CLI entry points
- `__init__.py#__all__` → public API
- `conftest.py` → testing infrastructure
- `alembic/` or `migrations/` → database layer
- `Dockerfile` + `gunicorn`/`uvicorn` → production-ready server

### Go
- `cmd/` directory → CLI tools
- `pkg/` or exported functions → public API
- `internal/` → private implementation (not features)
- `go.sum` size → dependency footprint
- `Makefile` targets → developer workflows

### Rust
- `Cargo.toml#[features]` → optional feature flags
- `src/lib.rs` public items → API surface
- `benches/` → performance evidence
- `examples/` → usage patterns
- `#[derive()]` usage → ergonomics

### Claude Code Plugin (Markdown)
- `commands/` → slash commands (user-facing features)
- `.claude/skills/` → reference knowledge (capabilities)
- `.claude/agents/` → autonomous workflows
- `.claude/rules/` → quality standards
- `hooks/` → automated checks

## JTBD Mapping Detail

For richer benefit writing, identify the job each feature is hired to do before translating to a benefit sentence.

For each extracted feature, frame the job:

```
When I am [situation/context],
I want [capability this feature provides],
so I can [desired outcome].
```

Classify each job:
- **Functional** — the practical task ("deploy to production", "generate a changelog")
- **Emotional** — how the user wants to feel ("confident my docs are complete")
- **Social** — how the user wants to be perceived ("my repo looks professional")

**When to apply:**

| Impact Tier | JTBD Depth | Rationale |
|-------------|-----------|-----------|
| **Hero** (1–3) | Recommended — all three job types | Hero features drive adoption; emotional and social jobs sharpen the "why switch?" narrative |
| **Core** (4–8) | Functional job only | Core features need clear practical framing but don't need emotional/social depth |
| **Supporting** (9+) | Skip | Supporting features are nice-to-haves — the 5 benefit categories suffice |

**Rules:**
- For projects with fewer than 5 features, skip JTBD — the 5 benefit categories suffice
- JTBD informs the benefit sentence — the final output still uses the `[Feature] so you can [outcome] — [evidence]` pattern

## Persona Inference Detail

Infer 1–2 target personas from code signals to ground benefit writing.

| Signal Source | What to Check | Persona Implications |
|---|---|---|
| Integration surface | Telegram/Slack/GitHub/mobile APIs | Remote/async users |
| Execution model | Daemon/queue/cron/webhook | Background/automation users |
| Entry points | CLI vs SDK vs web UI | Developer maturity/context |
| Deploy artifacts | Docker/K8s/serverless/VPS | Ops/platform users |
| Manifest keywords | description, topics, README intro | General audience signal |

Map to archetypes (1 primary, 1 secondary):
- **Solo builder** — speed, low setup, shipping fast
- **Team lead** — consistency, onboarding, standardisation
- **Platform/ops engineer** — reliability, automation, deployability
- **Power user / automator** — multi-tool, async, extensibility
- **Compliance-aware org** — auditability, security, traceability

**Rules:**
- Infer from code signals only — don't guess from the project name
- If signals are ambiguous, default to "Solo builder" (broadest useful persona)
- Record the persona alongside the feature inventory — it feeds into Step 4 benefit writing

## User Benefits — Path B Detail (Conversational)

The most compelling user benefits come from the developer's lived experience. This path uses interactive questions to surface authentic use cases.

**Prompt sequence** (for Claude Code, use `AskUserQuestion`; for other agents, present as numbered chat prompts):

1. "Why do YOU use [Project]? What made you build it?" — surfaces motivation and origin story
2. "What real-world scenarios does it enable? Where are you when you use it?" — surfaces contexts (on the train, walking the dog, between meetings)
3. "What would you lose if [Project] didn't exist? What's the alternative?" — surfaces differentiation and pain
4. "Who else would benefit from this, and why?" — surfaces audience expansion

After collecting answers, enrich with code evidence from the Path A scan. The developer's words become the primary material; code evidence validates and strengthens each claim.

## Translation Table by Signal Category

| Signal Category | Feature Pattern | Benefit Translation |
|-----------------|----------------|-------------------|
| CLI commands | "CLI with N subcommands" | "Do everything from your terminal — no context switching" |
| Public API | "N exported functions with types" | "Import what you need — fully typed, tree-shakeable" |
| Configuration | "N config options with defaults" | "Works out of the box — customise only what you need" |
| Integrations | "Connects to X, Y, Z" | "Fits into your existing stack — not a rewrite" |
| Performance | "Benchmarks at N ops/sec" | "Fast enough that you'll never wait for it" |
| Security | "Built-in auth + validation" | "Security built in — not bolted on" |
| TypeScript/DX | "Strict types, no `any`" | "Your editor knows the API — autocomplete everywhere" |
| Testing | "N% test coverage" | "Battle-tested — every edge case covered" |
| Middleware/Plugins | "Plugin system with N hooks" | "Extend it your way — no forking required" |
| Documentation | "Guides, examples, API docs" | "Answers without reading source code" |

## Mapping Benefits to Badges

When a benefit claim maps to a verifiable metric (test coverage, bundle size, download count), load the `package-registry` skill for badge templates that make the claim visible in the README hero. Badges turn prose claims into at-a-glance proof.
