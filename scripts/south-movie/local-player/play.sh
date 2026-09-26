#!/bin/bash

master='/home/rudra/scripts/south-movie/local-player'
folder=$(cat $master/directories | cut -d ":" -f1 | fzf --reverse --highlight-line --ghost="Select folder to play movies from")
direc=$(grep "$folder" $master/directories | cut -d ":" -f2 | cut -b1 --complement)
direc_name=$(grep "$direc" $master/directories | cut -d ":" -f1)
#command=$(echo "ls $direc")
#eval $command > tmp && cat tmp | rev | cut -d "." -f1 | rev 

command=$(find "$direc" -maxdepth 1 -type f)


# name wihtout directory 
name=$(echo "$command" | rev | cut -d "/" -f1 | rev | sort)
echo "$name" > $master/names


# checking extension

while IFS= read -r line; do
  extension=$(echo $line | rev | cut -d "." -f1 | rev )
  check=$(grep "$extension" $master/extensions)

  if [[ -n $check ]]; then
    # name without extension
    final_name=$(echo "$line" | rev | cut -d "." -f1 --complement | rev) 
    echo "$final_name" 
  fi
done < $master/names > $master/final_names



selected=$(cat $master/final_names | sort | fzf --reverse --highlight-line --ghost="Select movie to play from $direc_name")


while IFS= read -r line; do
  hola=$(echo "$line" | rev | cut -d "." -f2-100 | rev)

  if [[ $hola == $selected ]]; then
    amigo=$(echo $line)
  else
    :
  fi
done < $master/names

final=$(echo "$direc/$amigo")


choice=$(gum choose "VLC" "MPV" --header="Choose a video player")
if [[ $choice == "VLC" ]]; then
  echo
  echo
  echo "Playing $selected using $choice!!!"
  echo
  echo
  vlc "$final" & disown
elif [[ $choice == "MPV" ]]; then
  echo
  echo
  echo "Playing $selected using $choice!!!"
  echo
  echo
  mpv "$final" & disown
fi



# cleaning up
rm $master/names 
rm $master/final_names
