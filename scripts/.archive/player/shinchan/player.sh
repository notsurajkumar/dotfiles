name=$(find /mnt/D/Shinchan -type f \( -name "*.mkv" -o -name "*.mp4" \) | shuf -n 1) && vlc "$name"
