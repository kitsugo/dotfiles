#!/bin/sh
# Copyright 2024 Jirou Hayashi <hayashi.jiro@kitsugo.com>
# Licensed under the terms of the GNU GPL v3, or any later version.
#
# Create configuration files (initilization) for programs which require access to tablet-specific device events which may not consistently appear with /dev/input/by-path/

# Read local environment variables of device names and then fetch respective event path via 'libinpiut list-devices'
device_list=$(libinput list-devices)
readonly device_list
switch_mode_event=$(echo "$device_list" | grep -A 1 "$U_TABLET_SWITCH_DEV" | awk 'FNR == 2 {print $2}')
readonly switch_mode_event
touch_event=$(echo "$device_list" | grep -A 1 "$U_TOUCH_DEV" | awk 'FNR == 2 {print $2}')
readonly touch_event

# Write device event for watch_tablet into the first line and device event for lisgd into the second line of ./configs/watch_tablet.yml config.
# Both programs will read their respective lines on startup
printf "input_device: %s\n# %s\n" "$switch_mode_event" "$touch_event" | cat - "$HOME"/.dotfiles/tablet/configs/watch_tablet.yml >/tmp/watch_tablet.yml
# Create a symlink to the config in /tmp/ inside the regular ~/.config location
[ ! -h "$HOME/.config/watch_tablet.yml" ] && ln -s "/tmp/watch_tablet.yml" "$HOME/.config/watch_tablet.yml"

# Start watch_tablet with the config in place. It will start all other touch-related programs when table mode is entered
watch_tablet &
