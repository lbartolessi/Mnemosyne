#!/bin/bash

# ============================================================
#   MNEMOSYNE — Update session date
#   Writes today's date to mnemosyne/current-date.txt so the AI
#   (Gemini, etc.) can read it instead of inventing or asking.
#   Run on workspace open via VS Code task (runOn: folderOpen).
# ============================================================

PROJECT_DIR="${1:-.}"
PROJECT_DIR="$(cd "$PROJECT_DIR" 2>/dev/null && pwd)" || exit 0

for dir in "mnemosyne" ".mnemosyne"; do
  MNEMOSYNE_PATH="$PROJECT_DIR/$dir"
  if [ -d "$MNEMOSYNE_PATH" ]; then
    date +%Y-%m-%d > "$MNEMOSYNE_PATH/current-date.txt"
    exit 0
  fi
done

# No mnemosyne dir found — silent exit (project may not use Mnemosyne)
exit 0
