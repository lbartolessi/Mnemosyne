# MNEMOSYNE GLOBAL CONFIG

This directory contains the invariant, cross-project components of Mnemosyne.

## Purpose

Provide a stable cognitive framework shared across all projects.

## Contents

- manifesto.md
- methodology.md
- mnemosyne_rules.md
- context_map.md
- auto-detection.md
- log_protocol.md
- succession_protocol.md
- behavior_profiles/
  - gemini-instructions.md
  - copilot-instructions.md
  - local-llm-instructions.md
- mnemosyne_agent.md

## Usage

Each project includes a `mnemosyne/config.json` file that points to this global layer:

```json
{
  "extends": "~/mnemosyne-global",
  "project_specific": ["itinerary.md", "live-state.json", "quick-sync.md", "chronicles/"]
}
```

### `extends` (ruta al layer global)

| Escenario | Valor de `extends` |
|-----------|-------------------|
| Global fuera del proyecto (compartido) | `~/mnemosyne-global` o ruta absoluta |
| Global como hermano dentro del repo | `../mnemosyne-global` |
| Variable de entorno | `$MNEMOSYNE_GLOBAL` (si tu herramienta lo soporta) |

La idea: `mnemosyne-global` vive **fuera** de cada proyecto para poder compartirlo entre varios.

### `project_specific`

Lista explícita de lo que varía por proyecto. Por defecto:
- `itinerary.md` — plan de tareas
- `live-state.json` — estado de sesión
- `quick-sync.md` — snapshot rápido
- `chronicles/` — crónicas episódicas

Todo lo demás (manifesto, rules, protocols, behavior_profiles) viene del layer global.
