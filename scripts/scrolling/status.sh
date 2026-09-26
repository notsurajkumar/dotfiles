#!/bin/bash

cat /tmp/hypr_layout_state_ws_$(hyprctl activeworkspace -j | jq '.id') 2>/dev/null || echo "dwindle"
