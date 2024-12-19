#!/bin/sh
# Copyright 2024 Jirou Hayashi <hayashi.jirou@kitsugo.dev>
# Licensed under the terms of the GNU GPL v3, or any later version.
#
# Selects a random wallpaper from /tmp/colorscheme/wallpapers.txt with swaybg/feh.

readonly wallpaper_dir="$HOME/.dotfiles/extra/wallpapers/"
readonly wallpaper_list="/tmp/colorscheme/wallpapers.txt"

if [ -z "$wallpaper_list" ]; then
	random_wallpaper="$(find -L "$wallpaper_dir" . -type f | shuf -n1)"
else
	random_wallpaper="$(shuf -n1 <"$wallpaper_list")"
fi

if [ -n "$WAYLAND_DISPLAY" ]; then
	killall "swaybg"
	swaybg -i "$random_wallpaper" -m fill &
else
	feh --no-fehbg --bg-fill "$random_wallpaper"
fi
