# CONTEXT MAP (Mnemosyne Overview)

Mnemosyne is a cognitive framework composed of several files that define:

- memory
- methodology
- itinerary
- episodic logs
- session state
- auto-detection rules

This file explains the purpose of each component.

---

## 1. manifesto.md

Defines the global rules of the system:

- role of the AI
- continuity rules
- startup protocol
- state persistence
- tone
- chapter tracking

This is the constitution of the project.

---

## 2. itinerary.md

Defines:

- dependency graph of tasks
- critical path
- priorities
- project roadmap
- task completion rules

This is the action plan.

---

## 3. methodology.md

Defines:

- architectural principles
- coding standards
- design philosophy
- technical patterns

This is the theory.

---

## 4. chronicles/chapter_XXX.md

Episodic memory:

- logs of actions
- decisions
- fixes
- discarded paths
- milestones

This is the historical record.

---

## 5. live-state.json

Tracks:

- current session
- progress
- blockers
- last action
- next tasks

This is the runtime state.

---

## 6. quick-sync.md

A lightweight snapshot for fast context loading.

---

## 6b. current-date.txt

Today's date (YYYY-MM-DD), updated when the workspace opens.  
Used by IAs (e.g. Gemini) that cannot access the system date.  
Read before writing Chronicle entries.

---

## 7. prompts/\*.md

Define:

- auto-detection rules
- logging protocol
- succession protocol

These are the meta-rules.

---

## 8. mnemosyne/actions/

Scratchpad for the AI.  
Temporary files allowed.

---

## Summary

- **Manifesto** = Constitution
- **Itinerary** = Plan
- **Methodology** = Theory
- **Chronicles** = Memory
- **Live-State** = Runtime
- **Quick-Sync** = Snapshot
- **Prompts** = Meta-rules
