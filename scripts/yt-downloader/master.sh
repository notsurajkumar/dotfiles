#!/bin/bash

media=$(gum choose "Audio" "Video" --header="Choose media to download")

if [[ $media == "Video" ]]; then
  select=$(gum choose "single" "multi" --header="How many videos to download?")

  single='/home/rudra/scripts/yt-downloader/single.sh'
  multi='/home/rudra/scripts/yt-downloader/multi.sh'

  if [[ $select == "single" ]]; then
    bash $single
  elif [[ $select == "multi" ]]; then
    bash "$multi"
  fi

elif [[ $media == "Audio" ]]; then
  select=$(gum choose "single" "multi" --header="How many songs to download?")

  single='/home/rudra/scripts/yt-downloader/audio/single.sh'
  multi='/home/rudra/scripts/yt-downloader/audio/multi.sh'

  if [[ $select == "single" ]]; then
    bash $single
  elif [[ $select == "multi" ]]; then
    bash "$multi"
  fi


fi
