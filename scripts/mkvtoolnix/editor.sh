#!/usr/bin/env bash
# Exit immediately if a command exits with a non-zero status
set -e

# 1. Check if required tools are installed
for cmd in gum mkvpropedit mkvmerge; do
    if ! command -v "$cmd" &> /dev/null; then
        echo "Error: Required tool '$cmd' is not installed. Install it via 'sudo pacman -S gum mkvtoolnix-cli'." >&2
        exit 1
    fi
done

# 2. Find all .mkv files in the current directory
mapfile -t mkv_files < <(find . -maxdepth 1 -name "*.mkv" -printf "%f\n" | sort)

if [ ${#mkv_files[@]} -eq 0 ]; then
    gum style --foreground 212 "No .mkv files found in the current directory!"
    exit 0
fi

# 3. Let the user select multiple files using gum
gum style --foreground 99 --bold "Select MKV files to edit (Space to select, Enter to confirm):"
selected_files=$(printf "%s\n" "${mkv_files[@]}" | gum choose --no-limit --height 15)

if [ -z "$selected_files" ]; then
    gum style --foreground 203 "No files selected. Exiting."
    exit 0
fi

# 4. Process each selected file
while IFS= read -r file; do
    [ -z "$file" ] && continue

    gum style --foreground 214 "Processing: $file"

    # Get filename without extension (.mkv)
    filename_no_ext="${file%.mkv}"

    # A. Change file title to filename without extension
    mkvpropedit "$file" --edit info --set title="$filename_no_ext"

    # B. Remove all audio track names dynamically
    audio_count=$(mkvmerge -i "$file" | grep -c "audio (")
    for ((i=1; i<=audio_count; i++)); do
        mkvpropedit "$file" --edit "track:a$i" --delete name 2>/dev/null || true
    done

    # C. Remove all subtitle track names dynamically
    sub_count=$(mkvmerge -i "$file" | grep -c "subtitles (")
    for ((i=1; i<=sub_count; i++)); do
        mkvpropedit "$file" --edit "track:s$i" --delete name 2>/dev/null || true
    done

    # D. Remove descriptions / global tags from the MKV file
    mkvpropedit "$file" --tags all: 2>/dev/null || true

    gum style --foreground 46 "✔ Completed: $file"
    echo "----------------------------------------"

done <<< "$selected_files"

gum style --foreground 46 --bold "All selected files have been successfully processed!"
