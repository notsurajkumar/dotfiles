#!/bin/bash

wallpaper_dir=$(awww query | rev | cut -d ":" -f1 | rev | awk '{print $1}')
wallust run -s $wallpaper_dir && killall waybar && waybar & disown
