#!/bin/bash

root="/home/rudra/scripts/webapps"
choice=$( gum choose "Create NEW webapp" "EDIT existing webapp" "Navigate in TERMINAL" --header "WEBAPP CREATOR & EDITOR")


if [[ $choice == "Create NEW webapp" ]]; then
  bash "$root/create.sh"
elif [[ $choice == "EDIT existing webapp" ]]; then
  bash "$root/editor.sh"
elif [[ $choice == "Navigate in TERMINAL" ]]; then
  source "$root/terminal.sh"
fi
