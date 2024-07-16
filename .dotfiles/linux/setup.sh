#!/bin/sh
# Setup additional directives/programs needed for the dotfiles

. "utils.sh"

echo "Install git prompt for bash? [Y/n]"
read_ans_y
[ "$ans" = "y" ] && [ ! -d "$HOME/.local/share/bash-git-prompt/" ] && git clone --depth 1 https://github.com/magicmonty/bash-git-prompt.git ~/.local/share/bash-git-prompt/

echo "Install NerdFonts? [Y/n]"
read_ans_y
if [ "$ans" = "y" ] && [ ! -e "$HOME/.local/share/fonts/JetBrainsMonoNerdFont-Bold.ttf" ]; then # Install fonts by doing a sparse-checkout in tmp
	git clone --filter=blob:none --sparse https://github.com/ryanoasis/nerd-fonts.git /tmp/nerd-fonts/
	cd /tmp/nerd-fonts/ || exit 1
	git sparse-checkout add patched-fonts/JetBrainsMono/Ligatures
	find /tmp/nerd-fonts/patched-fonts/JetBrainsMono/Ligatures/ -type f -name '*.ttf' | grep -v 'Propo\|FontMono' | xargs -I {} cp {} "$HOME/.local/share/fonts/"
	echo "Downloaded and installed NerdFonts!"
fi

### Log Symlink Setups
echo "Setup logfile symlinks? [Y/n]"
read_ans_y
if [ "$ans" = "y" ]; then
	rm "$HOME/.local/state/nvim/log" && ln -s "/tmp/logs/nvim.log" "$HOME/.local/state/nvim/log"
	rm "$HOME/.local/state/nvim/lsp.log" && ln -s "/tmp/logs/lsp.log" "$HOME/.local/state/nvim/lsp.log"
	rm "$HOME/.local/state/nvim/conform.log" && ln -s "/tmp/logs/conform.log" "$HOME/.local/state/nvim/conform.log"
	rm "$HOME/.local/state/nvim/mason.log" && ln -s "/tmp/logs/mason.log" "$HOME/.local/state/nvim/mason.log"
fi
