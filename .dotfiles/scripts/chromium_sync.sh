#!/bin/sh
# Copyright 2024 Jirou Hayashi <hayashi.jiro@kitsugo.com>
# Licensed under the terms of the GNU GPL v3, or any later version.
#
# Create symlinks to tmp for all chromium files. This makes all chromimum settings only persist for one session.

. "$HOME/.dotfiles/dotfiles_profile.sh"

set -efu
readonly link_data="chromium"
readonly tmp_data="/tmp/chromium/data/"
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
mkdir -p "$tmp_data"
if [ "$(readlink "$link_data")" != "$tmp_data" ]; then
	ln -s "$tmp_data" "$link_data"
fi
