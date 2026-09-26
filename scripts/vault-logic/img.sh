#!/bin/bash

# LOCKED
# Define ANSI color codes
GREEN='\033[1;32m'
NC='\033[0m' # No Color

# Print the ASCII art in green
hola=$(echo -e "${GREEN}"
cat << "EOF"
  _     ___   ___ _  __ ___  ___ 
 | |   / _ \ / __| |/ /| __||   \
 | |__| (_) | (__| ' < | _| | |) |
 |____|\___/ \___|_|\_\|___||___/
EOF
echo -e "${NC}")




# UNLOCKED
# Define ANSI color code for Bright Red text
RED='\033[1;31m'
NC='\033[0m' # No Color

# Print the ASCII art in red
amigo=$(echo -e "${RED}"
cat << "EOF"
  _   _  _  _  _     ___   ___ _  __ ___  ___ 
 | | | || \| || |   / _ \ / __| |/ /| __||   \
 | |_| || .` || |__| (_) | (__| ' < | _| | |) |
  \___/ |_|\_\|____|\___/ \___|_|\_\|___||___/ 
EOF
echo -e "${NC}")


echo "$hola" "$amigo"
