#!/bin/bash

PS1="\[$(printf '\e[0;32m')\][\t] \u@\h \W\[$(printf '\e[031m')\] \\$ \[$(printf '\e[0m')\]"

bind 'set bell-style none'
bind 'set show-all-if-ambiguous on'
bind 'set colored-completion-prefix on'
bind 'set completion-ignore-case on'
bind 'set mark-symlinked-directories on'
bind '"\e[A": history-search-backward'
bind '"\e[B": history-search-forward'
bind '"\e[C": forward-char'
bind '"\e[D": backward-char'
bind '"\t": menu-complete'
bind '"\e[Z": menu-complete-backward'
shopt -s autocd
shopt -s dirspell direxpand
shopt -s cdspell

alias ls='ls -a --color=auto'
