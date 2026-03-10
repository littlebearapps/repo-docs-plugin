#!/bin/bash
# test-hook-content-filter.sh
# Unit tests for hooks/content-filter-guard.sh
# Exit 0 = all pass, Exit 1 = failures found

set -euo pipefail

HOOK="hooks/content-filter-guard.sh"
PASS=0
FAIL=0
TOTAL=0

run_test() {
  local desc="$1"
  local input="$2"
  local expect_exit="$3"
  local expect_grep="${4:-}"

  TOTAL=$((TOTAL + 1))
  local output exit_code
  output=$(echo "$input" | bash "$HOOK" 2>&1) || true
  exit_code=$(echo "$input" | bash "$HOOK" >/dev/null 2>&1; echo $?) || true

  local passed=true
  if [ "$exit_code" -ne "$expect_exit" ]; then
    passed=false
  fi
  if [ -n "$expect_grep" ] && ! echo "$output" | grep -q "$expect_grep"; then
    passed=false
  fi

  if $passed; then
    PASS=$((PASS + 1))
    echo "  PASS: $desc"
  else
    FAIL=$((FAIL + 1))
    echo "  FAIL: $desc (exit=$exit_code, expected=$expect_exit)"
    echo "        output: $(echo "$output" | head -1)"
  fi
}

echo "=== Hook Unit Tests: content-filter-guard.sh ==="
echo ""

echo "--- HIGH-risk files (should block, exit 1) ---"
run_test "CODE_OF_CONDUCT.md blocks" \
  '{"tool_name":"Write","tool_input":{"file_path":"CODE_OF_CONDUCT.md"}}' 1 "block"
run_test "CODE_OF_CONDUCT.MD blocks" \
  '{"tool_name":"Write","tool_input":{"file_path":"CODE_OF_CONDUCT.MD"}}' 1 "block"
run_test "LICENSE blocks" \
  '{"tool_name":"Write","tool_input":{"file_path":"LICENSE"}}' 1 "block"
run_test "LICENSE.md blocks" \
  '{"tool_name":"Write","tool_input":{"file_path":"LICENSE.md"}}' 1 "block"
run_test "LICENSE.txt blocks" \
  '{"tool_name":"Write","tool_input":{"file_path":"LICENSE.txt"}}' 1 "block"
run_test "LICENCE blocks (AU spelling)" \
  '{"tool_name":"Write","tool_input":{"file_path":"LICENCE"}}' 1 "block"
run_test "LICENCE.md blocks" \
  '{"tool_name":"Write","tool_input":{"file_path":"LICENCE.md"}}' 1 "block"
run_test "LICENCE.txt blocks" \
  '{"tool_name":"Write","tool_input":{"file_path":"LICENCE.txt"}}' 1 "block"
run_test "SECURITY.md blocks" \
  '{"tool_name":"Write","tool_input":{"file_path":"SECURITY.md"}}' 1 "block"
run_test "SECURITY.MD blocks" \
  '{"tool_name":"Write","tool_input":{"file_path":"SECURITY.MD"}}' 1 "block"
run_test "Nested path CODE_OF_CONDUCT" \
  '{"tool_name":"Write","tool_input":{"file_path":"/tmp/project/CODE_OF_CONDUCT.md"}}' 1 "block"
run_test "Nested path LICENSE" \
  '{"tool_name":"Write","tool_input":{"file_path":"src/LICENSE.md"}}' 1 "block"

echo ""
echo "--- MEDIUM-risk files (should allow with advisory, exit 0) ---"
run_test "CHANGELOG.md advisory" \
  '{"tool_name":"Write","tool_input":{"file_path":"CHANGELOG.md"}}' 0 "CONTENT FILTER ADVISORY"
run_test "CHANGELOG.MD advisory" \
  '{"tool_name":"Write","tool_input":{"file_path":"CHANGELOG.MD"}}' 0 "CONTENT FILTER ADVISORY"
run_test "CONTRIBUTING.md advisory" \
  '{"tool_name":"Write","tool_input":{"file_path":"CONTRIBUTING.md"}}' 0 "CONTENT FILTER ADVISORY"
run_test "CONTRIBUTING.MD advisory" \
  '{"tool_name":"Write","tool_input":{"file_path":"CONTRIBUTING.MD"}}' 0 "CONTENT FILTER ADVISORY"

echo ""
echo "--- Safe files (should pass through, exit 0) ---"
run_test "README.md passes" \
  '{"tool_name":"Write","tool_input":{"file_path":"README.md"}}' 0 "{}"
run_test "src/index.ts passes" \
  '{"tool_name":"Write","tool_input":{"file_path":"src/index.ts"}}' 0 "{}"
run_test "package.json passes" \
  '{"tool_name":"Write","tool_input":{"file_path":"package.json"}}' 0 "{}"

echo ""
echo "--- Non-Write tools (should pass through, exit 0) ---"
run_test "Read tool passes" \
  '{"tool_name":"Read","tool_input":{"file_path":"CODE_OF_CONDUCT.md"}}' 0 "{}"
run_test "Edit tool passes" \
  '{"tool_name":"Edit","tool_input":{"file_path":"CODE_OF_CONDUCT.md"}}' 0 "{}"
run_test "Bash tool passes" \
  '{"tool_name":"Bash","tool_input":{"command":"cat CODE_OF_CONDUCT.md"}}' 0 "{}"

echo ""
echo "--- Edge cases (should pass through, exit 0) ---"
run_test "Empty JSON" '{}' 0 "{}"
run_test "Missing file_path" '{"tool_name":"Write","tool_input":{}}' 0 "{}"
run_test "Missing tool_input" '{"tool_name":"Write"}' 0 "{}"

echo ""
echo "=== Results: $PASS/$TOTAL passed, $FAIL failed ==="
[ "$FAIL" -eq 0 ] && exit 0 || exit 1
