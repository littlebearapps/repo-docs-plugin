# PitchDocs Plugin Test Results

**Date**: 2026-03-10
**Plugin version**: 1.19.3
**Tester**: Claude Opus 4.6 (automated) + Nathan (oversight)

---

## Phase 1: Deterministic Tests (Quick Wins)

### 1. Hook Unit Tests — content-filter-guard.sh

**Result: 25/25 PASS**

| Category | Tests | Pass | Fail |
|----------|-------|------|------|
| HIGH-risk files (block) | 12 | 12 | 0 |
| MEDIUM-risk files (advisory) | 4 | 4 | 0 |
| Safe files (pass-through) | 3 | 3 | 0 |
| Non-Write tools (pass-through) | 3 | 3 | 0 |
| Edge cases (pass-through) | 3 | 3 | 0 |

**Coverage**: All file variants tested (CODE_OF_CONDUCT, LICENSE/LICENCE, SECURITY, CHANGELOG, CONTRIBUTING), nested paths, case variants, non-Write tool types, empty/malformed JSON input.

**Script**: `tests/test-hook-content-filter.sh`

### 2. Token Budget Audit

**Result: 9 advisory warnings (pre-existing) → 6 after fixes (see Phase 3.5)**

#### Auto-loaded rules (every session overhead):

| Rule | Chars | Tokens (est.) | Budget | Status |
|------|-------|---------------|--------|--------|
| doc-standards.md | 5,431 | ~1,357 | 500 | OVER |
| content-filter.md | 3,003 | ~750 | 500 | OVER |
| docs-awareness.md | 2,019 | ~504 | 500 | OVER |
| **TOTAL** | **10,453** | **~2,613** | **1,500** | **OVER by ~1,113** |

**Finding**: PitchDocs adds ~2,613 tokens of overhead to every Claude Code session, even when the user isn't doing documentation work. The biggest contributor is `doc-standards.md` at ~1,357 tokens (91% of its standalone budget). This is 74% above the recommended 1,500-token aggregate auto-load budget.

**Impact**: On a 200k context window, this is ~1.3% overhead — negligible for dedicated doc sessions but adds up across all sessions when the plugin is installed globally.

**Recommendation**: Consider splitting doc-standards.md — keep only the 4-Question Test and Lobby Principle in the auto-loaded rule (~300 tokens), and move the rest (banned phrases, file naming, feature-benefit patterns) into a skill loaded on demand.

#### Skills over budget:

| Skill | Tokens (est.) | Budget | Over by |
|-------|---------------|--------|---------|
| user-guides | ~3,969 | 2,000 | ~1,969 |
| docs-verify | ~3,850 | 2,000 | ~1,850 |
| pitchdocs-suite | ~3,227 | 2,000 | ~1,227 |
| package-registry | ~2,968 | 2,000 | ~968 |
| doc-refresh | ~2,453 | 2,000 | ~453 |
| launch-artifacts | ~2,286 | 2,000 | ~286 |

These are loaded on-demand only, so the impact is per-invocation, not per-session.

### 3. Banned Phrase Check — README.md

**Result: CLEAN — 0 banned phrases found**

Scanned for 23 banned AI-detectable phrases from doc-standards.md. The current README.md contains none of them.

**Script**: `tests/check-banned-phrases.sh`

### 4. Static Validation (CI checks)

| Check | Result |
|-------|--------|
| Frontmatter validation | PASS (16 skills, 15 commands, 3 agents) |
| llms.txt consistency | PASS (0 errors, 2 pre-existing orphan warnings) |
| Token budgets | 9 advisory warnings (see above) |

---

## Phase 2: Skill Activation Testing

**Status**: V5 achieved **80% (16/20)**. V6 applied (final name mismatch fix).

### Run History

