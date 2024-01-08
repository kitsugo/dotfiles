#!/bin/sh
# Wrapper script around mpv to utilize LF as a very simple directory-based terminal music player
# Tries to use mpv remotely if possible but will default to killing and respawing the process if socat is not available for remote controlling
# $1: The playlist-start index
# $2: Optional arguments. Assumed to be just --shuffle when mpv is remotely called

if [ -x "$(command -v socat)" ]; then
	if [ -e "/tmp/mpvsocket" ]; then
		echo loadlist "/tmp/playlist.txt" | socat - /tmp/mpvsocket
		[ -n "${2:-}" ] && echo playlist-shuffle | socat - /tmp/mpvsocket
		echo playlist-play-index "$1" | socat - /tmp/mpvsocket
	else
		mpv --loop-playlist --playlist-start="$1" --input-ipc-server=/tmp/mpvsocket --playlist=/tmp/playlist.txt "${2:-}"
		rm /tmp/mpvsocket
	fi
else
	pid=$(cat /tmp/player.pid)
	[ -n "$pid" ] && kill "$pid" >/tmp/log.txt
	mpv --loop-playlist --playlist-start="$1" --playlist=/tmp/playlist.txt "${2:-}" &
	echo $! >/tmp/player.pid
fi

sleep 1
pkill --signal SIGRTMIN+10 i3blocks
