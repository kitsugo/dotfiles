#!/bin/sh
# Send signal "10" to i3blocks to update certain widgets.

# Sleep delay to avoid race condition
sleep 0.3
pkill --signal SIGRTMIN+10 i3blocks
