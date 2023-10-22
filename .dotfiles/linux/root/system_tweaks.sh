#!/bin/bash
# Setup various system-wide tweaks

if [ "$EUID" -ne 0 ]; then
	echo "Tweaking the system requires root!"
	exit
fi

. "util.sh"

echo "Setup super-user bash configurations? [y/N]"
read_ans_n
if [ "${ans,,}" = "y" ]; then
	if [ ! -f "$HOME/.bashrc" ]; then
		cp -i ".bashrc" "$HOME/.bashrc"
	elif [ ! -f "$HOME/.bashrcsu" ]; then
		printf ".bashrc already exists!\nCreate external file instead? Requires manual sourcing. [y/N]"
		read_ans_n
		[ "${ans,,}" = "y" ] && cp -n ".bashrc" "$HOME/.bashrcsu"
	fi

	if [ ! -f "$HOME/.profile" ]; then
		cp -i ".profile" "$HOME/.profile"
	elif [ ! -f "$HOME/.profilesu" ]; then
		printf ".profile already exists!\nCreate external file instead? Requires manual sourcing. [y/N]"
		read_ans_n
		[ "${ans,,}" = "y" ] && cp -n ".profile" "$HOME/.profilesu"
	fi
fi

if [ ! -f /etc/sysctl.d/disable_watchdog.conf ]; then
	echo "Disable watchdog for potential powersaving? [Y/n]"
	read_ans_y
	[ "${ans,,}" = "y" ] && printf "kernel.nmi_watchdog = 0" >/etc/sysctl.d/disable_watchdog.conf
else
	echo "Watchdog config already exists."
fi

if [ ! -f /etc/modprobe.d/nobeep.conf ]; then
	echo "Disable PC Speaker? (Beep sound on startup) [Y/n]"
	read_ans_y
	[ "${ans,,}" = "y" ] && printf "blacklist pcspkr\nblacklist snd_pcsp" >/etc/modprobe.d/nobeep.conf
else
	echo "Nobeep config already exists."
fi
