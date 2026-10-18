#!/bin/bash

parent='/home/rudra/Music'
folders_output='/home/rudra/scripts/app-groups/mpv-cava-folders.md'

# outputting all folder names in a tmp local file
echo "Play All" > "$folders_output"
folder=$(bash -c 'ls -d /home/rudra/Music/*/' | rev | cut -d "/" -f2 | rev >> "$folders_output")

# disiplaying all folder names in rofi
f_folder=$(cat "$folders_output" | rofi -dmenu -i -p "Folder   " -matching fuzzy)


# selecting songs
if [[ $folder == "Play All" ]]; then
  find /home/rudra/Music/ -type f -name "*.mp3"
else
  song=$(bash -c "ls $parent/$f_folder" | rofi -dmenu -i -p "Song  " -matching fuzzy)
fi
f_song="$parent/$f_folder/$song"




if [[ $f_folder == "Play All" ]]; then
  hyprctl dispatch "hl.dsp.exec_cmd(\"mpv $fchoice/* & disown\", { float = true, size = {430, 430}, move = {170, 210} })"
elif [[ -z $f_folder ]]; then
  exit
else
  hyprctl dispatch "hl.dsp.exec_cmd(\"mpv '$f_song' & disown\", { float = true, size = {430, 430}, move = {170, 210} })"
fi


hyprctl dispatch 'hl.dsp.exec_cmd("kitty -- cava -p /home/rudra/scripts/app-groups/modules/mpv-cava.conf", { float = true, size = {467, 171}, move = {620, 310} })'


# cleaning up
rm "$folders_output"
