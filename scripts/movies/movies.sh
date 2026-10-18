#!/bin/bash

dir='/home/rudra/Videos/movies/'
tmp='/home/rudra/scripts/movies/tmp'
rud='/home/rudra/scripts/movies/rud'

names=$(find "$dir" -type f \( -name "*.mkv" -o -name "*.mp4" -o -name "*.webp" -o -name "*.avi" \))


echo "$names" > "$tmp"

while IFS= read -r line; do
  names=$(echo "$line" | rev | cut -d '/' -f1 | rev >> $rud)
done < "$tmp"

selected=$(cat "$rud" | rofi -dmenu -i -p "Movie  ")
final=$(find "$dir" -iname "$selected")

if [[ -z $final ]]; then
  break
else
  #mpv "$final" &
  #vlc "$final" &
  #set -lx QT_SCALE_FACTOR 1.5; vlc "$final" &
  #set -lx QT_SCALE_FACTOR 1.5; vlc
  QT_SCALE_FACTOR=1.5 vlc "$final" & disown
fi

rm "$tmp"
rm "$rud"
