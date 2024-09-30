#!/bin/sh

# Power menu script using tofi

CHOSEN=$(printf "Lock\nSuspend\nReboot\nShutdown\nLog Out" | rofi -dmenu -p "Power: ") #--config "$HOME"/.config/tofi/powermenu-config)

case "$CHOSEN" in
"Lock") hyprlock ;;
"Suspend") systemctl suspend-then-hibernate ;;
"Reboot") reboot ;;
"Shutdown") poweroff ;;
"Log Out") hyprctl dispatch exit ;;
*) exit 1 ;;
esac
