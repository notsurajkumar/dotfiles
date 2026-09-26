#!/bin/bash

# temporary files and other files
dates='/home/rudra/scripts/dates-reminder/dates.md'
out_dates='/home/rudra/scripts/dates-reminder/out_dates.tmp'
sorted_out_dates='/home/rudra/scripts/dates-reminder/sorted_out_dates.tmp'
multiple_events='/home/rudra/scripts/dates-reminder/multiple_events.tmp'


# today
pdate=$(date +%d)
pmonth=$(date +%m)


# extract the date/month
while IFS= read -r line; do 
  first=$(echo $line | cut -b1)

  if [[ -n $line && $first != "#" ]]; then
    date=$(echo $line | cut -d "/" -f1)
    month=$(echo $line | cut -d "/" -f2 | awk '{print $1}')

    # append only dates which are today and later
    if (( 10#$month >= 10#$pmonth && 10#$date >= 10#$pdate )); then
      echo "$date $month" >> $out_dates 
    fi

  fi

done < "$dates"

# extract just the sorted uniq date/months
cat "$out_dates" | sort | uniq > $sorted_out_dates 


# calculation of closest date
closest=367

while IFS= read -r line; do 
  date=$(echo $line | awk '{print $1}')
  month=$(echo $line | awk '{print $2}')
  time_left=$((($(date -d "2026-$month-$date" +%s) - $(date -d "2026-$pmonth-$pdate" +%s)) / 86400 ))


  if (( "$time_left" <= "$closest" )); then
    nearest="$line"
    closest="$time_left"
  else
    :
  fi


done < $sorted_out_dates
  



# nearest date/month 
#echo $nearest

# displaying the event
fdate=$(echo $nearest | awk '{print $1}')
fmonth=$(echo $nearest | awk '{print $2}')
fdate_complete="$fdate/$fmonth"

event_line=$(grep -w "$fdate_complete" $dates)
no_of_events=$(grep -w "$fdate_complete" $dates | wc -l )

# final display
short_final_month=$(date -d "2026-$fmonth-01" '+%b')

if [[ $no_of_events == 1 ]]; then
  primary_event=$(echo $event_line | cut -d ":" -f2-100 | awk '{$1=$1; print}')
  echo
  echo "$closest day(s) left for"
  echo "$fdate $short_final_month -> $primary_event"
else
  echo "$event_line" > "$multiple_events"
  echo
  echo "Multiple events in $closest day(s)"
  echo

  while IFS= read -r line; do 
    primary_event=$(echo "$line" | cut -d ":" -f2-100 | awk '{$1=$1; print}')
    echo "$fdate $short_final_month -> $primary_event"
  done < "$multiple_events"
rm "$multiple_events"
fi





  



# cleaning up
rm "$out_dates" 
rm "$sorted_out_dates"
