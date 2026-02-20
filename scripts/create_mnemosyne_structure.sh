#!/bin/bash

# ============================================================
#   MNEMOSYNE — Project + Global Cognitive Framework Creator
#   Creates:
#     - mnemosyne/ (project-level)
#     - mnemosyne-global/ (global-level)
# ============================================================

echo "📁 Creating Mnemosyne project structure..."
mkdir -p mnemosyne/{core,protocols,behavior_profiles,\
    cursor,docs,chronicles,actions}

echo "📁 Creating Mnemosyne Global structure..."
mkdir -p mnemosyne-global/{core,protocols,behavior_profiles,cursor,docs,templates,snapshots}

# ------------------------------------------------------------
# Project-level files (empty placeholders)
# ------------------------------------------------------------
touch mnemosyne/itinerary.md
touch mnemosyne/live-state.json
touch mnemosyne/quick-sync.md
touch mnemosyne/snapshots/.gitkeep
 
# ------------------------------------------------------------
# Global-level files (empty placeholders)
# ------------------------------------------------------------
touch mnemosyne-global/core/manifesto.md
touch mnemosyne-global/core/methodology.md
touch mnemosyne-global/core/mnemosyne_rules.md
touch mnemosyne-global/core/context_map.md
touch mnemosyne-global/core/mnemosyne_agent.md
touch mnemosyne-global/core/global-config.md


touch mnemosyne-global/protocols/autodetection.md
touch mnemosyne-global/protocols/log_protocol.md
touch mnemosyne-global/protocols/succession_protocol.md
touch mnemosyne-global/protocols/start-up.md

touch mnemosyne-global/behavior_profiles/gemini-instructions.md
touch mnemosyne-global/behavior_profiles/copilot-instructions.md
touch mnemosyne-global/behavior_profiles/local-llm-instructions.md
touch mnemosyne-global/behavior_profiles/README.md

touch mnemosyne-global/cursor/rules.json

touch mnemosyne-global/docs/mnemosyne_design.md

touch mnemosyne-global/templates/snapshot_template.md

# ------------------------------------------------------------
# Optional: create README for the project root
# ------------------------------------------------------------
if [ ! -f README.md ]; then
    echo "Creating README.md placeholder..."
    touch README.md
fi

echo "✨ Mnemosyne structure created successfully!"
echo "You can now start populating the files with content."
