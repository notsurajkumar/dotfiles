#!/bin/bash

while IFS= read -r line; do
    awww img "/home/rudra/Pictures/wallpapers/wallpapers/$line" \
        --transition-type grow \
        --transition-duration 1.5

    echo
    echo "Enter choice (y to keep, anything else to skip):"
    read -r key < /dev/tty

    if [[ "$key" == "y" ]]; then
        echo "$line" >> final.md
    fi
done < raw2.md
