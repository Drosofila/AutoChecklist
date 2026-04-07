#!/bin/bash

STATE_FILE="/tmp/737_checklist_state"

# ensure state file exists
if [ ! -f "$STATE_FILE" ]; then
    echo "0 0" > "$STATE_FILE"
fi

# read current state
read CHECKLIST STEP < "$STATE_FILE"

# move to next checklist
CHECKLIST=$((CHECKLIST + 1))

# reset step counter
STEP=0

# save updated state
echo "$CHECKLIST $STEP" > "$STATE_FILE"
