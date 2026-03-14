#!/usr/bin/env bash
# Check token budgets for skill files.
# Uses character count as proxy (~4 chars per token for English Markdown).
# Flags files that exceed recommended token budgets.
set -euo pipefail

# Budget thresholds (in characters, ~4 chars/token)
# Reference skills: ~2000 tokens = ~8000 chars
# Workflow skills: ~1500 tokens = ~6000 chars
# Rules (auto-loaded): ~500 tokens = ~2000 chars
SKILL_BUDGET_CHARS=8000
RULE_BUDGET_CHARS=2000

warnings=0

echo "=== Token budget check (character proxy, ~4 chars/token) ==="

# Check skill files
echo ""
echo "--- Skills (budget: ~2000 tokens / ${SKILL_BUDGET_CHARS} chars) ---"
for f in .claude/skills/*/SKILL.md; do
  [ -f "$f" ] || continue
  chars=$(wc -c < "$f")
  tokens_approx=$((chars / 4))
  skill_name=$(basename "$(dirname "$f")")
  if [ "$chars" -gt "$SKILL_BUDGET_CHARS" ]; then
    echo "WARNING: $skill_name — ${chars} chars (~${tokens_approx} tokens) exceeds budget"
    warnings=$((warnings + 1))
  else
    echo "  OK: $skill_name — ${chars} chars (~${tokens_approx} tokens)"
  fi
done

# Check companion/reference files (higher budget: ~3000 tokens)
COMPANION_BUDGET_CHARS=12000
echo ""
echo "--- Companion files (budget: ~3000 tokens / ${COMPANION_BUDGET_CHARS} chars) ---"
for f in .claude/skills/*/SKILL-*.md; do
  [ -f "$f" ] || continue
  chars=$(wc -c < "$f")
  tokens_approx=$((chars / 4))
  filename=$(basename "$f")
  skill_name=$(basename "$(dirname "$f")")
  if [ "$chars" -gt "$COMPANION_BUDGET_CHARS" ]; then
    echo "WARNING: ${skill_name}/${filename} — ${chars} chars (~${tokens_approx} tokens) exceeds budget"
    warnings=$((warnings + 1))
  else
    echo "  OK: ${skill_name}/${filename} — ${chars} chars (~${tokens_approx} tokens)"
  fi
done

# Check rules (auto-loaded every session, so budget matters more)
echo ""
echo "--- Rules (budget: ~500 tokens / ${RULE_BUDGET_CHARS} chars) ---"
for f in .claude/rules/*.md; do
  [ -f "$f" ] || continue
  chars=$(wc -c < "$f")
  tokens_approx=$((chars / 4))
  rule_name=$(basename "$f" .md)
  if [ "$chars" -gt "$RULE_BUDGET_CHARS" ]; then
    echo "WARNING: $rule_name — ${chars} chars (~${tokens_approx} tokens) exceeds budget"
    warnings=$((warnings + 1))
  else
    echo "  OK: $rule_name — ${chars} chars (~${tokens_approx} tokens)"
  fi
done

# Check agents (if directory exists)
if [ -d ".claude/agents" ]; then
  AGENT_BUDGET_CHARS=10000
  echo ""
  echo "--- Agents (budget: ~2500 tokens / ${AGENT_BUDGET_CHARS} chars) ---"
  for f in .claude/agents/*.md; do
    [ -f "$f" ] || continue
    chars=$(wc -c < "$f")
    tokens_approx=$((chars / 4))
    agent_name=$(basename "$f" .md)
    if [ "$chars" -gt "$AGENT_BUDGET_CHARS" ]; then
      echo "WARNING: $agent_name — ${chars} chars (~${tokens_approx} tokens) exceeds budget"
      warnings=$((warnings + 1))
    else
      echo "  OK: $agent_name — ${chars} chars (~${tokens_approx} tokens)"
    fi
  done
fi

# Summary
echo ""
echo "=== Summary ==="
echo "Warnings: $warnings"

if [ "$warnings" -gt 0 ]; then
  echo "Some files exceed token budgets — review for content that could be split or trimmed"
fi

# Token budgets are advisory, not blocking
exit 0
