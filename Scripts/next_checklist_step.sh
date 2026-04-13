#!/bin/bash

AIRCRAFT_FILE="$HOME/Audio Checklists/.active_aircraft"

# default aircraft if none selected
if [ ! -f "$AIRCRAFT_FILE" ]; then
    echo "TTS 737 Checklist" > "$AIRCRAFT_FILE"
fi

AIRCRAFT=$(cat "$AIRCRAFT_FILE")

BASE="$HOME/Audio Checklists/$AIRCRAFT/Raw"
STATE_FILE="/tmp/737_checklist_state"

ACTIVE=$(xdotool getactivewindow getwindowname)

if [[ "$ACTIVE" != *"X-Plane"* ]]; then
    exit
fi

# state format: checklist_index step_index
if [ ! -f "$STATE_FILE" ]; then
    echo "0 0" > "$STATE_FILE"
fi

read CHECKLIST STEP < "$STATE_FILE"

# load checklist folders
mapfile -t LISTS < <(ls -d "$BASE"/* | sort)

CURRENT_LIST="${LISTS[$CHECKLIST]}"

# load audio steps
mapfile -t STEPS < <(ls "$CURRENT_LIST"/*.wav | sort)

FILE="${STEPS[$STEP]}"

if [ -n "$FILE" ]; then
    echo "Playing: $FILE"
    aplay -q "$FILE"
    STEP=$((STEP+1))
else
    # move to next checklist
    CHECKLIST=$((CHECKLIST+1))
    STEP=0

    if [ "$CHECKLIST" -ge "${#LISTS[@]}" ]; then
        echo "All checklists complete"
        rm "$STATE_FILE"
        exit
    fi

    CURRENT_LIST="${LISTS[$CHECKLIST]}"
    mapfile -t STEPS < <(ls "$CURRENT_LIST"/*.wav | sort)
    FILE="${STEPS[0]}"

    echo "Starting next checklist: $CURRENT_LIST"
    aplay -q "$FILE"
    STEP=1
fi

echo "$CHECKLIST $STEP" > "$STATE_FILE"
