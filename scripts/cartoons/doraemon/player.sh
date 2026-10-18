#!/bin/bash

links='/home/rudra/scripts/cartoons/doraemon/links.txt'

target_link=$(shuf -n 1 "$links")

mpv --force-window=immediate "$target_link" & disown
