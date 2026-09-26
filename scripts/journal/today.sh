#!/bin/bash

template_folder='/home/rudra/scripts/journal/templates'
parent_out='/home/rudra/Documents/journal'

# time calculation
date=$(date +%d)
month=$(date +%m)
year=$(date +%Y)

name="$date-$month.md"

# check if file already exists (0 = DNE)
check=$(find "$parent_out/$year/" -name "$name")

if [[ -z $check ]]; then
  var_1='0'
  template=$(ls $template_folder | gum choose --header="Choose a template to use")
  cat "$template_folder/$template" > "$parent_out/$year/$name"
  nvim "$parent_out/$year/$name"
else
  var_1='1'
  nvim "$parent_out/$year/$name"
fi

