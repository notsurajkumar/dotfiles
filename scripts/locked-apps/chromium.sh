#!/bin/bash

echo
printf "   Enter password: "
read -rs pass
echo

if [[ $pass == "dontbreachme" ]]; then
  setsid /usr/bin/chromium >/dev/null 2>&1 < /dev/null &
  sleep 2 
fi

exit 0
