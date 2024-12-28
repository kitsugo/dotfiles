#!/bin/sh
# Copyright 2024 Jirou Hayashi <hayashi.jiro@kitsugo.com>
# Licensed under the terms of the GNU GPL v3, or any later version.
#
# Sync firefox browser profile in and out of memory to boost performance and preserve disk writes

. "$HOME/.dotfiles/dotfiles_profile.sh"

set -efu
readonly link="$U_FF_PROFILE"
readonly static="static-$U_FF_PROFILE"
readonly volatile="/tmp/firefox/volatile-$U_FF_PROFILE"
IFS=

cd "$U_FF_DIRECTORY" 2>/dev/null || exit 0

if [ ! -r "$volatile" ]; then
	mkdir -p -m0700 "$volatile"
fi

if [ "$(readlink "$link")" != "$volatile" ]; then
	mv "$link" "$static"
	ln -s "$volatile" "$link"
fi

if [ -e "$link"/.unpacked ]; then
	rsync -a --delete --exclude .unpacked ./"$link"/ ./"$static"/
	echo "Moved volatile firefox profile into static storage."
else
	rsync -a ./"$static"/ ./"$link"/
	touch "$link"/.unpacked
	echo "Moved static firefox profile into volatile storage."
fi
