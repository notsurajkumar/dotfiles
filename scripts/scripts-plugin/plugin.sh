#!/bin/bash

rofi_cmd=(rofi -dmenu -i -theme-str 'element-icon { enabled : false;}' -p "My Scripts  ")
entries="/home/rudra/scripts/scripts-plugin/entries.conf"

selection=$(sed -e '/^[[:space:]]*#/d' -e '/^[[:space:]]*$/d' "$entries" | cut -d ':' -f 1 | "${rofi_cmd[@]}")

# FIX: If the user presses ESC, selection will be empty. Exit the script safely.
if [ -z "$selection" ]; then
    exit 0
fi

execute=$(grep "$selection" $entries | cut -d ':' -f 2)

eval $execute
