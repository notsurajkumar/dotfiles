echo "Copying necessary dotfiles"
echo 
sleep 2
cp -r ./hypr/ ./kitty/ ./nvim/ ./rofi/ ./waybar/ ./fish/ ./starship/ ./mpv/ ./wallust/ ~/.config/
echo
echo

echo "Copying other files"
echo
echo
mkdir ~/scripts/
cp -r ./post-install ./wallpaper_switcher ~/scripts/
cp -r ./.local/share/applications/* ~/.local/share/applications/

echo
echo
echo "All files copied!!"
