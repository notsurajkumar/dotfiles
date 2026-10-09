#!/bin/bash 

# defining wallpapers master folder 
swallpaper_dire="/home/rudra/Pictures/wallpapers"

files=$(ls $swallpaper_dire)

choice=$( printf "$files\nAll Wallpapers" | rofi -dmenu -i -p "Select a folder   ")

if [[ -n $choice ]]; then

  if [[ $choice != "All Wallpapers" ]]; then

    WALLPAPER_DIR=$(echo $swallpaper_dire/$choice)

    # 2. Check if the directory exists
    if [ ! -d "$WALLPAPER_DIR" ]; then
        echo "Directory $WALLPAPER_DIR does not exist."
        exit 1
    fi

    # 3. Generate the rofi input with embedded icon paths
    # This loops through the files and formats each line as: Name\0icon\x1f/full/path/to/file
    ROFI_INPUT=""
    while IFS= read -r file; do
        name=$(basename "$file")
        ROFI_INPUT+="${name}\0icon\x1f${file}\n"
    done < <(find "$WALLPAPER_DIR" -type f \( -name "*.jpg" -o -name "*.jpeg" -o -name "*.png" -o -name "*.gif" \) | sort)

    # 4. Pass the formatted list to rofi
    SELECTED=$(printf "$ROFI_INPUT" | rofi -dmenu -i -p "$choice wallpapers   " \
        -show-icons \
        -theme-str 'listview { columns: 3; lines: 3; } element { orientation: vertical; } element-icon { size: 128px; }')

    # 5. If an image is selected, apply it using awww (fixed 'awww' typo to 'swww')
    if [ -n "$SELECTED" ]; then
        awww img "$WALLPAPER_DIR/$SELECTED" --transition-type grow --transition-duration 1.5

        asus=$(awww query | rev | cut -d : -f1 | rev)
        cp $asus /home/rudra/Pictures/bin/current

        wallpaper_dir=$(awww query | rev | cut -d ":" -f1 | rev | awk '{print $1}')
        wallust run -s $wallpaper_dir && killall waybar && waybar & disown
    fi

  else 

    WALLPAPER_DIR=$(echo $swallpaper_dire)

    ROFI_INPUT=""
      while IFS= read -r file; do
          name=$(basename "$file")
          ROFI_INPUT+="${name}\0icon\x1f${file}\n"
      done < <(find "$WALLPAPER_DIR" -type f \( -name "*.jpg" -o -name "*.jpeg" -o -name "*.png" -o -name "*.gif" \) | sort)

      # 4. Pass the formatted list to rofi
      SELECTED=$(printf "$ROFI_INPUT" | rofi -dmenu -i -p "Select any wallpaper  " \
          -show-icons \
          -theme-str 'listview { columns: 3; lines: 3; } element { orientation: vertical; } element-icon { size: 128px; }')

      # find final path of selected
      pehla=$(find $WALLPAPER_DIR -name "$SELECTED")
      doosra=$(echo $pehla | cut -b1-2 --complement)


      # 5. If an image is selected, apply it using awww (fixed 'awww' typo to 'swww')
      if [ -n "$SELECTED" ]; then
          awww img "$pehla" --transition-type grow --transition-duration 1.5

          wallpaper_dir=$(awww query | rev | cut -d ":" -f1 | rev | awk '{print $1}')
          wallust run -s $wallpaper_dir && killall waybar && waybar & disown
      fi



  fi

else
  exit
fi
