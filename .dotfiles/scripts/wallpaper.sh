#!/bin/sh
# Choose random wallpaper from directory of wallpapers
wallpaper_dir="$HOME/.dotfiles/extra/wallpapers/"

if [ -n "$WAYLAND_DISPLAY" ]; then
	swaybg -i "$(find -L "$wallpaper_dir". -type f | shuf -n1)" -m fill &
else
	feh --no-fehbg --bg-fill --recursive --randomize "$wallpaper_dir"
fi
