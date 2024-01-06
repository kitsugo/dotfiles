#!/bin/sh
# Dynamically sets the colorscheme of most applications by copying a template into /tmp and applying 'envsubst' to replace all color variables.
# Chooses a random colorscheme by default, but can be given an argument to explicitly set one.

i3bar_config="$HOME/.config/i3/i3bar.conf"
swaybar_config="$HOME/.config/sway/swaybar.conf"
swaybar_touch="$HOME/.config/sway/swaybar_touch.conf"
i3blocks_config="$HOME/.config/i3blocks/config"
i3blocks_touch="$HOME/.config/i3blocks/touch_bar"
# Must explicitly set changeable variables of i3blocks since envusbst will otherwise overwrite i3blocks-specific variables
i3blocks_vars='$U_COLOR_BLOCKS_BG1$U_COLOR_BLOCKS_BG2$U_COLOR_BLOCKS_BG3$U_COLOR_BLOCKS_1$U_COLOR_BLOCKS_2$U_COLOR_BLOCKS_3$U_COLOR_BLOCKS_4$U_COLOR_BLOCKS_5$U_COLOR_BLOCKS_6$U_COLOR_WARN$U_COLOR_CRIT'

# Get colorscheme
colorscheme_dir="$HOME/.dotfiles/colorschemes/"
if [ -f "$colorscheme_dir$1.sh" ]; then
	. "$colorscheme_dir$1.sh"
else
	random="$(find -L "$colorscheme_dir" -type f | shuf -n1)"
	# . "$random"
	. "$colorscheme_dir/nightfox.sh"
fi

mkdir -p /tmp/colorscheme
if [ "$XDG_SESSION_TYPE" = "wayland" ]; then
	envsubst <"$swaybar_config" >/tmp/colorscheme/swaybar.conf
	envsubst <"$swaybar_touch" >/tmp/colorscheme/swaybar_touch.conf
	envsubst "$i3blocks_vars" <"$i3blocks_touch" >/tmp/colorscheme/i3blocks_touch.conf
else
	envsubst <"$i3bar_config" >/tmp/colorscheme/i3bar.conf
fi

envsubst "$i3blocks_vars" <"$i3blocks_config" >/tmp/colorscheme/i3blocks.conf
envsubst <"$U_KITTY_THEME" >/tmp/colorscheme/kitty_theme.conf
