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
#   bash tests/run-activation-evals.sh --debug      # Show raw stdout/stderr for diagnosis
#
# Requirements:
#   - claude CLI installed and authenticated
#   - jq installed
#   - PitchDocs plugin installed (or run from PitchDocs project directory)
#
# Cost estimate: ~$0.10-0.50 per test case per run (model may fall back to Sonnet)
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
SAVE_RAW=false
DEBUG_MODE=false
MODEL="haiku"  # Use cheapest model for activation testing

# Parse arguments
while [[ $# -gt 0 ]]; do
  case $1 in
    --runs) RUNS="$2"; shift 2 ;;
    --dry-run) DRY_RUN=true; shift ;;
    --model) MODEL="$2"; shift 2 ;;
    --save-raw) SAVE_RAW=true; shift ;;
    --debug) DEBUG_MODE=true; SAVE_RAW=true; shift ;;
    *) echo "Unknown option: $1"; exit 1 ;;
  esac
done

# Validate dependencies
command -v claude >/dev/null 2>&1 || { echo "Error: claude CLI not found"; exit 1; }
command -v jq >/dev/null 2>&1 || { echo "Error: jq not found"; exit 1; }
[ -f "$EVALS_FILE" ] || { echo "Error: $EVALS_FILE not found"; exit 1; }

# Check for nested Claude Code session
if [ -n "${CLAUDECODE:-}" ]; then
  echo "Error: Cannot run inside a Claude Code session (nested sessions crash)."
  echo "Run this from a regular terminal: bash tests/run-activation-evals.sh"
  exit 1
fi

# Pre-flight check: verify claude -p produces output
echo "Pre-flight check: testing claude -p connectivity..."
PREFLIGHT_STDERR=$(mktemp)
PREFLIGHT=$(cd "$PROJECT_DIR" && claude -p "Say OK" \
  --output-format stream-json \
  --verbose \
  --model "$MODEL" \
  --permission-mode default \
  --no-session-persistence \
  2>"$PREFLIGHT_STDERR") || true
if [ -z "$PREFLIGHT" ]; then
  echo "Error: claude -p produces no stdout."
  if [ -s "$PREFLIGHT_STDERR" ]; then
    echo "stderr output:"
    head -5 "$PREFLIGHT_STDERR"
  fi
  rm -f "$PREFLIGHT_STDERR"
  echo ""
  echo "Possible causes:"
  echo "  - API key not configured (run: claude auth)"
  echo "  - Model '$MODEL' not available"
  echo "  - stream-json output may go to stderr (try: claude -p 'Say OK' --output-format stream-json 2>&1 | head -5)"
  exit 1
fi
PREFLIGHT_LINES=$(echo "$PREFLIGHT" | wc -l)
echo "Pre-flight OK: $PREFLIGHT_LINES lines of stream-json output"
rm -f "$PREFLIGHT_STDERR"
echo ""

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

    # Run claude -p with stream-json to capture tool use events
    # NOTE: Do NOT use --allowedTools "Skill" — it prevents Claude from loading
    # plugin context. Let Claude use all tools so skills can activate properly.
    # IMPORTANT: Use "|| true" (not "|| OUTPUT=''") to preserve captured stdout
    # on non-zero exit. Capture stderr to a log file for diagnostics.
    STDERR_LOG="$RESULTS_DIR/.stderr-last.log"
    OUTPUT=$(cd "$PROJECT_DIR" && claude -p "$INPUT" \
      --output-format stream-json \
      --verbose \
      --model "$MODEL" \
      --permission-mode default \
      --max-budget-usd 0.50 \
      --no-session-persistence \
      2>"$STDERR_LOG") || true

    # Show diagnostics when output is empty
    if [ -z "$OUTPUT" ] && [ -s "$STDERR_LOG" ]; then
      echo ""
      echo "    [stderr]: $(head -3 "$STDERR_LOG" | tr '\n' ' ')"
    fi

    # Debug mode: show raw output
    if $DEBUG_MODE; then
      echo ""
      echo "    [debug stdout bytes]: $(echo "$OUTPUT" | wc -c)"
      echo "    [debug stdout head]: $(echo "$OUTPUT" | head -c 300)"
      if [ -s "$STDERR_LOG" ]; then
        echo "    [debug stderr head]: $(head -1 "$STDERR_LOG" | head -c 200)"
      fi
    fi

    # Save raw output for debugging
    if $SAVE_RAW; then
      RAW_DIR="$RESULTS_DIR/raw-$TIMESTAMP"
      mkdir -p "$RAW_DIR"
      echo "$OUTPUT" > "$RAW_DIR/${ID}-run${run}.json"
      if [ -s "$STDERR_LOG" ]; then
        cp "$STDERR_LOG" "$RAW_DIR/${ID}-run${run}.stderr"
      fi
    fi

    # Extract which skill was activated (if any)
    # stream-json emits one JSON object per line. Skill invocations appear as
    # tool_use events with tool_name "Skill" or in the result content.
    # Try multiple parsing strategies:

    # Strategy 1: Look for Skill tool_use in stream events
    ACTIVATED_SKILL=$(echo "$OUTPUT" | \
      grep -i '"Skill"' | \
      grep -o '"skill"[[:space:]]*:[[:space:]]*"[^"]*"' | head -1 | \
      sed 's/.*"skill"[[:space:]]*:[[:space:]]*"//;s/"//' 2>/dev/null || echo "")

    # Strategy 2: Look for tool_name field containing "Skill"
    if [ -z "$ACTIVATED_SKILL" ]; then
      ACTIVATED_SKILL=$(echo "$OUTPUT" | \
        while IFS= read -r line; do
          tool_name=$(echo "$line" | jq -r '.tool_name // empty' 2>/dev/null)
          if [ "$tool_name" = "Skill" ]; then
            echo "$line" | jq -r '.tool_input.skill // empty' 2>/dev/null
            break
          fi
        done || echo "")
    fi

    # Strategy 3: Look for skill name in the content text (Claude may mention it)
    if [ -z "$ACTIVATED_SKILL" ]; then
      ACTIVATED_SKILL=$(echo "$OUTPUT" | \
        grep -o '"skill_name"[[:space:]]*:[[:space:]]*"[^"]*"' | head -1 | \
        sed 's/.*"skill_name"[[:space:]]*:[[:space:]]*"//;s/"//' 2>/dev/null || echo "")
    fi

    # Default to "none" if nothing found
    [ -z "$ACTIVATED_SKILL" ] && ACTIVATED_SKILL="none"

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
