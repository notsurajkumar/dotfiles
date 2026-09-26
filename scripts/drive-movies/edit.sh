#!/bin/bash

list_root='/home/rudra/scripts/drive-movies'
choice=$(gum choose "Mainstream" "Animated" --header="Chose type of movie")

if [[ $choice == "Animated" ]]; then
  list="$list_root/animated.conf"
elif [[ $choice == "Mainstream" ]]; then
  list="$list_root/mainstream.conf"
else
  exit
fi
  
nvim "$list"
