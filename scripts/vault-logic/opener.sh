#!/bin/bash

#########################################################################################
# COMMON
#########################################################################################
common=$(
cat << "EOF"
 - cd ..
 - lock-folder vault 
 - for help, go to ~/notes/lock-folders/readme.md
 - manuall go to ~/Personal/vault after unlocking it (fish vs bash)

------------------------------------------------------


EOF
)


#########################################################################################
# LOCKED
#########################################################################################

GREEN='\033[1;32m'
NC='\033[0m' # No Color

hola=$(echo -e "${GREEN}"
cat << "EOF"
  _     ___   ___ _  __ ___  ___ 
 | |   / _ \ / __| |/ /| __||   \
 | |__| (_) | (__| ' < | _| | |) |
 |____|\___/ \___|_|\_\|___||___/
EOF
echo -e "${NC}")




#########################################################################################
# UNLOCKED
#########################################################################################
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



#########################################################################################
# REAL LOGIC
#########################################################################################

files=$(ls ~/Personal/vault)

if [[ -z $files ]]; then
  state='locked'
else
  state='unlocked'
fi

# IF IT IS LOCKED
#if [[ $state == "locked" ]]; then
#  echo "$hola"
#  echo "$common"
#  cd ~/Personal/ || return
#  fish -c 'unlock-folder vault'
#  cd vault || return
#  echo "------------------------------------------------------"
#  echo
#  fish -c 'lsa'
#  echo
#  echo "------------------------------------------------------"
##  bash -c 'fish'
#  exit
#  :
   

# IF IT IS LOCKED
if [[ $state == "locked" ]]; then
  echo "$hola"
  echo "$common"
  cd ~/Personal/ || return
  fish -c 'unlock-folder vault '  
  cd vault || return
  echo "------------------------------------------------------"
  echo
  fish -c 'lsa'
  echo
  echo "------------------------------------------------------"


  

# IF IT IS UNLOCKED
else
  echo "$amigo"
  echo "$common"
  cd ~/Personal/vault/ || return 
  echo
  fish -c 'lsa'
  echo
  echo "------------------------------------------------------"
  :

fi
