#!/bin/bash

dir='/home/rudra/Videos/movies/'
tmp='/home/rudra/scripts/movies/tmp'
rud='/home/rudra/scripts/movies/rud'
nrud='/home/rudra/scripts/movies/nrud'

rm "$tmp"
rm "$rud"
rm "$nrud"

names=$(find "$dir" -type f \( -name "*.mkv" -o -name "*.mp4" -o -name "*.webp" -o -name "*.avi" -o -name "*.webm" \))


echo "$names" > "$tmp"

while IFS= read -r line; do
  names=$(echo "$line" | rev | cut -d '/' -f1 | rev >> $rud)
done < "$tmp"

while IFS= read -r line; do
  names=$(echo "$line" | rev | cut -d '.' -f1 --complement | rev >> $nrud)
done < "$rud"

selected=$(cat "$nrud" | rofi -dmenu -theme-str 'listview { columns : 1; }' -theme-str 'element-icon { enabled : false; }' -i -p "Movie  ")
sfinal=$(grep "$selected" "$rud")
final=$(find "$dir" -iname "$sfinal")

#echo "$selected"
#echo "$sfinal"
#echo "$final"

if [[ -z $final ]]; then
  exit 
  rm "$tmp"
  rm "$rud"
  rm "$nrud"
else
  #mpv "$final" &
  #vlc "$final" &
  #set -lx QT_SCALE_FACTOR 1.5; vlc "$final" &
  #set -lx QT_SCALE_FACTOR 1.5; vlc
  QT_SCALE_FACTOR=1.5 vlc "$final" & disown
  echo "QT_SCALE_FACTOR=1.5 vlc \"$final\" & disown"
fi

rm "$tmp"
rm "$rud"
rm "$nrud"
