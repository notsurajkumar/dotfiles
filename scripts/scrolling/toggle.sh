#!/bin/bash

# 1. Get the ID of the currently active workspace
WS_ID=$(hyprctl activeworkspace -j | jq '.id')

# 2. Define a temporary state file unique to this workspace
STATE_FILE="/tmp/hypr_layout_state_ws_${WS_ID}"

# 3. Read the current state (default to dwindle if the file doesn't exist)
if [ ! -f "$STATE_FILE" ]; then
    CURRENT_LAYOUT="dwindle"
else
    CURRENT_LAYOUT=$(cat "$STATE_FILE")
fi

# 4. Toggle the layout dynamically for THIS workspace only
if [ "$CURRENT_LAYOUT" = "dwindle" ]; then
    # Apply the scrolling rule and update the state
    hyprctl keyword workspace "$WS_ID",layout:scrolling
    echo "scrolling" > "$STATE_FILE"
    notify-send -t 2000 "Hyprland" "Workspace $WS_ID: Scrolling"
else
    # Apply the dwindle rule and update the state
    hyprctl keyword workspace "$WS_ID",layout:dwindle
    echo "dwindle" > "$STATE_FILE"
    notify-send -t 2000 "Hyprland" "Workspace $WS_ID: Dwindle"
fi
