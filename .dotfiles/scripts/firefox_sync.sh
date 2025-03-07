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
readonly link_cache="cache"
readonly tmp_cache="/tmp/firefox/cache/"
IFS=

cd "$U_FF_CACHE" 2>/dev/null || exit 0

# Setup symlink for firefox cache
mkdir -p "$tmp_cache"
if [ ! -e "$link_cache" ]; then
	printf "noo"
	ln -s "$tmp_cache" "$link_cache"
elif [ ! -h "$link_cache" ] || [ "$(readlink "$link_cache")" != "$tmp_cache" ]; then
	printf "no"
	rm -r "$link_cache"
	ln -s "$tmp_cache" "$link_cache"
fi

cd "$U_FF_DIRECTORY" 2>/dev/null || exit 0

# Setup symlink for firefox profile
mkdir -p "$volatile"
if [ "$(readlink "$link")" != "$volatile" ]; then
	mv "$link" "$static"
	ln -s "$volatile" "$link"
fi

if [ -e "$link"/.unpacked ]; then
	rsync -a --delete --exclude .unpacked ./"$link"/ ./"$static"/
	printf "Moved volatile firefox profile into static storage.\n"
else
	rsync -a ./"$static"/ ./"$link"/
	touch "$link"/.unpacked
	printf "Moved static firefox profile into volatile storage.\n"
fi
