#1/bin/bash

option=$( printf "Connect/ON\nDisconnect/OFF\n" | rofi -dmenu -i -p "VPN  ")

case $option in
  "Connect/ON")                  protonvpn connect ;;
  "Disconnect/OFF")               protonvpn disconnect ;;
esac
