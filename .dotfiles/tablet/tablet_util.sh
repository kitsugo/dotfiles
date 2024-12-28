#!/bin/bash
# Copyright 2024 Jirou Hayashi <hayashi.jiro@kitsugo.com>
# Licensed under the terms of the GNU GPL v3, or any later version.
#
# Utility commands for touchscreen setup
# These are called externally by touch-related programs to trigger certain behavior

case "$1" in
"toggle_menu") # Toggle rofi drun menu. Must be run with -n to avoid occasional crashing
	menu_opened=$(pgrep "rofi")
	readonly menu_opened
	if [ -z "$menu_opened" ]; then
		rofi -n -show drun
	else
		killall "rofi"
	fi
	;;
"toggle_files") # Toggle rofi file browser menu
	menu_opened=$(pgrep "rofi")
	readonly menu_opened
	if [ -z "$menu_opened" ]; then
		rofi -n -filebrowser-directory "$HOME" -show filebrowser
	else
		killall "rofi"
	fi
	;;
"toggle_workspaces") # Toggle rofi workspace menu
	menu_opened=$(pgrep "rofi")
	readonly menu_opened
	if [ -z "$menu_opened" ]; then
		rofi -n -theme "$HOME/.config/rofi/kitsugo_dmenu.rasi" -show ws -modes "ws:$HOME/.config/rofi/scripts/workspace_menu.sh"
	else
		killall "rofi"
	fi
	;;
"toggle_keyboard") # Toggle virtual keybord
	kb_visible=$(busctl get-property --user sm.puri.OSK0 /sm/puri/OSK0 sm.puri.OSK0 Visible)
	readonly kb_visible
	if [ "$kb_visible" = "b false" ]; then
		busctl call --user sm.puri.OSK0 /sm/puri/OSK0 sm.puri.OSK0 SetVisible b true
	else
		busctl call --user sm.puri.OSK0 /sm/puri/OSK0 sm.puri.OSK0 SetVisible b false
	fi
	;;
"lisgd") # Wrapper to start lisgd with correct flags to make it compilation-agnostic. It reads the second line of watch_tablet.yml to determine device event on which to listen
	event="$(sed -n '2p' /tmp/watch_tablet.yml 2>/dev/null)"
	readonly event
	lisgd -d "${event:2}" -g "2,RL,*,*,R,swaymsg workspace next" -g "2,LR,*,*,R,swaymsg workspace prev" -g "3,RL,*,*,R,move_window.sh -1" -g "3,LR,*,*,R,move_window.sh 1" -g "3,UD,*,*,R,swaymsg bar mode toggle touch-bar" -g "3,DU,*,*,R,tablet_util.sh toggle_keyboard" &
	;;
esac
