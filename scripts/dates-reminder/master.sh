#!/bin/bash

dell=$(gum choose "View closest event" \
  "Search for an event" \
  "Edit list")

if [[ $dell == "View closest event" ]]; then
  bash /home/rudra/scripts/dates-reminder/reminder.sh
elif [[ $dell == "Edit list" ]]; then
  nvim /home/rudra/scripts/dates-reminder/dates.md
elif [[ $dell == "Search for an event" ]]; then
  bash /home/rudra/scripts/dates-reminder/search.sh
fi
