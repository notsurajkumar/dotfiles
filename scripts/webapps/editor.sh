#!/bin/bash

direc="/home/rudra/.local/share/applications/webapps"

files=$(find $direc -type f -name "*.desktop" -printf "%T@ %f\n" | sort -rn | cut -d' ' -f2- | cut -d "." -f1)

choice=$(gum choose $files)

if [[ -n $choice ]]; then
  nvim "$direc/$choice.desktop"
else
  exit
fi

