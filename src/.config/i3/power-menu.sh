#!/bin/bash

options="Lock\nLogout\nReboot\nShutdown"
selected=$(echo -e "$options" | rofi -dmenu -theme ~/.config/rofi/neobrutalist.rasi)

case $selected in
    Lock) i3lock -c 000000 ;;
    Logout) i3-msg exit ;;
    Reboot) systemctl reboot ;;
    Shutdown) systemctl poweroff ;;
esac
