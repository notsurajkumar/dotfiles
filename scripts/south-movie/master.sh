#!/bin/bash

choice=$(gum choose "Play Movies" "Add/Remove Movies" --header="Select a option to execute")

if [[ $choice == "Add/Remove Movies" ]]; then
  bash /home/rudra/scripts/south-movie/edit.sh
elif [[ $choice == "Play Movies" ]]; then
  bash /home/rudra/scripts/south-movie/play.sh
fi
