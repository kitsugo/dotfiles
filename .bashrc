#!/bin/bash
# If not running interactively, don't do anything
[[ $- != *i* ]] && return

# Custom prompt
PS1="\[$(printf '\e[0;35m')\][\t] \[$(printf '\e[0;35m')\]\H:\u † \[$(printf '\e[0m')\]\[$(printf '\e[0;33m')\]\w \[$(printf '\e[0;36m')\]\\$ \[$(printf '\e[0m')\]"

# Better bash
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
shopt -s no_empty_cmd_completion
shopt -s autocd
shopt -s dirspell direxpand
shopt -s cdspell

# Alias setup
alias got='git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME'
alias ls='ls -a --color=auto'
alias grep='grep --color=auto'
alias lf='lfcd'
alias novim='nvim -u NONE'
alias ks='kitty +kitten ssh'
alias dif='kitty +kitten diff'
alias mnt='udisksctl mount -b'
alias umnt='udisksctl unmount -b'
alias mnt_mtp='mkdir -p /run/user/1000/mtp/ && aft-mtp-mount /run/user/1000/mtp/'
alias umnt_mtp='fusermount -u /run/user/1000/mtp/'

# Setup ssh+gpg only if git is installed
if [[ $(git --version 2>&1 >/dev/null) -eq 0 ]]; then
	## Git setup
	# Git completion
	[[ -f /usr/share/git/completion/git-completion.bash ]] && . "/usr/share/git/completion/git-completion.bash"
	[[ -f /usr/share/bash-completion/completions/git ]] && . "/usr/share/bash-completion/completions/git"
	# Git prompt
	if [[ -f "$HOME/.local/share/bash-git-prompt/gitprompt.sh" ]]; then
		GIT_PROMPT_ONLY_IN_REPO=1
		GIT_PROMPT_FETCH_REMOTE_STATUS=0
		. "$HOME/.local/share/bash-git-prompt/gitprompt.sh"
	fi

	## SSH setup
	# Start ssh agent if not started yet. Kill after 4 hours
	if [[ ! $(pgrep -u "$USER" ssh-agent) ]]; then
		ssh-agent -t 4h >"$XDG_RUNTIME_DIR/ssh-agent.env"
		chmod 600 "$XDG_RUNTIME_DIR/ssh-agent.env"
	fi
	# Source the current ssh agent if not already done (subshells don't require re-source)
	if [[ -z $SSH_AUTH_SOCK ]]; then
		. "$XDG_RUNTIME_DIR/ssh-agent.env" >/dev/null 2>&1
	fi

	## GPG setup
fi

## Functions

# cd into the last opened lf directory
lfcd() {
	tmp="$(mktemp)"
	command lf -last-dir-path="$tmp" "$@"
	if [ -f "$tmp" ]; then
		dir="$(cat "$tmp")"
		rm -f "$tmp"
		if [ -d "$dir" ]; then
			if [ "$dir" != "$(pwd)" ]; then
				cd "$dir" || exit 0
			fi
		fi
	fi
}

mnt_crypt() {
	sudo cryptsetup luksOpen /dev/"$1" "$1"
	mnt /dev/mapper/"$1"
}

umnt_crypt() {
	umnt /dev/mapper/"$1"
	sudo cryptsetup luksClose "$1"
}

mnt_flatpak_usb() {
	local mount_path
	mnt "$1"
	mount_path=$(mount | grep -o ".\S*FLATPAK_USB" | xargs)
	ln -s "$mount_path/" "/tmp/flatpak_usb"
	cp -n "$HOME/.dotfiles/linux/flatpak_usb.conf" "/tmp/usb.conf"
}
