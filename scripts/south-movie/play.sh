#!/bin/bash

list='/home/rudra/scripts/south-movie/list.conf'

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
  echo "Playing $name on YouTube!!!"
  final=$(brave --profile-directory="Profile 1" --app="$link" >/dev/null 2>&1 &)
  eval "$final"
fi
