#!/bin/bash

# record all inputs

name=$(gum input --prompt="Enter name of file : " --placeholder="without .desktop")
rname=$(gum input --prompt="Enter name for rofi : " --placeholder="starts with capital")
link=$(gum input --prompt="Enter link of webapp : " --placeholder="without https://")
icon=$(gum input --prompt="Enter name of icon file : " --placeholder="stored in ./icons with filename.png")
key=$(gum input --prompt="Enter Keywords : " --placeholder="seperated and ends with ;")


###

gum style --foreground 212 "✔ Filename : $name"
gum style --foreground 212 "✔ Rofi Search Term : $rname"
gum style --foreground 212 "✔ Link Used : $link"
gum style --foreground 212 "✔ Icon Used : $icon"
gum style --foreground 212 "✔ Keywords : $key"
echo

###

direc="/home/rudra/.local/share/applications/webapps"
prelink="/opt/brave-bin/brave --profile-directory=Default --new-window --app=https://"

###

choice=$(gum choose "Yes" "No" --header="Do you want to create $name.desktop for $rname ($link) in .local/share/applications/webapps?")

if [[ $choice == Yes ]]; then
  touch "$direc/$name.desktop"
  cat $direc/template > $direc/$name.desktop
  echo "Name=$rname" >> $direc/$name.desktop
  echo "Exec=$prelink$link" >> $direc/$name.desktop
  echo "Icon=$direc/icons/$icon" >> $direc/$name.desktop
  echo "Keywords=$key" >> $direc/$name.desktop
  echo 
  gum style --foreground="#f09f01" ">>> $name.desktop created! : Webapp launcher for $rname"

else
 gum style --foreground="#f09f01" ">>> $name.desktop NOT created"

fi

echo 
sleep 5 
