#!/bin/bash

# Target file to modify
TARGET_FILE="/home/rudra/.config/waybar/style.css"

# Prompt the user for the alpha/opacity value
#read -p "Enter new opacity value (e.g., 0.5): " NEW_ALPHA
NEW_ALPHA=$(printf "0.1\n0.2\n0.3\n0.4\n0.5\n0.6\n0.7\n0.8\n0.9\n1" | rofi -dmenu -i -p "Opacity  " -matching fuzzy)

if [[ -z $NEW_ALPHA ]]; then
  NEW_ALPHA='1'
fi

echo "$NEW_ALPHA"
# Check if the target file exists
if [ ! -f "$TARGET_FILE" ]; then
    echo "Error: $TARGET_FILE does not exist."
    exit 1
fi

# Replace the alpha value while preserving indentation
sed -i -E "s/^([[:space:]]*background-color:[[:space:]]*rgba\([0-9]+,[[:space:]]*[0-9]+,[[:space:]]*[0-9]+,[[:space:]]*)[0-9.]+(\);)/\1${NEW_ALPHA}\2/" "$TARGET_FILE"

echo "Updated $TARGET_FILE successfully!"
