#!/bin/sh

export FONT="Fira Code Nerd Font"
export MONO_FONT="Fira Code Nerd Font"

export XCURSOR_THEME="BreezeX-RosePine-Linux"
export XCURSOR_SIZE="24"

xrdb -merge <<< "Xcursor.theme: $XCURSOR_THEME"
xrdb -merge <<< "Xcursor.size: $XCURSOR_SIZE"

alsactl --file ~/.config/asound.state restore

# Start Tofi (for example, as an application launcher)
# tofi-drun --drun-launch=true &

# Start background service (adjust to your background setting tool)
# swaybg -i /path/to/your/wallpaper.jpg &

# Other utilities
# nm-applet &       # NetworkManager applet
# blueman-applet &  # Bluetooth manager
