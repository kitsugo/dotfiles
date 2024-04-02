#!/bin/sh
# Utility functions for shell scripts

# Returns number indicating whether the current session is a Wayland session
is_wayland() {
	if [ -n "$WAYLAND_DISPLAY" ] || [ "$XDG_SESSION_TYPE" = "wayland" ] || [ "$(loginctl show-session $(loginctl | grep $(whoami) | awk '{print $1}') -p Type)" = "Type=wayland" ]; then
		return 0
	else
		return 1
	fi
}

# Returns the absolute path to the directory the script is executed in. Does not work when sourcing the script
script_dir() {
	echo "$(CDPATH='' cd -- "$(dirname -- "$0")" && pwd)"
}

# Read user yes/no input and assume yes
read_ans_y() {
	read -r ans
	ans=${ans:-y}
}

# Read user yes/no input and assume no
read_ans_n() {
	read -r ans
	ans=${ans:-n}
}
