#!/bin/sh
# Setup keyboard configuration depending on display server and installed IME
# If an IME is present, it shall take over the keyboard configuration
# The compose key should always be set, but other input-mappings interfere with the IME
. utils.sh

# Setup the IME (fcitx5 or ibus). If neither is installed return error code so a default xkbmap / sway input setting takes over
setup_IME() {
	if command -v fcitx5 >/dev/null; then
		nohup fcitx5 >/dev/null 2>&1 &
	elif command -v ibus >/dev/null; then
		nohup ibus-daemon -rxRd >/dev/null 2>&1 &
	else
		return 1
	fi
	return 0
}

if is_wayland; then
	if ! setup_IME; then
		swaymsg input type:keyboard xkb_layout '"us,de"'
		swaymsg input type:keyboard xkb_options '"grp:alt_shift_toggle,compose:caps"'
	else
		swaymsg input type:keyboard xkb_options '"compose:caps"'
	fi
else
	if ! setup_IME; then
		echo "no fctix, set everything" >> /tmp/debug.log
		setxkbmap -layout us,de -option 'grp:alt_shift_toggle,compose:caps'
	else
		echo "fctix, set caps" >> /tmp/debug.log
		setxkbmap -option 'compose:caps'
	fi
fi
