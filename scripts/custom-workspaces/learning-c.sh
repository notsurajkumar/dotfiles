#!/bin/bash

video='/mnt/E/Code/c/resources/c.webm'
dir='/mnt/E/Code/c'

# opening two kitty windows in workspace 2 for gcc and nvim
hyprctl eval "hl.dispatch(hl.dsp.exec_cmd('kitty --working-directory \"$dir\"', { workspace = 1 }))"
hyprctl eval "hl.dispatch(hl.dsp.exec_cmd('kitty --working-directory \"$dir\"', { workspace = 1 }))"




# ╔══════════════════════════════════════════════╗
# ║           Workspace Layout Config            ║
# ╚══════════════════════════════════════════════╝

WORKSPACE=2

# Applications
APP1="obsidian"
APP2="mpv $video"

# Split direction:
#
#   d / b  → APP1 top,    APP2 bottom
#   u / t  → APP1 bottom, APP2 top
#   r      → APP1 left,   APP2 right
#   l      → APP1 right,  APP2 left
#
SPLIT_DIRECTION="r"

# Size of APP1.
#
# For top/bottom:
#   0.46 ≈ 23% / 77%
#
# For left/right:
#   0.46 ≈ 23% / 77%
#
# The ratio is relative to the 50/50 split:
#   0.40 ≈ 20/80
#   0.46 ≈ 23/77
#   0.50 = 25/75
#   0.60 ≈ 30/70
#   1.00 = 50/50
#
SPLIT_RATIO="0.85"


# ╔══════════════════════════════════════════════╗
# ║              Launch APP1                     ║
# ╚══════════════════════════════════════════════╝

hyprctl eval \
    "hl.dispatch(hl.dsp.exec_cmd('$APP1', { workspace = $WORKSPACE }))"


# ╔══════════════════════════════════════════════╗
# ║       Wait for APP1's window to appear       ║
# ╚══════════════════════════════════════════════╝

until hyprctl clients -j | grep -q '"class": "md.obsidian.Obsidian"'; do
    sleep 0.1
done


# ╔══════════════════════════════════════════════╗
# ║       Set direction for the next window      ║
# ╚══════════════════════════════════════════════╝

hyprctl eval \
    "hl.dispatch(hl.dsp.layout('preselect $SPLIT_DIRECTION'))"


# ╔══════════════════════════════════════════════╗
# ║              Launch APP2                     ║
# ╚══════════════════════════════════════════════╝

hyprctl eval \
    "hl.dispatch(hl.dsp.exec_cmd('$APP2', { workspace = $WORKSPACE }))"


# ╔══════════════════════════════════════════════╗
# ║       Wait for APP2's window to appear       ║
# ╚══════════════════════════════════════════════╝

until hyprctl clients -j | grep -q '"class": "mpv"'; do
    sleep 0.1
done


# ╔══════════════════════════════════════════════╗
# ║              Set split ratio                 ║
# ╚══════════════════════════════════════════════╝

hyprctl eval \
    "hl.dispatch(hl.dsp.layout('splitratio $SPLIT_RATIO exact'))"

