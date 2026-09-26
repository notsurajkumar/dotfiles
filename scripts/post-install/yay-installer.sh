#!/bin/bash

sudo pacman -Syu
sudo pacman -S git
sudo pacman -S --needed base-devel debugedit

cd ~
git clone https://aur.archlinux.org/yay-bin.git
cd yay-bin
makepkg -si
