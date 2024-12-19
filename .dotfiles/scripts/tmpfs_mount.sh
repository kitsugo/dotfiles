#!/bin/bash
# Copyright 2024 Jirou Hayashi <hayashi.jirou@kitsugo.dev>
# Licensed under the terms of the GNU GPL v3, or any later version.
#
# Mount a given directory permanently as tmpfs. Requires root.
# This will result in all contents of the directory to be lost upon reboot

if [ "$EUID" -ne 0 ]; then
	echo "Mounting as tmpfs requires root."
	exit
fi

if [ -d "$1" ]; then
	directory=$(realpath "$1")
	directory=${directory/ /\\040}
	echo "Appending '$directory' as tmpfs to /etc/fstab"
	echo "tmpfs $directory tmpfs noatime,nodev,nosuid 0 0" >>/etc/fstab
	mount -fav
	printf "\nNeed to verify validity of changed fstab file. Please review the output above.\nIf no errors occured, please confirm the mounting? [Y/n]"
	read -r ans
	ans=${ans:-Y}
	[ "${ans^^}" = "Y" ] && mount "$directory"
	exit
fi

echo "Bad usage: tmpfs-mount.sh [directory]"
