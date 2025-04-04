#!/bin/sh
# Copyright 2024 Jirou Hayashi <hayashi.jiro@kitsugo.com>
# Licensed under the terms of the GNU GPL v3, or any later version.
#
# Dynamically sets the colorscheme of most applications by copying a template into /tmp/ and applying 'envsubst' to replace all color variables.
# All colors are taken from a randomly selected [dark|light]_[colorscheme].sh file which exports color code variables

. "$HOME/.dotfiles/scripts/utils.sh"
export WALLPAPER_DIR="$HOME/.dotfiles/extra/wallpapers/"
readonly colorscheme_dir="$HOME/.dotfiles/extra/colorschemes/"

# List of variables envsubst is allowed to substitute in files which also contain other environment variables
readonly substitute_vars='$U_COLOR_BLOCKS_BG1$U_COLOR_BLOCKS_BG2$U_COLOR_BLOCKS_BG3$U_COLOR_BLOCKS_1$U_COLOR_BLOCKS_2$U_COLOR_BLOCKS_3$U_COLOR_BLOCKS_4$U_COLOR_BLOCKS_5$U_COLOR_BLOCKS_6$U_COLOR_WARN$U_COLOR_CRIT'

# Filename definitions for all source config files
readonly i3colors_config="$HOME/.config/i3/colors.conf"
readonly i3bar_config="$HOME/.config/i3/i3bar.conf"
readonly swaybar_config="$HOME/.config/sway/swaybar.conf"
readonly swaybar_touch="$HOME/.config/sway/swaybar_touch.conf"
readonly i3blocks_config="$HOME/.config/i3blocks/config"
readonly i3blocks_touch="$HOME/.config/i3blocks/touch_bar"
readonly dunst_config="$HOME/.config/dunst/dunstrc.conf"
readonly rofi_colors="$HOME/.config/rofi/dynamic_colors_src.rasi"
color_theme="dark"

if [ -f "$colorscheme_dir$1.sh" ]; then
	. "$colorscheme_dir$1.sh"
elif [ "$1" = "light" ]; then
	random_light="$(find -L "$colorscheme_dir" -name "light_*" -type f | shuf -n1)"
	readonly random_light
	color_theme="light"
	. "$random_light"
else
	random_dark="$(find -L "$colorscheme_dir" -name "dark_*" -type f | shuf -n1)"
	readonly random_dark
	. "$random_dark"
fi

# Replace all color strings in the source config files and write the tranformed output files to /tmp/colorscheme/
mkdir -p /tmp/colorscheme
envsubst <"$i3colors_config" >/tmp/colorscheme/i3colors.conf
envsubst <"$swaybar_config" >/tmp/colorscheme/swaybar.conf
envsubst <"$swaybar_touch" >/tmp/colorscheme/swaybar_touch.conf
envsubst "$substitute_vars" <"$i3blocks_touch" >/tmp/colorscheme/i3blocks_touch.conf
envsubst <"$i3bar_config" >/tmp/colorscheme/i3bar.conf
envsubst "$substitute_vars" <"$i3blocks_config" >/tmp/colorscheme/i3blocks.conf
envsubst <"$dunst_config" >/tmp/colorscheme/dunstrc.conf
envsubst <"$rofi_colors" >/tmp/colorscheme/dynamic_colors.rasi
cp -sf "$U_KITTY_THEME" /tmp/colorscheme/kitty_theme.conf
cp -sf "$U_TASKW_THEME" /tmp/colorscheme/taskw.theme
echo "$U_WALLPAPERS" >/tmp/colorscheme/wallpapers.txt
echo "$U_COLORSCHEME" >/tmp/colorscheme/name.txt

# If this script is not called on startup, signal to all relevant programs to perform an action that reloads their config files (IPC / restart) or that changes their colorscheme
if [ "$1" != "--startup" ]; then
	# Restart i3/sway
	if is_wayland; then
		swaymsg reload
	else
		i3 restart
	fi

	# Change GTK settings
	if [ "$color_theme" = "light" ]; then
		gsettings set org.gnome.desktop.interface color-scheme 'prefer-light'
	elif [ "$color_theme" = "dark" ]; then
		gsettings set org.gnome.desktop.interface color-scheme 'prefer-dark'
	fi

	kitty @ set-colors -a --configured /tmp/colorscheme/kitty_theme.conf
	wallpaper.sh
	killall dunst
	notify-send "Changed colorscheme to '$U_COLORSCHEME'!"
fi
