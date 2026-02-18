# ITINERARY (Iter)

> INSTRUCTION: Hierarchical map of goals and logical dependencies.
> UPDATE RULE: Update this file EVERY TIME:
>
> 1. A task or subtask is completed (mark as [DONE]).
>    CONSTRAINT: Do NOT mark a task as [DONE] until the corresponding tests have been executed and passed.
> 2. New tasks are identified or priorities shift via user override.
> 3. We move to a new Chronicle Chapter.
>    ACTION: Recalculate the "Critical Path". Ensure blocked tasks are indented.

## Content Structure

- Dependency Graph (Text): Use an indented structure to show which tasks block which (e.g., Task A -> Task B).
- Critical Path Analysis: Identify the sequence of tasks that determine the possibility of completing others.
- Priority Matrix: For branches at the same level of dependency, prioritize according to the degree of alignment with the principles defined in the "docs/Architectural Principles.md" file. Effort should focus on consolidating the fundamental pillars before refinement or extension tasks.
- Special attention to logical dependencies that occur when a task requires other tasks to be completed before it can be finished.
- If the biography does not provide enough details about a branch (such as the acronym spelling engine), mark it as [TO BE DEFINED] based on your technical knowledge of what a system of the type we are building needs. Do not invent facts; identify technical needs.
- Every major task in the itinerary should ideally be justified by a principle in the methodology

## UPDATABLE CONTENT
