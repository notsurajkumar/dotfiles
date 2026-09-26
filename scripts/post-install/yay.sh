#!/bin/bash

yay_file="/home/rudra/scripts/post-install/yay.md"

packages=$(
  while IFS= read -r line; do
    printf "$line "
  done < "$yay_file"
)

echo
yay -S $packages
echo
yay -Q $packages
