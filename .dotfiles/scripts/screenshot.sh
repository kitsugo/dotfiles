#!/bin/sh -e
# Copyright 2024 Jirou Hayashi <hayashi.jiro@kitsugo.com>
# Licensed under the terms of the GNU GPL v3, or any later version.
#
# Select screen and take a screenshot

if [ -n "$WAYLAND_DISPLAY" ]; then
	grim -g "$(slurp)" /tmp/"$(date +%s)".png
else
	shotgun $(slop -f "-i %i -g %g") /tmp/"$(date +%s)".png
fi
