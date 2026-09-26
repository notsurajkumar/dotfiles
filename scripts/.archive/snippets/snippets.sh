#!/bin/bash

DATABASE="$HOME/scripts/snippets/database.txt"
TARGET_DIR="$HOME/scripts/snippets"

if [ ! -f "$DATABASE" ]; then
    echo "Error: Database file not found at $DATABASE" >&2
    exit 1
fi

# 1. Parse database for Rofi and prepend the Edit Tool option at the top
selection=$({
    echo "Edit Tool > cd .. kitty"
    
    awk '
        { sub(/\r$/, "") }
        
        /^# / {
            if (label != "") {
                print label " > " preview
            }
            sub(/^# /, "")
            label = $0
            preview = ""
            first = 1
            next
        }
        
        label != "" {
            if ($0 ~ /^[[:space:]]*$/) next
            
            clean_line = $0
            sub(/^[ \t]+/, "", clean_line)
            
            if (first) {
                preview = clean_line
                first = 0
            } else {
                preview = preview " | " clean_line
            }
        }
        
        END {
            if (label != "") {
                print label " > " preview
            }
        }
    ' "$DATABASE"
} | rofi -dmenu -i -p "Expand  ")

[ -z "$selection" ] && exit 0

# 2. Extract the true label name chosen from Rofi
selected_label=$(echo "$selection" | awk -F " > " '{print $1}')

# 3. Check if the user selected the edit option
if [ "$selected_label" = "Edit Tool" ]; then
    kitty --working-directory "$TARGET_DIR" bash -c "exec \$SHELL" & disown
    exit 0
fi

# 4. Extract the exact raw block, perfectly clean up any trailing blank lines/newlines, and copy
awk -v target="$selected_label" '
    BEGIN { inside = 0 }
    { sub(/\r$/, "") }
    
    /^# / {
        sub(/^# /, "")
        if ($0 == target) {
            inside = 1
        } else {
            inside = 0
        }
        next
    }
    
    inside {
        print $0
    }
' "$DATABASE" | sed -e :a -e '/^\n*$/{$d;N;ba;}' | tr -d '\r' | wl-copy -n
