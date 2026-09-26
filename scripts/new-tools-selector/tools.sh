#!/bin/bash

list='/home/rudra/scripts/new-tools-selector/list.md'
choices_list='/home/rudra/scripts/new-tools-selector/choiceslist'

# Temporary choices file
: > "$choices_list"

while IFS= read -r line; do
    # Ignore empty lines and comments
    [[ -z "$line" || "$line" == \#* ]] && continue

    choices="${line%%:*}"
    echo "$choices" >> "$choices_list"
done < "$list"

selected=$(
    sort -u "$choices_list" |
    gum filter \
        --header="Choose a tool to use" \
        --placeholder="type to search..." \
        --height=10
)

# Cleanup
rm -f "$choices_list"

# Nothing selected
if [[ -z "$selected" ]]; then
    exit 0
fi

# Find corresponding action
while IFS= read -r line; do
    choice="${line%%:*}"

    if [[ "$choice" == "$selected" ]]; then
        action="${line#*:}"
        break
    fi
done < "$list"

# Remove the space after :
action="${action#"${action%%[![:space:]]*}"}"

if [[ -z "$action" ]]; then
    echo "No action to perform" >&2
    exit 1
fi

# IMPORTANT:
# Do NOT execute the command here.
# Print it so that the parent fish shell can execute it.
printf '%s\n' "$action"
