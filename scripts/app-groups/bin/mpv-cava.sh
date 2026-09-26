#!/bin/bash

# opening cava with its config applied
hyprctl dispatch 'hl.dsp.exec_cmd("kitty -- cava -p /home/rudra/scripts/app-groups/modules/mpv-cava.conf", { float = true, size = {467, 171}, move = {620, 310} })'


# playing music using mpv
hyprctl dispatch 'hl.dsp.exec_cmd("mpv ~/tmp/songs/* & disown", { float = true, size = {430, 430}, move = {170, 210} })'
