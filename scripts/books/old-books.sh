#!/bin/bash

dir='/mnt/E/Documents/e-books'
tmp='/home/rudra/scripts/books/tmp'
rud='/home/rudra/scripts/books/names'

# print all book names
names=$(find "$dir" -iname "*.pdf")

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
