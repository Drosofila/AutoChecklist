#!/bin/bash

AIRCRAFT_FILE="$HOME/Audio Checklists/.active_aircraft"

# default aircraft if none selected
if [ ! -f "$AIRCRAFT_FILE" ]; then
    echo "TTS 737 Checklist" > "$AIRCRAFT_FILE"
fi

AIRCRAFT=$(cat "$AIRCRAFT_FILE")

BASE="$HOME/Audio Checklists/$AIRCRAFT/Raw"

ACTIVE=$(xdotool getactivewindow getwindowname)

if [[ "$ACTIVE" != *"X-Plane"* ]]; then
    exit
fi

STATE_FILE="/tmp/737_checklist_state"

rm -f "$STATE_FILE"

echo "All checklists reset"
