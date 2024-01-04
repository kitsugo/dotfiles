#!/bin/sh
export EDITOR=/usr/bin/nvim
export VISUAL=$EDITOR
export HISTCONTROL="erasedups:ignoreboth"
export HISTIGNORE="&:[ ]*:exit:ls:bg:fg:history"
export HISTFILE=/tmp/.bash_history
export LESSHISTFILE=/dev/null
export XSECURELOCK_IMAGE_PATH="$HOME/.dotfiles/extra/images/lockbg.png"
export XSECURELOCK_SAVER="$HOME/.config/xsecurelock_saver"
export XSECURELOCK_PASSWORD_PROMPT=time_hex
export WINEPREFIX="/tmp/.wine"
export TIMEWARRIORDB="$HOME/.dotfiles/extra/gtd/timew/"
export TASKRC="$HOME/.dotfiles/extra/gtd/task/.taskrc"
export TASKDATA="$HOME/.dotfiles/extra/gtd/task/"
export MOZ_ENABLE_WAYLAND=1
export GLFW_IM_MODULE=ibus
export PATH="$PATH:$HOME/.local/bin/:$HOME/.dotfiles/scripts/:$HOME/.dotfiles/tablet/"

if command -v fcitx5 >/dev/null; then
	export GTK_IM_MODULE=fcitx
	export QT_IM_MODULE=fcitx
	export XMODIFIERS=@im=fcitx
elif command -v ibus >/dev/null; then
	export GTK_IM_MODULE=ibus
	export QT_IM_MODULE=ibus
	export XMODIFIERS=@im=ibus
fi

[ -f "$HOME/.bash_history" ] && rm "$HOME/.bash_history"
[ -f "$HOME/.dotfiles/dotfiles_profile.sh" ] && . "$HOME/.dotfiles/dotfiles_profile.sh"
