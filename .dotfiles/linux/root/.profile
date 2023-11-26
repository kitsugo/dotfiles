#!/bin/sh
export HISTFILE=/tmp/.bash_history
export HISTCONTROL="erasedups:ignoreboth"
export HISTIGNORE="&:[ ]*:exit:ls:bg:fg:history"

[ -f "/tmp/.bash_history" ] && rm "/tmp/.bash_history"
