#!/bin/bash
# check-banned-phrases.sh
# Scans a generated document for banned AI-detectable phrases from doc-standards.md.
# Usage: bash tests/check-banned-phrases.sh <file>
# Exit 0 = clean, Exit 1 = banned phrases found

set -euo pipefail

FILE="${1:-README.md}"

if [ ! -f "$FILE" ]; then
  echo "Error: File '$FILE' not found"
  exit 2
fi

# Banned phrases from .claude/rules/doc-standards.md
BANNED_PHRASES=(
  "in today's digital landscape"
  "it's important to note"
  "dive into"
  "deep dive"
  "leverage"
  "game-changer"
  "cutting-edge"
  "state-of-the-art"
  "seamless"
  "seamlessly"
  "robust"
  "in conclusion"
  "to summarise"
  "to summarize"
  "furthermore"
  "moreover"
  "revolutionise"
  "revolutionize"
  "utilise"
  "utilize"
  "comprehensive"
  "navigate the complexities"
  "elevate your"
)

echo "=== Banned Phrase Check: $FILE ==="
echo ""

FOUND=0
for phrase in "${BANNED_PHRASES[@]}"; do
  count=$(grep -ci "$phrase" "$FILE" 2>/dev/null || true)
  if [ "$count" -gt 0 ]; then
    FOUND=$((FOUND + count))
    echo "  FOUND ($count): \"$phrase\""
    grep -ni "$phrase" "$FILE" 2>/dev/null | while read -r line; do
      echo "         $line"
    done
  fi
done

echo ""
if [ "$FOUND" -eq 0 ]; then
  echo "Result: CLEAN — no banned phrases found"
  exit 0
else
  echo "Result: FAIL — $FOUND banned phrase occurrence(s) found"
  exit 1
fi
