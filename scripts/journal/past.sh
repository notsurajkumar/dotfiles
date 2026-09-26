#!/bin/bash

template='/home/rudra/scripts/journal/template.md'
parent_out='/home/rudra/Documents/journal'

year=$(ls $parent_out | gum choose --header="Choose a year")

if [[ -z $year ]]; then
  exit
fi

final_folder="$parent_out/$year"


entry=$(ls $final_folder | gum choose --header="Choose a entry")

if [[ -z $entry ]]; then
  :
else 
  nvim "$final_folder/$entry"
fi
