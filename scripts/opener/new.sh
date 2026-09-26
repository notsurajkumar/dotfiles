#!/bin/bash

no=$(wc -l < links)
echo
echo
echo "Do you want to open $no links?"
echo
choice=$(gum choose "Yes" "No")

if [[ $choice == "Yes" ]]; then
  pre='brave --incognito'

  brave --new-window --incognito
  while IFS= read -r line; do
    $pre $line
  done < links
else
  exit
fi


