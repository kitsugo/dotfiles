#!/bin/sh -e
# Switches the current colorscheme (dark/light) of most most applicatios by reading in the desired theme and switching colors on the fly via various approaches
current_mode="$(head -n 1 /tmp/current_theme.conf 2>/dev/null || echo "#dark")" # Read in the current theme from /tmp/ kitty file. Assume dark if no file exists

if [ "$current_mode" = "#dark" ]; then # Switch to light mode
	theme="$HOME/.config/kitty/theme_dayfox.conf"
	color_replace_i3blocks='s/#9d79d6/#b3434e/g; s/#719cd6/#b86e28/g; s/#e0c989/#2848a9/g; s/#f4a261/#6e33ce/g; s/#81b29a/#577f63/g; s/#7ad5d6/#287980/g'
	color_replace_i3bar='s/i3blocks/i3blocks -c \/tmp\/light_conf/g; s/#192330cc/#f6f2eecc/g; s/#9d79d6 #baa1e2 #393b44/#a5222f #b3434e #f2e9e1/g; s/#738091 #2b3b51 #dfdfe0/#837a72 #e7d2be #352c24/g; s/#dbc074 #e0c989 #393b44/#2848a9 #4863b6 #f2e9e1/g'

	# Kitty: Choose theme config file
	kitty @ set-colors -a --configured "$theme"

	# I3Blocks: Copy config file into /tmp/ and replace all colorstrings via sed
	[ ! -f "/tmp/light_conf" ] && sed "$color_replace_i3blocks" "$HOME/.config/i3blocks/config" >"/tmp/light_conf"

	# Sway/I3:
	if [ -n "$WAYLAND_DISPLAY" ]; then
		# Change colors via IPC and restart i3blocks in place. touch_bar must be hidden with slight delay
		swaymsg bar default_bar colors background "#f6f2eecc"
		swaymsg bar default_bar colors focused_workspace "#a5222f #b3434e #f2e9e1"
		swaymsg bar default_bar colors inactive_workspace " #837a72 #e7d2be #352c24"
		swaymsg bar default_bar colors urgent_workspace "#2848a9 #4863b6 #f2e9e1"
		swaymsg bar default_bar status_command -
		swaymsg bar default_bar status_command "i3blocks -c /tmp/light_conf"
		[ ! -f "/tmp/light_touch_conf" ] && sed "$color_replace_i3blocks" "$HOME/.config/i3blocks/touch_bar" >"/tmp/light_touch_conf"
		swaymsg bar touch_bar colors background " #f6f2eecc"
		swaymsg bar touch_bar status_command -
		swaymsg bar touch_bar status_command "i3blocks -c /tmp/light_touch_conf"
		sleep 0.1 && swaymsg bar mode hide touch_bar
	else
		# Copy i3bar.conf to /tmp/, replace colorstrings and reload i3. I3 will prioritize /tmp/i3bar.conf over the persistent version. Remove /tmp/ file afterward so another reload reverts to defaut colors
		cp "$HOME/.config/i3/i3bar.conf" "/tmp/i3bar.conf"
		sed -i "$color_replace_i3bar" "/tmp/i3bar.conf"
		i3 reload
		rm "/tmp/i3bar.conf"
	fi

	# Mark newly set theme in the first line of the /tmp/ kitty file for next execution of this script
	echo '#light' | cat - "$theme" >/tmp/current_theme.conf
else # Undo all color changes back to dark, i.e. reset to or just use the default
	theme="$HOME/.config/kitty/theme_nightfox.conf"
	kitty @ set-colors -a --configured "$theme"

	if [ -n "$WAYLAND_DISPLAY" ]; then
		swaymsg bar default_bar colors background "#192330cc"
		swaymsg bar default_bar colors focused_workspace "#9d79d6 #baa1e2 #393b44"
		swaymsg bar default_bar colors inactive_workspace "#738091 #2b3b51 #dfdfe0"
		swaymsg bar default_bar colors urgent_workspace "#dbc074 #e0c989 #393b44"
		swaymsg bar default_bar status_command -
		swaymsg bar default_bar status_command "i3blocks"
		swaymsg bar touch_bar colors background "#192330cc"
		swaymsg bar touch_bar status_command -
		swaymsg bar touch_bar status_command "i3blocks -c $HOME/.config/i3blocks/touch_bar"
		sleep 0.1 && swaymsg bar mode hide touch_bar
	else
		i3 reload
	fi

	echo '#dark' | cat - "$theme" >/tmp/current_theme.conf
fi
