#!/bin/bash
# run-activation-evals.sh
# Skill activation testing for PitchDocs plugin.
# Runs each test case from evaluations.json through `claude -p` and checks
# whether the correct skill activates.
#
# Usage:
#   bash tests/run-activation-evals.sh              # Run all tests once
#   bash tests/run-activation-evals.sh --runs 3     # Run each test 3 times (statistical)
#   bash tests/run-activation-evals.sh --dry-run    # Show what would be tested
#
# Requirements:
#   - claude CLI installed and authenticated
#   - jq installed
#   - PitchDocs plugin installed (or run from PitchDocs project directory)
#
# Cost estimate: ~$0.01-0.03 per test case per run (Haiku model recommended)
#
# NOTE: Do NOT run this from inside a Claude Code session.
#       Run it from a regular terminal shell.

set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
PROJECT_DIR="$(cd "$SCRIPT_DIR/.." && pwd)"
EVALS_FILE="$SCRIPT_DIR/evaluations.json"
RESULTS_DIR="$SCRIPT_DIR/activation-results"
RUNS=1
DRY_RUN=false
MODEL="haiku"  # Use cheapest model for activation testing

# Parse arguments
while [[ $# -gt 0 ]]; do
  case $1 in
    --runs) RUNS="$2"; shift 2 ;;
    --dry-run) DRY_RUN=true; shift ;;
    --model) MODEL="$2"; shift 2 ;;
    *) echo "Unknown option: $1"; exit 1 ;;
  esac
done

# Validate dependencies
command -v claude >/dev/null 2>&1 || { echo "Error: claude CLI not found"; exit 1; }
command -v jq >/dev/null 2>&1 || { echo "Error: jq not found"; exit 1; }
[ -f "$EVALS_FILE" ] || { echo "Error: $EVALS_FILE not found"; exit 1; }

# Load test cases
TOTAL_CASES=$(jq length "$EVALS_FILE")
POSITIVE_CASES=$(jq '[.[] | select(.should_respond == true)] | length' "$EVALS_FILE")
NEGATIVE_CASES=$(jq '[.[] | select(.should_respond == false)] | length' "$EVALS_FILE")

echo "=== PitchDocs Skill Activation Test ==="
echo "Evaluations file: $EVALS_FILE"
echo "Test cases: $TOTAL_CASES ($POSITIVE_CASES positive, $NEGATIVE_CASES negative)"
echo "Runs per test: $RUNS"
echo "Model: $MODEL"
echo "Total invocations: $((TOTAL_CASES * RUNS))"
echo ""

if $DRY_RUN; then
  echo "--- Dry run: test cases ---"
  jq -r '.[] | "  [\(.id)] \(.input) → expected: \(.expected_skill // "none") (respond: \(.should_respond))"' "$EVALS_FILE"
  echo ""
  echo "Estimated cost: ~\$$(printf "%.2f" "$(echo "$TOTAL_CASES * $RUNS * 0.02" | bc)")"
  exit 0
fi

# Create results directory
mkdir -p "$RESULTS_DIR"
TIMESTAMP=$(date +%Y%m%d-%H%M%S)
RESULT_FILE="$RESULTS_DIR/run-$TIMESTAMP.json"

echo "Results will be saved to: $RESULT_FILE"
echo ""

# Initialise results array
echo "[]" > "$RESULT_FILE"

PASS=0
FAIL=0
SKIP=0

