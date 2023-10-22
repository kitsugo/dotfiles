#!/bin/sh
# Send signal to i3blocks to update certain widgets
sleep 0.3
pkill --signal SIGRTMIN+10 i3blocks
