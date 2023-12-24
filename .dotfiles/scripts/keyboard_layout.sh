#!/bin/sh
# Setup keyboard configuration depending on display server and installed IME
# If an IME is present, it shall take over the keyboard configuration
# The compose key should always be set, but other input-mappings interfere with the IME

if [ -n "$WAYLAND_DISPLAY" ]; then
	if command -v fcitx5 >/dev/null; then
		swaymsg input 'type:keyboard xkb_options compose:caps'
		fcitx5 -d
	else
		swaymsg input type:keyboard xkb_layout '"us,de"'
		swaymsg input type:keyboard xkb_options '"grp:alt_shift_toggle,compose:caps"'
	fi
else
	if command -v fcitx5 >/dev/null; then
		setxkbmap -option 'compose:caps'
		fcitx5 -d
	else
		setxkbmap -layout us,de -option 'grp:alt_shift_toggle,compose:caps'
	fi
fi
