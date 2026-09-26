#!/bin/sh



# ─────────────────────────────────────────────
# Banner and greeter
# ─────────────────────────────────────────────
echo
gum style \
    --border rounded \
    --padding "0 2" \
    --border-foreground 212 \
    "YouTube Videos Downloader (Single)"
echo


# ─────────────────────────────────────────────
# Maximum quality selector
# ─────────────────────────────────────────────
choice=$(gum choose "2160p" \
  "1440p" \
  "1080p" \
  "720p" \
  "480p" \
  "360p" \
  "240p" \
  "144p" \
  --header="Choose max video quality")

quality=$(echo "$choice" | rev | cut -b1 --complement | rev)

# ─────────────────────────────────────────────
# Link input
# ─────────────────────────────────────────────
url=$(gum input \
  --placeholder "Paste YouTube Video Link..." \
  --prompt "URL: ")

if [[ -z "$url" ]]; then
    echo "No URL provided."
    exit 
fi


# ─────────────────────────────────────────────
# Final command
# ─────────────────────────────────────────────
if [[ -z $quality ]]; then
  final=$(echo "yt-dlp -f \"bestvideo[height<=1080]+bestaudio/best[height<=1080]\" $url")
else
  final=$(echo "yt-dlp -f \"bestvideo[height<=${quality}]+bestaudio/best[height<=${quality}]\" $url")
fi


# ─────────────────────────────────────────────
# Confirmation
# ─────────────────────────────────────────────
gum style --foreground 212 "✔ Max quality : $choice"
gum style --foreground 212 "✔ URL : $url"

last=$(gum confirm "Start downloading?" && echo "yes" || echo "no")

if [[ $last == "yes" ]]; then
  eval $final
else
  exit
fi
