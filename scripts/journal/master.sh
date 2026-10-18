#!/bin/bash

root='/home/rudra/scripts/journal'

choice=$(gum choose "TODAY" "PAST" "Navigate in TERMINAL")

if [[ $choice == "TODAY" ]]; then
  bash "$root/today.sh"
elif [[ $choice == "PAST" ]]; then
  bash "$root/past.sh"
elif [[ $choice == "Navigate in TERMINAL" ]]; then
  cd /home/rudra/Documents/journal
  fish -c 'ls'  
else
  exit
fi
  
