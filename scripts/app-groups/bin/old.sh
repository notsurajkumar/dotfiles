#!/bin/bash

INT='/home/rudra/Music/INT'
IND='/home/rudra/Music/IND'
BGM='/home/rudra/Music/BGM'
Phonk='/home/rudra/Music/Phonk'



choice=$(echo -e "INT\nIND\nBGM\nPhonk" | rofi -dmenu -i -p "Folder   " -matching fuzzy)
if [[ -z $choice ]]; then
  choice="music"
fi
fchoice="${!choice}"

list=$(
  echo "Play All"
  ls $fchoice
)
final=$(echo "$list" | rofi -dmenu -i -p "Choose   " -matching fuzzy)

if [[ $final == "Play All" ]]; then
  hyprctl dispatch "hl.dsp.exec_cmd(\"mpv $fchoice/* & disown\", { float = true, size = {430, 430}, move = {170, 210} })"
elif [[ -z $final ]]; then
  exit
else
  hyprctl dispatch "hl.dsp.exec_cmd(\"mpv '$fchoice/$final' & disown\", { float = true, size = {430, 430}, move = {170, 210} })"
fi


hyprctl dispatch 'hl.dsp.exec_cmd("kitty -- cava -p /home/rudra/scripts/app-groups/modules/mpv-cava.conf", { float = true, size = {467, 171}, move = {620, 310} })'
