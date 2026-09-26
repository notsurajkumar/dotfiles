#!/bin/bash


# recording date 
month=$(date | awk '{print $2}')
date=$(date | awk '{print $3}')
time=$(date | awk '{print $4}' | cut -d ":" -f1-2)
am_pm=$(date | awk '{print $5}')
folder_name=$(echo "$date-$month $time $am_pm")


locn='/home/rudra/scripts/dotfiles'
master='/home/rudra/.config'
target='/home/rudra/paste'


# checking folder existence
check=$(test -d "$target/$folder_name" && echo "exists" || echo "dne")

# if backup does not exist
if [[ $check == "dne" ]]; then
  # creating folders and files
  mkdir "$target/$folder_name/"
  mkdir "$target/$folder_name/dotfiles/"
  mkdir "$target/$folder_name/personal/"
  touch "$target/$folder_name/readme.md"

  # copying all dotfiles
  while IFS= read -r line; do
    eval "cp -r $master/$line/ \"$target/$folder_name/dotfiles/\""
  done < $locn/config.md

  # copying all personal files
  while IFS= read -r line; do
    eval "cp -r $line/ \"$target/$folder_name/personal\""
  done < $locn/personal.md

  # custom readme file
  choice=$(gum choose "yes" "no")
  if [[ $choice == "yes" ]]; then
    nvim "$target/$folder_name/readme.md"
  else
    rm "$target/$folder_name/readme.md"
  fi

  # backup folder name 
  echo 
  echo "Backup created : $folder_name"


  # showing all copied dotfiles
  echo
  echo "⭕️ COPIED DOTFILES : ⭕️"
  ls -lh --color=always "$target/$folder_name/dotfiles/" | tail -n +2
  echo
  echo


  # showing all copied personal files
  echo
  echo "⭕️ COPIED PERSONAL FILES: ⭕️"
  ls -lh --color=always "$target/$folder_name/personal/" | tail -n +2
  echo
  echo







# if backup already exists
else
  echo "backup already exists, so check it out"
fi



