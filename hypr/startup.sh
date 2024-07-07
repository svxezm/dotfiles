#!/bin/sh

# Start Waybar
waybar &

firefox &

# Start Tofi (for example, as an application launcher)
# tofi-drun --drun-launch=true &

# Start background service (adjust to your background setting tool)
# swaybg -i /path/to/your/wallpaper.jpg &

# Other utilities
# nm-applet &       # NetworkManager applet
# blueman-applet &  # Bluetooth manager
