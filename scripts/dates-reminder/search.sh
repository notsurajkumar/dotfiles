#!/bin/bash

# temporary files and other files
dates='/home/rudra/scripts/dates-reminder/dates.md'
out_events='/home/rudra/scripts/dates-reminder/out_events.tmp'
sorted_out_dates='/home/rudra/scripts/dates-reminder/sorted_out_dates.tmp'
multiple_events='/home/rudra/scripts/dates-reminder/multiple_events.tmp'


# today
pdate=$(date +%d)
pmonth=$(date +%m)


while IFS= read -r line; do 
  event=$(echo "$line" | cut -d ":" -f2-100)
  echo "$event" >> "$out_events"
done < "$dates"


# selecting event
selected_event=$(cat "$out_events" | fzf)
selected_line=$(grep -w "$selected_event" "$dates")

date=$(echo $selected_event | cut -b1-2)
month=$(echo $selected_event | cut -b4-5)

# calculating time left
time_left=$((($(date -d "2026-$month-$date" +%s) - $(date -d "2026-$pmonth-$pdate" +%s)) / 86400 ))


primary_event=$(echo $selected_event | cut -d ":" -f2-100 | awk '{$1=$1; print}')
short_final_month=$(date -d "2026-$month-01" '+%b')
echo "$time_left day(s) left for"
echo "$date $short_final_month -> $primary_event"

# cleaning up
rm "$out_events"
