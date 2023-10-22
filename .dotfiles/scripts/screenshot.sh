#!/bin/sh -e
# Select screen and take a screenshot
if [ -n "$WAYLAND_DISPLAY" ]; then
	grim -g "$(slurp)" /tmp/"$(date +%s)".png
else
	shotgun $(slop -f "-i %i -g %g") /tmp/"$(date +%s)".png
fi
