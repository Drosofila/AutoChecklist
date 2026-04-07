#!/bin/bash

AIRCRAFT_FILE="/tmp/active_aircraft_checklist"

echo "Available aircraft:"
echo "1) TTS 737"
echo "2) TTS CL60"

read -p "Select aircraft: " choice

case $choice in
1)
    echo "TTS 737 Checklist" > "$AIRCRAFT_FILE"
    echo "737 checklist selected"
    ;;
2)
    echo "TTS CL60 Checklist" > "$AIRCRAFT_FILE"
    echo "CL60 checklist selected"
    ;;
*)
    echo "Invalid choice"
    ;;
esac

read -p "Press Enter to close..."
