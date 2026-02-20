#!/bin/bash

# ============================================================
#   MNEMOSYNE — Setup IDE instruction symlinks
#   Creates symlinks so Copilot and Gemini find Mnemosyne
#   behavior profiles in their expected locations:
#     - .github/copilot-instructions.md → Copilot
#     - GEMINI.md → Gemini
# ============================================================

set -e

PROJECT_DIR="${1:-.}"
PROJECT_DIR="$(cd "$PROJECT_DIR" && pwd)"
CONFIG_FILE="$PROJECT_DIR/mnemosyne/config.json"

if [ ! -f "$CONFIG_FILE" ]; then
  echo "❌ mnemosyne/config.json not found in: $PROJECT_DIR"
  echo "   Run this script from the root of a project with Mnemosyne, or:"
  echo "   $0 /path/to/project"
  exit 1
fi

# Resolve mnemosyne-global path from config.json ("extends" field)
# Supports: ~/mnemosyne-global, ../mnemosyne-global, /absolute/path
EXTENDS=$(grep -o '"extends"[[:space:]]*:[[:space:]]*"[^"]*"' "$CONFIG_FILE" | sed 's/.*: *"\(.*\)".*/\1/')

if [ -z "$EXTENDS" ]; then
  echo "❌ Field 'extends' not found in $CONFIG_FILE"
  exit 1
fi

# Resolve absolute path
MNEMOSYNE_DIR="$(dirname "$CONFIG_FILE")"
if [[ "$EXTENDS" == ~* ]]; then
  GLOBAL_DIR="${EXTENDS/#\~/$HOME}"
elif [[ "$EXTENDS" == /* ]]; then
  GLOBAL_DIR="$EXTENDS"
else
  GLOBAL_DIR="$(cd "$MNEMOSYNE_DIR" && cd "$EXTENDS" && pwd)"
fi

if [ ! -d "$GLOBAL_DIR" ]; then
  echo "❌ mnemosyne-global directory does not exist: $GLOBAL_DIR"
  exit 1
fi

COPILOT_SRC="$GLOBAL_DIR/behavior_profiles/Copilot-instructions.md"
GEMINI_SRC="$GLOBAL_DIR/behavior_profiles/Gemini-instructions.md"

for f in "$COPILOT_SRC" "$GEMINI_SRC"; do
  if [ ! -f "$f" ]; then
    echo "⚠️  Not found: $f (will be skipped)"
  fi
done

echo "📂 Project:      $PROJECT_DIR"
echo "📂 Global:       $GLOBAL_DIR"
echo ""

# Create `.github` if it doesn't exist
mkdir -p "$PROJECT_DIR/.github"

# Symlink for Copilot
if [ -f "$COPILOT_SRC" ]; then
  ln -sf "$COPILOT_SRC" "$PROJECT_DIR/.github/copilot-instructions.md"
  echo "✅ .github/copilot-instructions.md → behavior_profiles/Copilot-instructions.md"
else
  echo "⏭️  Copilot-instructions.md does not exist, skipping"
fi

# Symlink for Gemini
if [ -f "$GEMINI_SRC" ]; then
  ln -sf "$GEMINI_SRC" "$PROJECT_DIR/GEMINI.md"
  echo "✅ GEMINI.md → behavior_profiles/Gemini-instructions.md"
else
  echo "⏭️  Gemini-instructions.md does not exist, skipping"
fi

# Copy session date script (for Gemini and other AIs without system date access)
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
UPDATE_DATE_SCRIPT="$SCRIPT_DIR/update_session_date.sh"
if [ -f "$UPDATE_DATE_SCRIPT" ]; then
  mkdir -p "$PROJECT_DIR/scripts"
  cp "$UPDATE_DATE_SCRIPT" "$PROJECT_DIR/scripts/update_session_date.sh"
  chmod +x "$PROJECT_DIR/scripts/update_session_date.sh"
  echo "✅ scripts/update_session_date.sh (date for Chronicles)"
fi

echo ""
echo "✨ Setup complete. Copilot and Gemini will use Mnemosyne profiles."
echo "   For session date: add the task from cursor_integration.md §7 to .vscode/tasks.json"
