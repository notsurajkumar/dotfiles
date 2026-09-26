#!/bin/sh

# ─────────────────────────────────────────────
# Header and banner
# ─────────────────────────────────────────────
echo
gum style \
    --border rounded \
    --padding "0 2" \
    --border-foreground 212 \
    "YouTube Videos Downloader (Multi)"
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
# File with links selector
# ─────────────────────────────────────────────
filename=$(ls -t | gum choose \
  --header "Choose file with links")

if [[ -z $filename ]]; then
  exit
fi



# ─────────────────────────────────────────────
# Confirmation
# ─────────────────────────────────────────────
gum style --foreground 212 "✔ Max quality : $choice"
gum style --foreground 212 "✔ File with links : $filename"

last=$(gum confirm "Start downloading?" && echo "yes" || echo "no")

if [[ $last == "no" ]]; then
  echo "exiting the downloader"
  exit
fi



# ─────────────────────────────────────────────
# Loop for fetching and downloading from links
# ─────────────────────────────────────────────
while IFS= read -r line; do
  url="$line"


  # ─────────────────────────────────────────────
  # final command
  # ─────────────────────────────────────────────
  if [[ -z $quality ]]; then
    final=$(echo "yt-dlp -f \"bestvideo[height<=1080]+bestaudio/best[height<=1080]\" $url")
  else
    final=$(echo "yt-dlp -f \"bestvideo[height<=${quality}]+bestaudio/best[height<=${quality}]\" $url")
  fi

  eval "$final"

done < "$filename"
