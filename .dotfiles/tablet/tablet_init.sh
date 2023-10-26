#!/bin/sh
# Create configuration files for programs which require access to tablet-specific device events which may not consistently appear with /dev/input/by-path/

# Read local environment variables of device names and then fetches respective event path via 'libinpiut list-devices'
device_list=$(libinput list-devices)
switch_mode_event=$(echo "$device_list" | grep -A 1 "$U_TABLET_SWITCH_DEV" | awk 'FNR == 2 {print $2}')
touch_event=$(echo "$device_list" | grep -A 1 "$U_TOUCH_DEV" | awk 'FNR == 2 {print $2}')

# Write device for watch_tablet into the first line and for lisgd into the second line of watch_tablet.yml config
printf "input_device: %s\n# %s\n" "$switch_mode_event" "$touch_event" | cat - "$HOME"/.dotfiles/tablet/configs/watch_tablet.yml >/tmp/watch_tablet.yml
# ln -s "$HOME/.config/watch_tablet.yml" "/tmp/watch_tablet.yml"

# Start watch_tablet with the config in place
watch_tablet &
