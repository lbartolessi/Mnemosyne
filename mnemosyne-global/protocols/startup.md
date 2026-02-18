# STARTUP PROTOCOL (Cursor Session Initialization)

0. **Session date**: If you need the date (e.g. for Chronicle entries), read `mnemosyne/current-date.txt`. It is updated when the workspace opens. If missing, ask the user.

1. Load:
   - manifesto.md
   - itinerary.md
   - methodology.md
   - live-state.json

2. Read `## NEXT ACTION` in itinerary.md.

3. Confirm:
   “Context loaded. Ready to resume from NEXT ACTION.”

4. If any critical file is missing:
   - Stop and request restoration.

5. If session is new:
   - Propose a quick recap from quick-sync.md.
