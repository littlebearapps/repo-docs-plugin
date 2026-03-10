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

**Result: 9 advisory warnings (pre-existing)**

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

## Phase 2: Skill Activation Testing (Pending)

**Status**: Not yet run. Requires `claude -p` invocations against `tests/evaluations.json` (20 test cases). Each run costs API tokens.

**Approach**: Use skill-creator plugin for structured evals with blind A/B comparison.

---

## Phase 3: Output Quality Evaluation (Pending)

**Status**: Not yet run. Requires generating docs for test repos with and without PitchDocs, then blind comparison.

---

## Issues Found

### ISSUE-1: Auto-loaded rules exceed aggregate token budget

**Severity**: Medium (affects all sessions, not just doc sessions)
**Details**: 3 auto-loaded rules total ~2,613 tokens, exceeding the recommended ~1,500 aggregate budget by 74%.
**Recommendation**: Split doc-standards.md into an auto-loaded summary (~300 tokens) and an on-demand skill for the full reference.

### ISSUE-2: 6 skills exceed individual token budgets

**Severity**: Low (on-demand only, loaded when needed)
**Details**: user-guides, docs-verify, pitchdocs-suite, package-registry, doc-refresh, and launch-artifacts all exceed the ~2,000 token skill budget.
**Recommendation**: Review for content that can be delegated to companion files (SKILL-*.md) or trimmed.

---

## Test Scripts Added

| Script | Purpose | CI-ready |
|--------|---------|----------|
| `tests/test-hook-content-filter.sh` | 25 unit tests for content-filter-guard.sh | Yes |
| `tests/check-banned-phrases.sh` | Scans any file for banned AI phrases | Yes |
