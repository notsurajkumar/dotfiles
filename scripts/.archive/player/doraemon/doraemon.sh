#!/bin/bash

link=$(shuf -n 1 ~/scripts/player/doraemon/links.txt)
mpv --force-window=immediate "$link" &> /dev/null & disown
