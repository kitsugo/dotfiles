#!/bin/sh
# Download a shipment of packages for certain setups

case "$1" in
"i3")
	pacman -S --needed i3-wm feh xautolock xsecurelock xclip
	;;
"sway")
	pacman -S --needed xorg-xwayland sway swaybg swayidle swaylock
	;;
"portable")
	pacman -S --needed tlp acpi
	;;
"tablet")
	pacman -S --needed jq
	printf "Install via AUR:\nsqeekboard\nwatch_tablet"
	;;
"util")
	pacman -S --needed i3blocks sysstat git rsync
	;;
*)
	echo "Bad usage: apt.sh i3|sway|portable|tablet|util"
	;;
esac
