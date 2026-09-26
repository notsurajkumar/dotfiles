#!/bin/bash


RED='\033[1;31m'
NC='\033[0m' # No Color

amigo=$(echo -e "${RED}"
cat << "EOF"
  _   _  _  _  _     ___   ___ _  __ ___  ___ 
 | | | || \| || |   / _ \ / __| |/ /| __||   \
 | |_| || .` || |__| (_) | (__| ' < | _| | |) |
  \___/ |_|\_\|____|\___/ \___|_|\_\|___||___/ 
EOF
echo -e "${NC}")

#################################################################

files=$(ls ~/Personal/vault)

if [[ -z $files ]]; then
  state='locked'
else
  state='unlocked'
fi

# IF IT IS LOCKED
if [[ $state == "locked" ]]; then
  echo
  echo "Personal Vault is Locked" 
  echo
else
  echo "$amigo"
  choice=$(gum confirm "Do you want to lock personal vault" --affirmative="Lock" --negative="Exit" --selected.background="#61c8c8" --selected.foreground="#000000" --selected.bold && echo "yes")

  if [[ $choice == "yes" ]]; then
    cd ~/Personal/ || return
    fish -c 'lock-folder vault'
    echo
    cd "$OLDPWD"

  else
    echo "Personal Vault is unlocked!!!"
    echo
  fi

fi
