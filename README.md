# MNEMOSYNE

_A cognitive framework for long‑term collaboration with AI_

Mnemosyne is not a library, not a model, and not a programming framework.  
It is a **lightweight cognitive architecture** designed to give any AI model  
(Gemini, Copilot, local LLMs, etc.) a stable memory, a methodology, and a  
structured way to collaborate with a human across long‑term projects.

Mnemosyne lives entirely in plain‑text files.  
There is no code, no dependencies, no runtime.  
The intelligence comes from the interaction between:

- the human,
- the AI,
- and the structure defined in this repository.

---

## 🌱 What Mnemosyne _is_

Mnemosyne is:

- A **system of continuity** for AI‑assisted work
- A **methodology** for reasoning, documenting and deciding
- A **memory layer** that persists across sessions
- A **set of protocols** for logging, detecting tasks, and evolving a project
- A **workflow** that encourages initiative from the AI
- A **cognitive scaffold** for people who need structure, reminders, and clarity

Mnemosyne is not a tool you “run”.  
It is a tool you **work inside**.

---

## 🧠 Why it exists

LLMs are powerful but forgetful.  
They lose context, repeat mistakes, and cannot maintain long‑term coherence.

Mnemosyne solves this by externalizing memory and process into a set of  
structured documents that any AI can read and follow.

This allows:

- continuity across days, weeks or months
- consistent methodology
- automatic detection of tasks and patterns
- episodic logging of decisions
- stable collaboration even if the model changes

Mnemosyne turns an LLM into a **long‑term partner**, not a stateless assistant.

---

## 🧩 Project Structure

```text
Mnemosyne
├── mnemosyne
│   ├── actions
│   ├── chronicles
│   │   └── chapter_000.md
│   ├── config.json
│   ├── cursor
│   ├── itinerary.md
│   ├── live-state.json
│   ├── methodology.md
│   └── quick-sync.md
├── mnemosyne-global
│   ├── behavior_profiles
│   │   ├── Copilot-instructions.md
│   │   ├── Gemini-instructions.md
│   │   ├── Local-LLM-instructions.md
│   │   └── Readme.md
│   ├── core
│   │   ├── context_map.md
│   │   ├── global-config.md
│   │   ├── manifesto.md
│   │   ├── mnemosyne_agent.md
│   │   └── mnemosyne_rules.md
│   ├── cursor
│   │   └── rules.json
│   ├── docs
│   │   └── mnemosyne_design.md
│   └── protocols
│       ├── auto-detection.md
│       ├── log_protocol.md
│       ├── startup.md
│       └── succession_protocol.md
├── README.md
├── scripts
│   └── crear_estructura_mnemosyne.sh
└── tree.txt

12 directories, 24 files
```

This repository contains the **global layer** of Mnemosyne.  
Projects that use Mnemosyne will include their own:

- `itinerary.md`
- `chronicles/`
- `live-state.json`
- `quick-sync.md`

These files are project‑specific and evolve over time.

---

## 🧭 How to use Mnemosyne

1. Open your AI environment (Cursor, Gemini, Copilot, etc.)  
   → **Cursor**: Reglas en `.cursor/rules/`. Ver `mnemosyne-global/docs/cursor_integration.md` para integrar Mnemosyne en otros proyectos.
2. Provide the AI with the contents of this repository  
   (Cursor does this automatically if the folder is inside the project)
3. Start a session by asking:  
   **“Load Mnemosyne and resume from the NEXT ACTION.”**
4. Work normally:
   - ask questions
   - request changes
   - let the AI propose tasks
   - let the AI update logs and methodology
5. End the session with:  
   **“Close session and save recap.”**

Mnemosyne is designed to encourage **initiative** from the AI.  
It will detect patterns, propose tasks, warn about inconsistencies,  
and help maintain continuity.

---

## 🎯 Who is Mnemosyne for?

- People who work on long‑term projects with AI
- Researchers, writers, developers, linguists
- Personas despistadas o con TDAH
- Anyone who needs structure, reminders, and continuity
- Anyone who wants an AI that _remembers_ and _thinks with them_

Mnemosyne is especially useful when:

- you switch between models (Gemini, Copilot, local LLMs)
- you work in multiple sessions
- you need a consistent methodology
- you want the AI to take initiative

---

## 🧬 Philosophy

Mnemosyne is built on a simple idea:

> **The human thinks.  
> The AI remembers.  
> Together they build.**

---

## 📜 License

MIT License.
