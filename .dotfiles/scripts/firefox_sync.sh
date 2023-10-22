#!/bin/sh
# Sync firefox browser profile in and out of memory to boost performance and preserve disk writes
. "$HOME/.dotfiles/dotfiles_profile.sh"

set -efu
link=$U_FF_PROFILE
static=static-$U_FF_PROFILE
volatile=/tmp/firefox/volatile-$U_FF_PROFILE
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
	rsync -av --delete --exclude .unpacked ./"$link"/ ./"$static"/
	echo "Moved volatile profile into static storage."
else
	rsync -av ./"$static"/ ./"$link"/
	touch "$link"/.unpacked
	echo "Moved static profile into volatile storage."
fi
