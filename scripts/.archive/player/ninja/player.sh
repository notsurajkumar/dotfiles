name=$(find "/mnt/D/Ninja Hattori/" -type f \( -name "*.mkv" -o -name "*.mp4" \) | shuf -n 1) && mpv "$name"
