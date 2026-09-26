#!/bin/bash

# Suppress the yellow imap_codec warning entirely
exec 2>/dev/null

(
    # 1. Print Header Names separated by a single tilde (~)
    echo "TIME~SENDER~SUBJECT"
    
    # 2. Process, FILTER FOR UNREAD, and inject the data rows
    himalaya envelope list --output json | jq -r '
      .[] | 
      select(.flags == null or (.flags | index("Seen") == null and index("\\Seen") == null)) | 
      "\(.date)~\([.from.name, .from.addr] | select(.[0] != null) | "[\(.[0])] \(.[1])" // .[1])~\(.subject)"
    ' | while IFS='~' read -r raw_date sender subject; do
        # Format the timestamp into exact 12hr "23 May 05:43 PM" format
        formatted_date=$(date -d "$raw_date" +"%d %b %I:%M %p")
        echo "$formatted_date~$sender~$subject"
    done
) | column -t -s '~' -o ' │ ' | awk '
    NR==1 { 
        print $0;
        # Automatically generate a perfect horizontal dividing line matching the calculated widths
        line = $0;
        gsub(/[^│]/, "─", line);
        gsub(/│/, "┼", line);
        print line;
        next;
    } 
    { print $0; }
'