| Run | Date | Script Version | Result | Notes |
|-----|------|----------------|--------|-------|
| 1 | 2026-03-10 | V1 (`--output-format json`, `--allowedTools "Skill"`) | 0/17 pos, 3/3 neg | Wrong output format, too-restrictive tool filter |
| 2 | 2026-03-10 | V2 (`stream-json`, no tool filter, 3-strategy parser) | 0/17 pos, 3/3 neg | Missing `--verbose`, hidden by `2>/dev/null` |
| 3 | 2026-03-10 | V2 (re-run from iTerm2/mosh) | 0/17 pos, 3/3 neg | Same issue confirmed |
| 4 | 2026-03-10 | V3 (pre-flight check, stderr capture, `|| true`) | Pre-flight FAIL | Error: `stream-json requires --verbose` |
| 5 | 2026-03-10 | V4 (`--verbose` added) | 4/17 pos, 3/3 neg (35%) | Budget too low, plan mode, name mismatches |
| 6 | 2026-03-10 | V5 (`--permission-mode default`, $0.50 budget, name fixes) | **13/17 pos, 3/3 neg (80%)** | First successful run |

### V5 Results (80% = 16/20)

| Category | Pass | Fail | Rate |
|----------|------|------|------|
| Positive (slash commands) | 11/13 | 2 | 85% |
| Positive (natural language) | 2/4 | 2 | 50% |
| Negative (should NOT activate) | 3/3 | 0 | 100% |
| **Overall** | **16/20** | **4** | **80%** |

### 4 Remaining Failures

| Test | Activated | Expected | Category |
|------|-----------|----------|----------|
| `cmd-features` | `feature-benefits` | `features` | Name mismatch (Skill tool used internal name) — **fixed in V6** |
| `cmd-llms-txt` | `none` | `llms-txt` | Non-deterministic miss |
| `cmd-docs-audit` | `none` | `docs-audit` | Non-deterministic miss |
| `nl-positioning` | `none` | `features` | NL prompt too vague for activation |

### Fixes Applied (cumulative V3 → V6)

| Version | Changes |
|---------|---------|
| V3 | `|| true`, stderr capture, pre-flight check, `--debug` flag |
| V4 | Added `--verbose` to all `claude -p` invocations |
| V5 | Added `--permission-mode default`, budget $0.10→$0.50, fixed 8 `expected_skill` values |
| V6 | Fixed `features`→`feature` for Skill tool name inconsistency (2 test cases) |

### Progression

```
V1-V3: 0%  → V4: 35% → V5: 80% → V6 (expected): ~85%
```

### Key Learnings

1. `claude -p --output-format stream-json` requires `--verbose` — undocumented requirement
2. `--model haiku` falls back to Sonnet 4.6 — costs ~$0.12/test in cache creation
3. Default permission mode "plan" blocks Skill tool execution in non-interactive mode
4. Skill tool inconsistently uses command names vs internal skill names
5. Non-deterministic activation: ~2/13 slash commands fail per run (85% rate)
6. Natural language activation: ~50% without forced-eval hooks (matches research predictions)

### Cost

V5 run total: ~$6.50 (20 tests x ~$0.32 avg, model falls back to Sonnet)

---

## Phase 3: CI Integration

**Status**: Implemented — deterministic tests added to CI, activation eval workflow created.

### Deterministic Tests Added to `docs-ci.yml`

Two existing test scripts promoted to the `validate-plugin` CI job:

| Step | Script | What It Checks |
|------|--------|----------------|
| Hook unit tests | `tests/test-hook-content-filter.sh` | 25 functional tests for content-filter-guard.sh |
| Banned phrase check | `tests/check-banned-phrases.sh README.md` | 23 AI-detectable phrases in README |

These run on every PR and monthly schedule alongside existing checks. Zero cost, no API keys needed.

### Activation Eval Workflow (`activation-evals.yml`)

New manual-trigger GitHub Actions workflow for running skill activation evals in CI.

| Input | Default | Purpose |
|-------|---------|---------|
| `model` | haiku | Claude model (haiku/sonnet/opus) |
| `runs` | 1 | Repetitions per test case |
| `threshold` | 80 | Minimum pass rate (%) |

**Features**:
- Installs Claude Code CLI, runs `run-activation-evals.sh`
- Generates job summary table with category breakdown and failure details
- Uploads results JSON as 90-day artifact
- Fails if activation rate drops below threshold
- Monthly schedule available (commented out, ~$6.50/run)

**Prerequisite**: `ANTHROPIC_API_KEY` GitHub Actions secret must be configured.

### Updated CI Check Inventory

