#!/bin/bash

# REPLACE THE PATH BELOW WITH THE COMPLETE LOCATION OF YOUR dates.txt FILE
FILE="/home/rudra/scripts/.archive/reminder/dates.txt"

# Ensure the file exists
if [[ ! -f "$FILE" ]]; then
    echo "Error: File '$FILE' not found."
    echo "Please edit the script and add the correct path."
    exit 1
fi

# Get today's timestamp and current year
current_ts=$(date -d "today 00:00:00" +%s)
current_year=$(date +%Y)

closest_diff=-1
closest_lines=""

# Read the file line by line
while IFS= read -r line || [[ -n "$line" ]]; do
    # Remove hidden Windows carriage return (\r) characters
    line="${line%$'\r'}"

    # Skip empty lines and headers starting with #
    if [[ -z "$line" ]] || [[ "$line" == \#* ]]; then
        continue
    fi

    # Check if the line contains ' - ' (our expected delimiter)
    if [[ "$line" == *" - "* ]]; then
        # Split the line by ' - ' and trim extra spaces
        date_part=$(echo "$line" | awk -F' - ' '{print $1}' | xargs)
        name=$(echo "$line" | awk -F' - ' '{print $2}' | xargs)
        event=$(echo "$line" | awk -F' - ' '{print $3}' | xargs)

        # Split dd and mm
        IFS='/' read -r dd mm <<< "$date_part"

        # Clean leading zeros for math calculations
        dd_num=$((10#$dd))
        mm_num=$((10#$mm))

        # Format strictly for the date command (YYYY-MM-DD)
        dd_fmt=$(printf "%02d" "$dd_num")
        mm_fmt=$(printf "%02d" "$mm_num")

        event_date="${current_year}-${mm_fmt}-${dd_fmt}"
        event_ts=$(date -d "$event_date 00:00:00" +%s 2>/dev/null)

        # Skip if the date is invalid
        if [[ -z "$event_ts" ]]; then
            continue 
        fi

        # If the event passed this year, calculate for next year
        if (( event_ts < current_ts )); then
            next_year=$((current_year + 1))
            event_date="${next_year}-${mm_fmt}-${dd_fmt}"
            event_ts=$(date -d "$event_date 00:00:00" +%s 2>/dev/null)
        fi

        # Calculate difference in days
        diff_sec=$((event_ts - current_ts))
        diff_days=$((diff_sec / 86400))

        # Get full month name and convert to lowercase
        month_name=$(date -d "$event_date" +%B | tr '[:upper:]' '[:lower:]')

        # Format the output string
        if (( diff_days == 0 )); then
            formatted_line="0 days left : ${dd_num} ${month_name} : ${name} (${event}) (Today!)"
        else
            formatted_line="${diff_days} days left : ${dd_num} ${month_name} : ${name} (${event})"
        fi

        # Check if this is the closest event we've found so far
        if (( closest_diff == -1 || diff_days < closest_diff )); then
            closest_diff=$diff_days
            closest_lines="$formatted_line"
        elif (( diff_days == closest_diff )); then
            # If multiple events happen on the exact same closest day, append them
            closest_lines="${closest_lines}"$'\n'"${formatted_line}"
        fi
    fi
done < "$FILE"

# Print the result
if [[ -n "$closest_lines" ]]; then
    echo "$closest_lines"
else
    echo "No upcoming events found."
fi
