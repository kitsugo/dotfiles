#!/bin/sh
# Copyright 2024 Jirou Hayashi <hayashi.jiro@kitsugo.com>
# Licensed under the terms of the GNU GPL v3, or any later version.
#
# Sync chromium settings in and out of memory to boost performance and preserve disk writes

. "$HOME/.dotfiles/dotfiles_profile.sh"

set -efu
readonly link="chromium"
readonly static="static-chromium"
readonly volatile="/tmp/chromium/volatile-chromium/"
readonly link_cache="cache"
readonly tmp_cache="/tmp/chromium/cache/"
IFS=

cd "$U_CHROME_CACHE" 2>/dev/null || exit 0

# Setup symlink for chromium cache
mkdir -p "$tmp_cache"
if [ ! -e "$link_cache" ]; then
	ln -s "$tmp_cache" "$link_cache"
elif [ "$(readlink "$link_cache")" != "$tmp_cache" ]; then
	rm -r "$link_cache"
	ln -s "$tmp_cache" "$link_cache"
fi

cd "$U_CHROME_DIRECTORY" 2>/dev/null || exit 0

# Setup symlink for chromium data
mkdir -p "$volatile"
if [ "$(readlink "$link")" != "$volatile" ]; then
	mv "$link" "$static"
	ln -s "$volatile" "$link"
fi

if [ -e "$link"/.unpacked ]; then
	rsync -a --delete --exclude .unpacked ./"$link"/ ./"$static"/
	printf "Moved volatile chromium settings into static storage.\n"
else
	rsync -a ./"$static"/ ./"$link"/
	touch "$link"/.unpacked
	printf "Moved static chromium settings into volatile storage.\n"
fi
