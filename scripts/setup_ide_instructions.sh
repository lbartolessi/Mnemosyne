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
  echo "❌ No se encuentra mnemosyne/config.json en: $PROJECT_DIR"
  echo "   Ejecuta este script desde la raíz de un proyecto con Mnemosyne, o:"
  echo "   $0 /ruta/al/proyecto"
  exit 1
fi

# Resolver ruta de mnemosyne-global desde config.json (campo "extends")
# Soporta: ~/mnemosyne-global, ../mnemosyne-global, /ruta/absoluta
EXTENDS=$(grep -o '"extends"[[:space:]]*:[[:space:]]*"[^"]*"' "$CONFIG_FILE" | sed 's/.*: *"\(.*\)".*/\1/')

if [ -z "$EXTENDS" ]; then
  echo "❌ No se encuentra el campo 'extends' en $CONFIG_FILE"
  exit 1
fi

# Resolver ruta absoluta
MNEMOSYNE_DIR="$(dirname "$CONFIG_FILE")"
if [[ "$EXTENDS" == ~* ]]; then
  GLOBAL_DIR="${EXTENDS/#\~/$HOME}"
elif [[ "$EXTENDS" == /* ]]; then
  GLOBAL_DIR="$EXTENDS"
else
  GLOBAL_DIR="$(cd "$MNEMOSYNE_DIR" && cd "$EXTENDS" && pwd)"
fi

if [ ! -d "$GLOBAL_DIR" ]; then
  echo "❌ No existe el directorio mnemosyne-global: $GLOBAL_DIR"
  exit 1
fi

COPILOT_SRC="$GLOBAL_DIR/behavior_profiles/Copilot-instructions.md"
GEMINI_SRC="$GLOBAL_DIR/behavior_profiles/Gemini-instructions.md"

for f in "$COPILOT_SRC" "$GEMINI_SRC"; do
  if [ ! -f "$f" ]; then
    echo "⚠️  No encontrado: $f (se saltará)"
  fi
done

echo "📂 Proyecto:     $PROJECT_DIR"
echo "📂 Global:       $GLOBAL_DIR"
echo ""

# Crear .github si no existe
mkdir -p "$PROJECT_DIR/.github"

# Symlink para Copilot
if [ -f "$COPILOT_SRC" ]; then
  ln -sf "$COPILOT_SRC" "$PROJECT_DIR/.github/copilot-instructions.md"
  echo "✅ .github/copilot-instructions.md → behavior_profiles/Copilot-instructions.md"
else
  echo "⏭️  Copilot-instructions.md no existe, se omite"
fi

# Symlink para Gemini
if [ -f "$GEMINI_SRC" ]; then
  ln -sf "$GEMINI_SRC" "$PROJECT_DIR/GEMINI.md"
  echo "✅ GEMINI.md → behavior_profiles/Gemini-instructions.md"
else
  echo "⏭️  Gemini-instructions.md no existe, se omite"
fi

# Copiar script de fecha de sesión (para Gemini y otras IAs sin acceso a la fecha)
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
UPDATE_DATE_SCRIPT="$SCRIPT_DIR/update_session_date.sh"
if [ -f "$UPDATE_DATE_SCRIPT" ]; then
  mkdir -p "$PROJECT_DIR/scripts"
  cp "$UPDATE_DATE_SCRIPT" "$PROJECT_DIR/scripts/update_session_date.sh"
  chmod +x "$PROJECT_DIR/scripts/update_session_date.sh"
  echo "✅ scripts/update_session_date.sh (fecha para Chronicles)"
fi

echo ""
echo "✨ Configuración completada. Copilot y Gemini usarán los perfiles de Mnemosyne."
echo "   Para la fecha de sesión: añade la tarea de cursor_integration.md §7 a .vscode/tasks.json"