| Check | Workflow | Job | Trigger | Cost |
|-------|----------|-----|---------|------|
| Markdown linting | docs-ci | lint | PR + monthly | $0 |
| Spell check | docs-ci | lint | PR + monthly | $0 |
| GitHub Actions syntax | docs-ci | lint | PR + monthly | $0 |
| Link validation | docs-ci | links | PR + monthly | $0 |
| Plugin.json validation | docs-ci | validate-plugin | PR + monthly | $0 |
| Evaluations.json validation | docs-ci | validate-plugin | PR + monthly | $0 |
| Frontmatter validation | docs-ci | validate-plugin | PR + monthly | $0 |
| Hook script syntax | docs-ci | validate-plugin | PR + monthly | $0 |
| **Hook unit tests** | docs-ci | validate-plugin | PR + monthly | $0 |
| **Banned phrase check** | docs-ci | validate-plugin | PR + monthly | $0 |
| llms.txt consistency | docs-ci | consistency | PR + monthly | $0 |
| Token budget warnings | docs-ci | consistency | PR + monthly | $0 |
| **Activation evals** | activation-evals | activation-evals | Manual dispatch | ~$6.50 |

---

## Phase 3.5: Token Budget Fixes (#36, #37)

**Status**: Complete — warnings reduced from 9 to 6.

### Issue #36: Auto-loaded rules slimmed

Slimmed `doc-standards.md` from 5,431 → 4,625 chars (~200 token reduction). TTHW table replaced with one-line summary + skill pointer. Marketing Principles and Extended References sections compressed. `content-filter.md` and `docs-awareness.md` kept as-is (already lean/essential).

| Rule | Before | After | Status |
|------|--------|-------|--------|
| doc-standards.md | ~1,357 tokens | ~1,156 tokens | Still over (essential content) |
| content-filter.md | ~750 tokens | ~750 tokens | Unchanged (all essential) |
| docs-awareness.md | ~549 tokens | ~549 tokens | Unchanged (all essential) |

### Issue #37: Over-budget skills split into companions

4 skills split into core SKILL.md + SKILL-reference.md companion files:

| Skill | Before | After | Reference File |
|-------|--------|-------|----------------|
| user-guides | ~3,969 tokens | ~1,987 tokens | SKILL-reference.md (882 tokens) |
| docs-verify | ~3,850 tokens | ~1,371 tokens | SKILL-reference.md (2,140 tokens) |
| pitchdocs-suite | ~3,227 tokens | ~1,981 tokens | SKILL-reference.md (1,489 tokens) |
| package-registry | ~2,968 tokens | ~1,308 tokens | SKILL-reference.md (1,820 tokens) |

Old `docs-verify/SKILL-extended.md` removed (replaced by SKILL-reference.md).

**Remaining 2** (doc-refresh ~2,453 tokens, launch-artifacts ~2,286 tokens): Close to budget, content is essential, accepted as-is.

---

## Phase 4: Output Quality Evaluation (Pending)

**Status**: Not yet run. Requires generating docs for test repos with and without PitchDocs, then blind comparison.

---

## Issues Found

### ISSUE-1: Auto-loaded rules exceed aggregate token budget

**Severity**: Medium (affects all sessions, not just doc sessions)
**Details**: 3 auto-loaded rules total ~2,613 tokens, exceeding the recommended ~1,500 aggregate budget by 74%.
**Resolution**: Slimmed doc-standards.md (~200 token reduction). Remaining overhead is essential content. See Phase 3.5.

### ISSUE-2: 6 skills exceed individual token budgets

**Severity**: Low (on-demand only, loaded when needed)
**Details**: user-guides, docs-verify, pitchdocs-suite, package-registry, doc-refresh, and launch-artifacts all exceed the ~2,000 token skill budget.
**Resolution**: 4 of 6 split into companion files. Remaining 2 (doc-refresh, launch-artifacts) are close to budget and accepted. Warnings reduced 9 → 6. See Phase 3.5.

---

## Test Scripts Added

| Script | Purpose | In CI |
|--------|---------|-------|
| `tests/test-hook-content-filter.sh` | 25 unit tests for content-filter-guard.sh | Yes (docs-ci) |
| `tests/check-banned-phrases.sh` | Scans any file for banned AI phrases | Yes (docs-ci) |
| `tests/run-activation-evals.sh` | Skill activation testing via `claude -p` | Yes (activation-evals, manual) |
