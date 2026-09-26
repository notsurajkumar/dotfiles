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
  

# movie name selector
name=$(cat "$list" | cut -d ":" -f1 | sort | fzf --reverse --highlight-line --ghost="Search movie name...")

# movie link finder
if [[ -n $name ]]; then
  link=$(cat "$list" | grep -w "$name" | cut -d ":" -f2-100 | awk '{print $1}')
else
  echo "No movie selected!" 
fi



# final player in webapp
if [[ -z $name ]]; then
 exit
else
  echo "Playing $name using MPV!!!"
  mpv --force-window=immediate "$link" &
fi
