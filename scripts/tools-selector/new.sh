#!/bin/bash

list='/home/rudra/scripts/tools-selector/list.md'
choices_list='/home/rudra/scripts/tools-selector/choiceslist'
performer='/home/rudra/scripts/tools-selector/performer'



while IFS= read -r line; do
  choices=$(echo $line | cut -d ":" -f1)
  echo "$choices" >> "$choices_list"
done < "$list"

selected=$(cat $choices_list | sort | uniq | gum filter \
  --header="Choose a tool to use" \
  --placeholder="type to search..." \
  --height=10) 

if [[ -z $selected ]]; then
  rm "$choices_list"
  exit
fi


action=$(grep -w "$selected" "$list" | cut -d ":" -f2)
final_action=$(echo "$action" | cut -b1 --complement)

if [[ -z $action ]]; then
  echo "No action to perform"
else
  echo
  eval "$final_action" 
fi


# cleanup
rm "$choices_list"
