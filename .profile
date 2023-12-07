#!/bin/sh
export EDITOR=/usr/bin/nvim
export VISUAL=$EDITOR
export HISTFILE=/tmp/.bash_history
export HISTCONTROL="erasedups:ignoreboth"
export HISTIGNORE="&:[ ]*:exit:ls:bg:fg:history"
export LESSHISTFILE=/dev/null
export XSECURELOCK_IMAGE_PATH="$HOME/.dotfiles/extra/images/lockbg.png"
export XSECURELOCK_SAVER="$HOME/.config/xsecurelock_saver"
export XSECURELOCK_PASSWORD_PROMPT=time_hex
export TIMEWARRIORDB="$HOME/.dotfiles/extra/gtd/timew/"
export TASKRC="$HOME/.dotfiles/extra/gtd/task/.taskrc"
export TASKDATA="$HOME/.dotfiles/extra/gtd/task/"
export MOZ_ENABLE_WAYLAND=1
export PATH="$PATH:$HOME/.local/bin/:$HOME/.dotfiles/scripts/:$HOME/.dotfiles/tablet/"

[ -f "$HOME/.bash_history" ] && rm "$HOME/.bash_history"
[ -f "$HOME/.dotfiles/dotfiles_profile.sh" ] && . "$HOME/.dotfiles/dotfiles_profile.sh"
