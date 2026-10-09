echo "Copying necessary dotfiles"
echo 
sleep 2
cp -r ./.config/* ~/.config/
echo
echo

echo "Copying other files"
echo
echo
mkdir ~/scripts/
cp -r ./scripts/* ~/scripts/
cp -r ./.local/share/applications/* ~/.local/share/applications

echo
echo
echo "All files copied!!"
