# Integración de Mnemosyne con Cursor

Esta guía explica cómo usar Mnemosyne dentro de Cursor y cómo insertarlo en otros proyectos.

---

## 1. En este repositorio (Mnemosyne)

El proyecto ya incluye reglas de Cursor en `.cursor/rules/`:

- **mnemosyne-core.mdc**: Siempre activa. Define el protocolo de inicio, las reglas de comportamiento y la estructura.
- **mnemosyne-chronicles.mdc**: Se activa al trabajar con `mnemosyne/chronicles/**/*.md`. Define el protocolo de registro.

Al abrir el workspace en Cursor, la IA recibe estas reglas automáticamente.

### Comandos para iniciar

- **Inicio de sesión**: "Load Mnemosyne and resume from the NEXT ACTION."
- **Cierre de sesión**: "Close session and save recap."

---

## 2. Configuración: global fuera del proyecto

Lo habitual es tener `mnemosyne-global` **fuera** de cada proyecto, compartido entre varios. En `mnemosyne/config.json`:

```json
{
  "extends": "~/mnemosyne-global",
  "project_specific": ["itinerary.md", "live-state.json", "quick-sync.md", "chronicles/"]
}
```

Ver `mnemosyne-global/core/global-config.md` para los distintos valores de `extends` según la estructura.

---

## 3. Insertar Mnemosyne en otro proyecto

### Opción A: Solo layer de proyecto (global compartido)

Si ya tienes `mnemosyne-global` en `~/mnemosyne-global`:

1. Crea la estructura de proyecto: `mnemosyne/` con `config.json`, `itinerary.md`, `chronicles/`, etc.
2. En `config.json` usa `"extends": "~/mnemosyne-global"`.
3. Copia las reglas de Cursor y ajusta las rutas según dónde resuelva `extends`.
4. **Copilot y Gemini**: Ejecuta `scripts/setup_ide_instructions.sh` para crear symlinks a los perfiles de Mnemosyne (crea `.github/copilot-instructions.md` y `GEMINI.md`).

### Opción B: Como submódulo o subárbol (todo junto)

```bash
# Desde la raíz del proyecto destino
git subtree add --prefix mnemosyne-integration https://github.com/tu-usuario/Mnemosyne main
# O como submódulo:
git submodule add https://github.com/tu-usuario/Mnemosyne mnemosyne-integration
```

Luego copia o enlaza las reglas de Cursor:

```bash
mkdir -p .cursor/rules
cp mnemosyne-integration/.cursor/rules/*.mdc .cursor/rules/
```

**Importante**: Ajusta las rutas en las reglas si la carpeta no se llama `mnemosyne-integration`. Por defecto las reglas asumen:
- `mnemosyne-global/` para el layer global
- `mnemosyne/` para el layer de proyecto

### Opción C: Script de creación

Ejecuta el script en la raíz del proyecto destino:

```bash
/path/to/Mnemosyne/scripts/crear_estructura_mnemosyne.sh
```

Esto crea la estructura vacía. Después copia:
1. El contenido de `mnemosyne-global/` desde el repo Mnemosyne
2. Las reglas de `.cursor/rules/` (o crea las reglas adaptadas)

### Opción D: Workspace multi-carpeta

Si Mnemosyne vive en un directorio hermano, puedes usar un workspace:

```json
{
  "folders": [
    { "path": "mi-proyecto" },
    { "path": "../Mnemosyne" }
  ]
}
```

La IA tendrá contexto de ambos. Las reglas deben apuntar a las rutas correctas (`Mnemosyne/mnemosyne-global/`, etc.).

---

## 4. Rutas que debes adaptar

Si la estructura del proyecto difiere, edita `.cursor/rules/mnemosyne-core.mdc`:

| Ruta por defecto | Descripción |
|------------------|-------------|
| `mnemosyne-global/core/manifesto.md` | Constitución |
| `mnemosyne/itinerary.md` | Plan de tareas |
| `mnemosyne/methodology.md` | Teoría y patrones |
| `mnemosyne/live-state.json` | Estado de sesión |
| `mnemosyne/chronicles/` | Crónicas |

---

## 5. Verificación

Tras integrar, abre el chat de Cursor y escribe:

> Load Mnemosyne and resume from the NEXT ACTION.

La IA debería:
1. Cargar manifesto, itinerary, methodology, live-state
2. Localizar NEXT ACTION
3. Confirmar que está lista para retomar

---

## 6. Copilot y Gemini

Las extensiones de **Copilot** y **Gemini** buscan instrucciones en rutas fijas, no en `behavior_profiles/`. Para que usen los perfiles de Mnemosyne, ejecuta:

```bash
# Desde la raíz del proyecto con Mnemosyne:
/path/to/Mnemosyne/scripts/setup_ide_instructions.sh .

# O especificando el proyecto:
/path/to/Mnemosyne/scripts/setup_ide_instructions.sh /ruta/al/proyecto
```

Esto crea symlinks:
- `.github/copilot-instructions.md` → `mnemosyne-global/behavior_profiles/Copilot-instructions.md`
- `GEMINI.md` → `mnemosyne-global/behavior_profiles/Gemini-instructions.md`

El script lee la ruta a `mnemosyne-global` desde `mnemosyne/config.json` (campo `extends`).

---

## 7. Fecha de sesión (Gemini y otras IAs sin acceso a la fecha del sistema)

Gemini en VS Code no puede obtener la fecha del sistema. Para evitar que invente fechas o tengas que indicarlas manualmente:

1. **Script**: `scripts/update_session_date.sh` escribe la fecha actual en `mnemosyne/current-date.txt`.
2. **Tarea al abrir**: Añade esta tarea a `.vscode/tasks.json` para que se ejecute al abrir el workspace:

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

3. **Activar tareas automáticas**: En VS Code, `Settings` → busca "Task: Allow Automatic Tasks In Folder" → activa "Allow" para el workspace.

4. **Protocolo**: La IA lee `mnemosyne/current-date.txt` antes de escribir en las Chronicles. Si falta, pregunta al usuario.

**Opcional**: Añade `mnemosyne/current-date.txt` a `.gitignore` si no quieres versionarlo (cambia cada día).

---

## 8. Perfiles de comportamiento

Mnemosyne incluye perfiles en `mnemosyne-global/behavior_profiles/` para distintos modelos. Cursor usa modelos tipo GPT; si quieres afinar el estilo, puedes incorporar fragmentos de `Copilot-instructions.md` en una regla adicional.
