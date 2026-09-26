#!/bin/bash

dir='/mnt/E/Videos/movies/'
tmp='/home/rudra/scripts/movies/tmp'
rud='/home/rudra/scripts/movies/names'

# print all folder names
folders=$(ls "$dir")
folder=$(printf "All Books\n$folders" | rofi -dmenu -i -p "Subject  ")

printf"$folder"
# print all book names
# print all book names
if [[ $folder == 'All Books' ]]; then
  names=$(find "$dir" -iname "*.pdf")
else
  names=$(find "$dir/$folder" -iname "*.pdf")
fi

echo "$names" > "$tmp"

while IFS= read -r line; do
  names=$(echo "$line" | rev | cut -d '/' -f1 | rev >> $rud)
done < "$tmp"

selected=$(cat "$rud" | rofi -dmenu -i -p "Book  ")
final=$(find "$dir" -iname "$selected")

if [[ -z $final ]]; then
  break
else
  brave "$final" &
fi

rm "$tmp"
rm "$rud"
