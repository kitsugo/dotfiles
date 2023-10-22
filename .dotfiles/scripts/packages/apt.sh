#!/bin/sh
# Download a shipment of packages for certain setups
case "$1" in
"i3")
	apt-get install feh i3blocks xautolock xclip xsecurelock
	;;

"sway")
	apt-get install sway swaybg swayidle swaylock
	;;
*)
	echo "Bad usage: apt.sh i3|sway"
	;;
esac
