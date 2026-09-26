#!/bin/bash

pacman_file="/home/rudra/scripts/post-install/pacman.md"

packages=$(
  while IFS= read -r line; do
    printf "$line "
  done < "$pacman_file"
)

sudo pacman -Syu
echo
sudo pacman -S $packages
echo
pacman -Q $packages
