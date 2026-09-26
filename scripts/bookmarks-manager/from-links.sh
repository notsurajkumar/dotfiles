#!/bin/bash

brave_cmd='brave --profile-directory=Default '
links='/home/rudra/scripts/bookmarks-manager/links.md'
all_sites='/home/rudra/scripts/bookmarks-manager/all_sites'

while IFS= read -r line; do
  site=$(echo $line | awk -F "|" '{print $1}')
  echo "$site" >> $all_sites
done < "$links" 

selection=$(cat $all_sites | rofi -dmenu -i -p "Links   ")
$brave_cmd $selection


# cleaning up
rm $all_sites
