#!/bin/bash
# Post-build audit hook: auto-runs bus-to-log + audit after build-schedule.sh succeeds
INPUT=$(cat)
COMMAND=$(echo "$INPUT" | jq -r '.tool_input.command // empty' 2>/dev/null)

# Only trigger after build-schedule.sh
if [[ "$COMMAND" == *"build-schedule.sh"* ]]; then
  STDOUT=$(echo "$INPUT" | jq -r '.tool_result.stdout // empty' 2>/dev/null)
  # Only if build succeeded (contains "Built:")
  if [[ "$STDOUT" == *"Built:"* ]]; then
    DATE=$(date +%Y-%m-%d)
    echo "Build succeeded. Run bus-to-log and audit for $DATE."
  fi
fi
exit 0
