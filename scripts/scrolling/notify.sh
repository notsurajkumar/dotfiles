#!/bin/bash

WS_ID=$(hyprctl activeworkspace -j | jq '.id')

layout=$(cat /tmp/hypr_layout_state_ws_$(hyprctl activeworkspace -j | jq '.id') 2>/dev/null || echo "dwindle")

notify-send -t 2000 "Current Workspace : $layout"
