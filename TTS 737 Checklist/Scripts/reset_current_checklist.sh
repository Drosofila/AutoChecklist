#!/bin/bash

AIRCRAFT_FILE="/tmp/active_aircraft_checklist"

# default aircraft if none selected
if [ ! -f "$AIRCRAFT_FILE" ]; then
    echo "TTS 737 Checklist" > "$AIRCRAFT_FILE"
fi

AIRCRAFT=$(cat "$AIRCRAFT_FILE")

BASE="$HOME/Documents/Audio Checklists/$AIRCRAFT/Raw"

ACTIVE=$(xdotool getactivewindow getwindowname)

if [[ "$ACTIVE" != *"X-Plane"* ]]; then
    exit
fi

STATE_FILE="/tmp/737_checklist_state"

if [ -f "$STATE_FILE" ]; then
    read CHECKLIST STEP < "$STATE_FILE"
    echo "$CHECKLIST 0" > "$STATE_FILE"
    echo "Current checklist reset"
else
    echo "No checklist running"
fi
