### pacman
git
waybar
awww
polkit-kde-agent
gnome-disk-utility
neovim
htop, btop
cava
cliphist
hyprshot
mpv
gum
fzf
yt-dlp
ffmpeg
fish
eza
mousepad
tlp tlp-rdw powertop acpi smartmontools
blanket


### yay
wallust
obsidian
brave-browser
bass-fish



---



### yay installation
sudo pacman -Syu
sudo pacman -S git
sudo pacman -S --needed base-devel debugedit

### read below if the following does not work
git clone https://aur.archlinux.org/yay.git
cd yay
makepkg -si


### problems
makepkg -si
this command can give error 429, which is generally for rate limit on aur servers, so try again after 30 mins

or alternatively use this:

git clone https://aur.archlinux.org/yay-bin.git
cd yay-bin
makepkg -si
