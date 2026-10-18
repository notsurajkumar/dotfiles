#!/bin/bash

date=$(date | cut -d " " -f3)
month=$(date | cut -d " " -f2)
year=$(date | cut -d " " -f7)

if [[ $month == Jun ]]; then
  nmonth="06"

elif [[ $month == Jul ]]; then
  nmonth="07"
fi

file="/home/rudra/scripts/journal/$date-$nmonth-$year.md"

choice=$(gum choose "Today" "Older")
template="/home/rudra/scripts/journal/template.md"


if [[ $choice == Today ]]; then
 search=$(find -wholename "$file")

 if [[ -z $search ]]; then
   cat $template > $file && nvim $file
 else
   nvim $file
 fi



elif [[ $choice == Older ]]; then
  ochoice=$(find . -type f -wholename "*.md" -printf "%T@ %f\n" | cut -d " " -f2 | gum filter --header="Choose which entry to edit" --placeholder="Search by date") 

  if [[ -z $ochoice ]]; then
    exit
  else 
    nvim $ochoice
  fi
fi