for run in $(seq 1 "$RUNS"); do
  [ "$RUNS" -gt 1 ] && echo "=== Run $run/$RUNS ==="

  for i in $(seq 0 $((TOTAL_CASES - 1))); do
    ID=$(jq -r ".[$i].id" "$EVALS_FILE")
    INPUT=$(jq -r ".[$i].input" "$EVALS_FILE")
    EXPECTED_SKILL=$(jq -r ".[$i].expected_skill // \"none\"" "$EVALS_FILE")
    SHOULD_RESPOND=$(jq -r ".[$i].should_respond" "$EVALS_FILE")
    DESC=$(jq -r ".[$i].description" "$EVALS_FILE")

    echo -n "  [$ID] $INPUT ... "

    # Run claude -p with constrained tools and budget
    # --allowedTools Skill limits it to only invoking skills (no file edits, no bash)
    # --max-budget-usd 0.05 caps cost per invocation
    OUTPUT=$(cd "$PROJECT_DIR" && claude -p "$INPUT" \
      --output-format json \
      --model "$MODEL" \
      --max-budget-usd 0.05 \
      --allowedTools "Skill" \
      --no-session-persistence \
      2>/dev/null) || OUTPUT="{}"

    # Extract which skill was activated (if any)
    # The JSON output contains tool_use blocks — look for Skill tool calls
    ACTIVATED_SKILL=$(echo "$OUTPUT" | jq -r '
      if type == "array" then
        [.[] | select(.type == "tool_use" and .name == "Skill") | .input.skill // empty] | first // "none"
      elif type == "object" then
        if .tool_use then .tool_use | select(.name == "Skill") | .input.skill // "none"
        else "none"
        end
      else "none"
      end
    ' 2>/dev/null || echo "parse_error")

    # Evaluate result
    if [ "$SHOULD_RESPOND" = "true" ]; then
      # Positive test: should activate the expected skill
      if echo "$ACTIVATED_SKILL" | grep -qi "$EXPECTED_SKILL"; then
        echo "PASS (activated: $ACTIVATED_SKILL)"
        PASS=$((PASS + 1))
        RESULT="pass"
      else
        echo "FAIL (expected: $EXPECTED_SKILL, got: $ACTIVATED_SKILL)"
        FAIL=$((FAIL + 1))
        RESULT="fail"
      fi
    else
      # Negative test: should NOT activate any PitchDocs skill
      if [ "$ACTIVATED_SKILL" = "none" ] || [ "$ACTIVATED_SKILL" = "parse_error" ]; then
        echo "PASS (correctly silent)"
        PASS=$((PASS + 1))
        RESULT="pass"
      else
        echo "FAIL (should be silent, but activated: $ACTIVATED_SKILL)"
        FAIL=$((FAIL + 1))
        RESULT="fail"
      fi
    fi

    # Append to results file
    jq --arg id "$ID" \
       --arg run "$run" \
       --arg input "$INPUT" \
       --arg expected "$EXPECTED_SKILL" \
       --arg activated "$ACTIVATED_SKILL" \
       --arg result "$RESULT" \
       --argjson should_respond "$SHOULD_RESPOND" \
       '. += [{
         id: $id,
         run: ($run | tonumber),
         input: $input,
         expected_skill: $expected,
         activated_skill: $activated,
         should_respond: $should_respond,
         result: $result
       }]' "$RESULT_FILE" > "${RESULT_FILE}.tmp" && mv "${RESULT_FILE}.tmp" "$RESULT_FILE"
  done
done

# Summary
TOTAL=$((PASS + FAIL))
RATE=$(echo "scale=1; $PASS * 100 / $TOTAL" | bc 2>/dev/null || echo "0")

echo ""
echo "=== Results ==="
echo "Total: $TOTAL tests ($RUNS run(s) x $TOTAL_CASES cases)"
echo "Pass:  $PASS ($RATE%)"
echo "Fail:  $FAIL"
echo ""
echo "Results saved to: $RESULT_FILE"

# Per-skill breakdown
echo ""
echo "--- Per-skill activation rates ---"
jq -r '
  group_by(.id) |
  map({
    id: .[0].id,
    expected: .[0].expected_skill,
    total: length,
    pass: [.[] | select(.result == "pass")] | length
  }) |
  .[] |
  "\(.id): \(.pass)/\(.total) (\(.pass * 100 / .total)%)"
' "$RESULT_FILE" 2>/dev/null || echo "(run with --runs > 1 for per-skill stats)"

[ "$FAIL" -eq 0 ] && exit 0 || exit 1
