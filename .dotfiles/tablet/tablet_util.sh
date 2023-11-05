#!/bin/bash
# Utility functions for touchscreen setup

case "$1" in
"toggle-keyboard") # Toggle virtual keybord
	kb_visible=$(busctl get-property --user sm.puri.OSK0 /sm/puri/OSK0 sm.puri.OSK0 Visible)
	if [ "$kb_visible" = "b false" ]; then
		busctl call --user sm.puri.OSK0 /sm/puri/OSK0 sm.puri.OSK0 SetVisible b true
	else
		busctl call --user sm.puri.OSK0 /sm/puri/OSK0 sm.puri.OSK0 SetVisible b false
	fi
	;;
"toggle-menu") # Toggle wofi menu. Must be run with -n to avoid occasional crashing
	menu_open=$(pgrep "wofi")
	if [ -z "$menu_open" ]; then
		wofi -n --style "$HOME/.config/wofi/nightfox.css" --show drun
	else
		killall "wofi"
	fi
	;;
"lisgd") # Wrapper to start lisgd with correct flags to make it compilation-agnostic. Reads second line of watch_tablet.yml to determine device event
	event="$(sed -n '2p' /tmp/watch_tablet.yml 2>/dev/null)"
	lisgd -d "${event:2}" -g "2,RL,*,*,R,swaymsg workspace next" -g "2,LR,*,*,R,swaymsg workspace prev" -g "3,RL,*,*,R,move_window.sh -1" -g "3,LR,*,*,R,move_window.sh 1" -g "3,UD,*,*,R,swaymsg bar mode toggle touch-bar" -g "3,DU,*,*,R,tablet_util.sh toggle-keyboard" &
	;;
esac
