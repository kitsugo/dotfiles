# Dotfiles

Dotfiles for all the programs I use - partly works with Microsoft Windows as well.

You probably don't want to use these directly, but rather create your own, personal dotfiles.
However, you're more than welcome to take inspiration from them.

## Setup

#### Linux

```sh
git clone --depth 1 --separate-git-dir=$HOME/.dotfiles git@github.com:kitsugo/dotfiles.git dotfiles-tmp
rsync --recursive --exclude '.git' dotfiles-tmp/ $HOME/
rm --recursive dotfiles-tmp
alias got='git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME'
got config status.showUntrackedFiles no
cd .dotfiles/
./setup.sh
```

#### Windows

```powershell
git clone --depth 1 git@github.com:kitsugo/dotfiles.git windotfiles
git config status.showUntrackedFiles no
cd .\.dotfiles\windows\
.\setup.ps1
```

## License

This project and all its files are licensed under the terms of the [GNU General Public License v3.0](https://www.gnu.org/licenses/gpl-3.0) license.
