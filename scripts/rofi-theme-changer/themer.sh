#!/bin/bash

themes_direc='/home/rudra/.config/rofi/my-themes'
final_theme='/home/rudra/.config/rofi/auto-themer/auto.rasi'
themes=$(ls $themes_direc)

final_theme_list=$(
while IFS= read -r line; do
  echo $line | cut -d "." -f1
done <<< $themes
)

selected=$(echo "$final_theme_list" | rofi -i -dmenu -theme-str 'listview { columns : 1; }' -theme-str 'element-icon { enabled : false; }' -display-columns 1 -p "Select a theme   ")

target=$( echo "$themes_direc/$selected.rasi")

cat $target > $final_theme && rofi -show drun
