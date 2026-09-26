#!/bin/bash

sleep 3
while IFS= read -r line; do
  cp /home/rudra/Pictures/wallpapers/wallpapers/$line /home/rudra/Pictures/wallpapers/nature/ 
done < final.md
