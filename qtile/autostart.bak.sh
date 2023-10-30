#!/bin/sh
#   ___ _____ ___ _     _____   ____  _             _    
#  / _ \_   _|_ _| |   | ____| / ___|| |_ __ _ _ __| |_  
# | | | || |  | || |   |  _|   \___ \| __/ _` | '__| __| 
# | |_| || |  | || |___| |___   ___) | || (_| | |  | |_  
#  \__\_\|_| |___|_____|_____| |____/ \__\__,_|_|   \__| 
#                                                        
#  
# by Stephan Raabe (2023) 
# ----------------------------------------------------- 

# My screen resolution
# xrandr --rate 120

xrandr --output DP-1 --primary --rate 100 --mode 3840x2160
xrandr --output DP-3 --right-of DP-1 --rate 100 --mode 1920x1080
xrandr --output DP-2 --left-of DP-1 --rate 100 --mode 2560x1440

# For Virtual Machine 
# xrandr --output Virtual-1 --mode 1920x1080

# Set keyboard mapping
# setxkbmap de
setxkbmap en

# Load picom
picom &

# Load power manager
xfce4-power-manager &

# Load notification service
dunst &

# Launch polybar
~/dotfiles/polybar/launch.sh &

# Setup Wallpaper and update colors
~/dotfiles/scripts/updatewal.sh &
