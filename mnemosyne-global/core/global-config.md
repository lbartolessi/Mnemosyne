# MNEMOSYNE GLOBAL CONFIG

This directory contains the invariant, cross-project components of Mnemosyne.

## Purpose

Provide a stable cognitive framework shared across all projects.

## Contents

- manifesto.md
- methodology.md
- mnemosyne_rules.md
- context_map.md
- autodetection.md
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
  "project_specific": [
    "itinerary.md",
    "live-state.json",
    "quick-sync.md",
    "chronicles/"
  ]
}
```

### `extends` (path to global layer)

| Scenario                        | `extends` value                                |
| ------------------------------- | ---------------------------------------------- |
| Global outside project (shared) | `~/mnemosyne-global` or absolute path          |
| Global as sibling inside repo   | `../mnemosyne-global`                          |
| Environment variable            | `$MNEMOSYNE_GLOBAL` (if your tool supports it) |

The idea: `mnemosyne-global` lives **outside** each project so it can be shared across several.

### `project_specific`

Explicit list of what varies per project. By default:

- `itinerary.md` — task plan
- `live-state.json` — session state
- `quick-sync.md` — quick snapshot
- `chronicles/` — episodic chronicles

Everything else (manifesto, rules, protocols, behaviour_profiles) comes from the global layer.
