#!/usr/bin/env bash

# 1. Define your wallpaper directory
WALLPAPER_DIR="/home/rudra/Pictures/wallpapers"

# 2. Check if the directory exists
if [ ! -d "$WALLPAPER_DIR" ]; then
    echo "Directory $WALLPAPER_DIR does not exist."
    exit 1
fi

wall=$(find "$WALLPAPER_DIR" -type f \( -name "*.jpg" -o -name "*.jpeg" -o -name "*.png" -o -name "*.gif" \) | sort | shuf -n 1)



awww img "$wall" --transition-type grow --transition-duration 2
asus=$(awww query | rev | cut -d : -f1 | rev)
cp $asus /home/rudra/Pictures/bin/current
wallust run -s "$wall" && killall waybar && waybar & disown
