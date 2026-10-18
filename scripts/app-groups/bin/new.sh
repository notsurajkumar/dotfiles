#!/bin/bash

INT='/home/rudra/Music/INT'
IND='/home/rudra/Music/IND'
BGM='/home/rudra/Music/BGM'
Funk='/home/rudra/Music/Funk'



choice=$(echo -e "Play All\nINT\nIND\nBGM\nFunk" | rofi -dmenu -i -p "Folder   " -matching fuzzy)
if [[ -z $choice ]]; then
  choice="INT"
  fchoice="${!choice}"
elif [[ $choice != "Play All" ]]; then
  fchoice="${!choice}"
elif [[ $choice == "Play All" ]]; then
  fchoice=""
fi

if [[ $fchoice != "" ]]; then
  list=$(
    echo "Play All"
    ls $fchoice
  )
  final=$(echo "$list" | rofi -dmenu -i -p "Choose   " -matching fuzzy)

  if [[ $final == "Play All" ]]; then
    hyprctl dispatch "hl.dsp.exec_cmd(\"mpv --shuffle $fchoice/* & disown\", { float = true, size = {430, 430}, move = {170, 210} })"
  elif [[ -z $final ]]; then
    exit
  else
    hyprctl dispatch "hl.dsp.exec_cmd(\"mpv --shuffle '$fchoice/$final' & disown\", { float = true, size = {430, 430}, move = {170, 210} })"
  fi

elif [[ $fchoice == "" ]]; then
  hyprctl dispatch "hl.dsp.exec_cmd(\"mpv --shuffle ~/Music & disown\", { float = true, size = {430, 430}, move = {170, 210} })"

fi

  hyprctl dispatch 'hl.dsp.exec_cmd("kitty -- cava -p /home/rudra/scripts/app-groups/modules/mpv-cava.conf", { float = true, size = {467, 171}, move = {620, 310} })'
