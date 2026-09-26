#!/usr/bin/env bash

# requires ffmpeg, imagemagick, yt-dlp, gum

set -euo pipefail

TMP_DIR="$(mktemp -d)"
trap 'rm -rf "$TMP_DIR"' EXIT

# Save in the directory from which the script was run
OUTPUT_DIR="$(pwd)"

echo

gum style \
    --border rounded \
    --padding "0 2" \
    --border-foreground 212 \
    "YouTube Music Downloader (Single)"

echo

# ─────────────────────────────────────────────
# Ask for URL
# ─────────────────────────────────────────────

LINK="$(gum input \
    --placeholder "Paste YouTube Music link..." \
    --prompt "URL: ")"

if [[ -z "$LINK" ]]; then
    echo "No URL provided."
    exit 1
fi

echo

# ─────────────────────────────────────────────
# Quality
# ─────────────────────────────────────────────

QUALITY="$(gum choose \
    --header "Select audio quality:" \
    "Best quality" \
    "320 kbps" \
    "256 kbps" \
    "192 kbps" \
    "128 kbps")"

if [[ -z "$QUALITY" ]]; then
    QUALITY='Best quality'
fi

echo

# ─────────────────────────────────────────────
# yt-dlp download
# ─────────────────────────────────────────────

OUTPUT_TEMPLATE="$TMP_DIR/%(title)s.%(ext)s"

echo "Downloading..."

if [[ "$QUALITY" == "Best quality" ]]; then

    yt-dlp \
        --no-playlist \
        -f "bestaudio" \
        -x \
        --audio-format mp3 \
        --audio-quality 0 \
        --write-thumbnail \
        --convert-thumbnails jpg \
        --embed-metadata \
        --no-mtime \
        -o "$OUTPUT_TEMPLATE" \
        "$LINK"

else

    BITRATE="${QUALITY% kbps}K"

    yt-dlp \
        --no-playlist \
        -f "bestaudio" \
        -x \
        --audio-format mp3 \
        --audio-quality "$BITRATE" \
        --write-thumbnail \
        --convert-thumbnails jpg \
        --embed-metadata \
        --no-mtime \
        -o "$OUTPUT_TEMPLATE" \
        "$LINK"

fi

echo
echo "Download finished."
echo "Processing artwork..."

# ─────────────────────────────────────────────
# Find MP3 + thumbnail
# ─────────────────────────────────────────────

AUDIO="$(find "$TMP_DIR" -maxdepth 1 -type f -iname '*.mp3' -print -quit)"

THUMB="$(find "$TMP_DIR" -maxdepth 1 -type f \
    \( -iname '*.jpg' -o -iname '*.jpeg' \) \
    -print -quit)"

if [[ -z "$AUDIO" ]]; then
    echo
    echo "ERROR: Could not find downloaded MP3."
    echo
    echo "Files actually downloaded:"
    find "$TMP_DIR" -maxdepth 1 -type f -printf '  %f\n'
    exit 1
fi

if [[ -z "$THUMB" ]]; then
    echo
    echo "ERROR: Could not find thumbnail."
    exit 1
fi

# ─────────────────────────────────────────────
# Make thumbnail square
# ─────────────────────────────────────────────

COVER="$TMP_DIR/cover.jpg"

SIZE="$(identify -format '%[fx:min(w,h)]' "$THUMB")"

magick "$THUMB" \
    -gravity center \
    -crop "${SIZE}x${SIZE}+0+0" \
    +repage \
    -quality 95 \
    "$COVER"

# ─────────────────────────────────────────────
# Final filename
# ─────────────────────────────────────────────

BASENAME="$(basename "$AUDIO")"
FINAL="$OUTPUT_DIR/$BASENAME"

# Avoid overwriting an existing song

if [[ -e "$FINAL" ]]; then
    FINAL="$OUTPUT_DIR/${BASENAME%.mp3} (1).mp3"

    COUNT=1
    while [[ -e "$FINAL" ]]; do
        COUNT=$((COUNT + 1))
        FINAL="$OUTPUT_DIR/${BASENAME%.mp3} ($COUNT).mp3"
    done
fi

# ─────────────────────────────────────────────
# Embed square artwork
# ─────────────────────────────────────────────

echo "Embedding square cover..."

ffmpeg \
    -hide_banner \
    -loglevel error \
    -i "$AUDIO" \
    -i "$COVER" \
    -map 0:a \
    -map 1:v \
    -c:a copy \
    -c:v mjpeg \
    -id3v2_version 3 \
    -metadata:s:v title="Album cover" \
    -metadata:s:v comment="Cover (front)" \
    "$FINAL"

# ─────────────────────────────────────────────
# Cleanup
# ─────────────────────────────────────────────

# The temporary directory contains:
# - original downloaded thumbnail
# - square cover
# - temporary MP3
#
# The EXIT trap deletes all of them automatically.
# Only the final MP3 remains in OUTPUT_DIR.

echo

gum style \
    --border rounded \
    --padding "0 2" \
    --border-foreground 42 \
    "Download complete!" \
    "" \
    "Saved to:" \
    "$FINAL"

echo


