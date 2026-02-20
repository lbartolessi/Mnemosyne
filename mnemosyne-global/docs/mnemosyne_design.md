# MNEMOSYNE — Cognitive Architecture for AI-Augmented Development

Mnemosyne is a lightweight cognitive framework designed to give any AI model
(Gemini, Copilot, Local LLMs) a persistent memory, a methodology, and a
structured way to collaborate with a human developer across long-term projects.

It is not a tool, not a library, and not an agent.
It is an _architecture of files and protocols_.

---

## 1. Purpose

Mnemosyne solves a fundamental problem in AI-assisted development:

> “LLMs forget everything between sessions.”

Mnemosyne provides:

- Persistent memory
- Project continuity
- Methodology tracking
- Task management
- Episodic logging
- Behavioural rules for the AI
- Automatic detection of patterns and tasks

It transforms any LLM into a stable collaborator.

---

## 2. Core Principles

### 2.1 Externalized Memory

All memory is stored in plain-text files:

- `manifesto.md` (constitution)
- `itinerary.md` (plan)
- `methodology.md` (theory)
- `chronicles/` (episodic logs)
- `live-state.json` (runtime state)

The AI reads these files at every session.

### 2.2 Model-Agnostic

Mnemosyne works with:

- Gemini
- Copilot (`GPT‑4o`)
- Local LLMs (Llama, Qwen, or Mistral)
- Any model Cursor can use

Because the intelligence is in the _protocol_, not in the model.

### 2.3 Soft Agency

The AI is encouraged to:

- detect tasks
- propose updates
- warn about inconsistencies
- maintain continuity

But never act without confirmation.

### 2.4 Human Sovereignty

User overrides documentation.
The AI warns, but does not block.

---

## 3. Architecture Overview

### 3.1 Global Layer (`~/mnemosyne-global/`)

Contains:

- universal rules
- methodology
- protocols
- behaviour profiles
- Cursor rules

This layer is shared across all projects.

### 3.2 Project Layer (`project/.mnemosyne/`)

Contains:

- itinerary
- chronicles
- live-state
- quick-sync
- project-specific configuration

This layer is unique per project.

### 3.3 Cursor Integration

Cursor provides:

- semantic indexing
- context injection
- file awareness

Mnemosyne provides:

- structure
- memory
- rules
- continuity

Together they form a cognitive development environment.

---

## 4. Why Mnemosyne Works

Because it uses the strengths of LLMs:

- pattern detection
- reasoning
- summarization
- planning

And compensates for their weaknesses:

- lack of memory
- inconsistency
- context loss
- hallucination

---

## 5. Who Is It For?

- Researchers
- Developers
- Writers
- Anyone who works on long-term projects with AI

Especially:

- scatterbrained people
- people with ADHD
- people who need continuity

---

## 6. Philosophy

Mnemosyne is built on a simple idea:

> “The human thinks.  
> The AI remembers.  
> Together they build.”
