#!/bin/bash

#hyprctl dispatch exec "[float] kitty"


output=$(cat ~/scripts/keyboard-shortcuts/list.conf | column -s ':' -t)
echo "$output" | fzf --no-sort --reverse --highlight-line --ghost="Search keybindings..." --preview-border=rounded

while IFS= read -r line || [[ -n "$line" ]]; do
  key=$( echo $line | cut -d ":" -f1 )
  fun=$( echo $line | cut -d ":" -f2 )
  #printf "\n$key"
done < list.conf

printf "\n"
