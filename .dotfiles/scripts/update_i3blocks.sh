#!/bin/sh
# Copyright 2024 Jirou Hayashi <hayashi.jirou@kitsugo.dev>
# Licensed under the terms of the GNU GPL v3, or any later version.
#
# Send signal "10" to i3blocks to update certain widgets.

# Sleep delay to avoid race condition
sleep 0.3
pkill --signal SIGRTMIN+10 i3blocks
