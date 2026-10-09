#!/usr/bin/env bash

# 1. Define your wallpaper directory
WALLPAPER_DIR="/home/rudra/Pictures/wallpapers"

# 2. Check if the directory exists
if [ ! -d "$WALLPAPER_DIR" ]; then
    echo "Directory $WALLPAPER_DIR does not exist."
    exit 1
fi

# 3. Generate the rofi input with embedded icon paths
# This loops through the files and formats each line as: Name\0icon\x1f/full/path/to/file
ROFI_INPUT=""
while IFS= read -r file; do
    name=$(basename "$file")
    ROFI_INPUT+="${name}\0icon\x1f${file}\n"
done < <(find "$WALLPAPER_DIR" -type f \( -name "*.jpg" -o -name "*.jpeg" -o -name "*.png" -o -name "*.gif" \) | sort)

# 4. Pass the formatted list to rofi
SELECTED=$(printf "$ROFI_INPUT" | rofi -dmenu -i -p "Select Wallpaper  " \
    -show-icons \
    -theme-str 'listview { columns: 3; lines: 3; } element { orientation: vertical; } element-icon { size: 128px; }')

# 5. If an image is selected, apply it using awww (fixed 'awww' typo to 'swww')
if [ -n "$SELECTED" ]; then
  pehla=$(find $WALLPAPER_DIR -name "$SELECTED")
  awww img "$pehla" --transition-type grow --transition-duration 2
  asus=$(awww query | rev | cut -d : -f1 | rev)
  cp $asus /home/rudra/Pictures/bin/current

  wallpaper_dir=$(awww query | rev | cut -d ":" -f1 | rev | awk '{print $1}')
  wallust run -s $wallpaper_dir && killall waybar && waybar & disown
fi
