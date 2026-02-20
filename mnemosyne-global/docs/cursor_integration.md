# Mnemosyne Integration with Cursor

This guide explains how to use Mnemosyne within Cursor and how to integrate it into other projects.

---

## 1. In this repository (Mnemosyne)

The project already includes Cursor rules in `.cursor/rules/`:

- **mnemosyne-core.mdc**: Always active. Defines the start-up protocol, behavioural rules, and structure.
- **mnemosyne-chronicles.mdc**: Activates when working with `mnemosyne/chronicles/**/*.md`. Defines the logging protocol.

When you open the workspace in Cursor, the AI receives these rules automatically.

### Commands to start

These are examples; semantically equivalent phrasing in any language works:

- **Session start**: e.g. "Load Mnemosyne and resume from the NEXT ACTION."
- **Session end**: e.g. "Close session and save recap."

---

## 2. Configuration: global outside the project

The usual setup is to have `mnemosyne-global` **outside** each project, shared across several. In `mnemosyne/config.json`:

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

See `mnemosyne-global/core/global-config.md` for different `extends` values depending on your structure.

---

## 3. Insert Mnemosyne into another project

### Option A: Project layer only (shared global)

If you already have `mnemosyne-global` at `~/mnemosyne-global`:

1. Create the project structure: `mnemosyne/` with `config.json`, `itinerary.md`, `chronicles/`, etc.
2. In `config.json` use `"extends": "~/mnemosyne-global"`.
3. Copy the Cursor rules and adjust the paths according to where `extends` resolves.
4. **Copilot and Gemini**: Run `scripts/setup_ide_instructions.sh` to create symlinks to the Mnemosyne profiles (creates `.github/copilot-instructions.md` and `GEMINI.md`).

### Option B: As submodule or subtree (all together)

```bash
# From the target project root
git subtree add --prefix mnemosyne-integration https://github.com/your-username/Mnemosyne main
# Or as submodule:
git submodule add https://github.com/your-username/Mnemosyne mnemosyne-integration
```

Then copy or link the Cursor rules:

```bash
mkdir -p .cursor/rules
cp mnemosyne-integration/.cursor/rules/*.mdc .cursor/rules/
```

**Important**: Adjust the paths in the rules if the folder is not named `mnemosyne-integration`. By default the rules assume:

- `mnemosyne-global/` for the global layer
- `mnemosyne/` for the project layer

### Option C: Creation script

Run the script at the target project root:

```bash
/path/to/Mnemosyne/scripts/create_mnemosyne_structure.sh
```

This creates the empty structure. Then copy:

1. The contents of `mnemosyne-global/` from the Mnemosyne repo
2. The rules from `.cursor/rules/` (or create adapted rules)

### Option D: Multi-folder workspace

If Mnemosyne lives in a sibling directory, you can use a workspace:

```json
{
  "folders": [{ "path": "my-project" }, { "path": "../Mnemosyne" }]
}
```

The AI will have context from both. The rules must point to the correct paths (`Mnemosyne/mnemosyne-global/`, etc.).

---

## 4. Paths you need to adapt

If the project structure differs, edit `.cursor/rules/mnemosyne-core.mdc`:

| Default path                         | Description         |
| ------------------------------------ | ------------------- |
| `mnemosyne-global/core/manifesto.md` | Constitution        |
| `mnemosyne/itinerary.md`             | Task plan           |
| `mnemosyne/methodology.md`           | Theory and patterns |
| `mnemosyne/live-state.json`          | Session state       |
| `mnemosyne/chronicles/`              | Chronicles          |

---

## 5. Verification

After integrating, open the Cursor chat and type:

> Load Mnemosyne and resume from the NEXT ACTION.

The AI should:

1. Load manifesto, itinerary, methodology, live-state
2. Locate NEXT ACTION
3. Confirm it is ready to resume

---

## 6. Copilot and Gemini

The **Copilot** and **Gemini** extensions look for instructions at fixed paths, not in `behavior_profiles/`. To have them use Mnemosyne profiles, run:

```bash
# From the project root with Mnemosyne:
/path/to/Mnemosyne/scripts/setup_ide_instructions.sh .

# Or specifying the project:
/path/to/Mnemosyne/scripts/setup_ide_instructions.sh /path/to/project
```

This creates symlinks:

- `.github/copilot-instructions.md` → `mnemosyne-global/behavior_profiles/Copilot-instructions.md`
- `GEMINI.md` → `mnemosyne-global/behavior_profiles/Gemini-instructions.md`

The script reads the path to `mnemosyne-global` from `mnemosyne/config.json` (the `extends` field).

---

## 7. Session date (Gemini and other AIs without system date access)

Gemini in VS Code cannot get the system date. To avoid it inventing dates or having to provide them manually:

1. **Script**: `scripts/update_session_date.sh` writes the current date to `mnemosyne/current-date.txt`.
2. **Task on open**: Add this task to `.vscode/tasks.json` so it runs when the workspace opens:

```json
{
  "label": "Mnemosyne: Update session date",
  "type": "shell",
  "command": "${workspaceFolder}/scripts/update_session_date.sh",
  "args": ["${workspaceFolder}"],
  "presentation": { "reveal": "silent", "echo": false },
  "problemMatcher": [],
  "runOptions": { "runOn": "folderOpen" }
}
```

1. **Enable automatic tasks**: In VS Code, `Settings` → search for 'Task: Allow Automatic Tasks In Folder' → enable "Allow" for the workspace.

2. **Protocol**: The AI reads `mnemosyne/current-date.txt` before writing to the Chronicles. If missing, it asks the user.

**Optional**: Add `mnemosyne/current-date.txt` to `.gitignore` if you don't want to version it (it changes every day).

---

## 8. Behaviour profiles

Mnemosyne includes profiles in `mnemosyne-global/behavior_profiles/` for different models. Cursor uses GPT-like models; if you want to refine the style, you can incorporate fragments from `Copilot-instructions.md` into an additional rule.
