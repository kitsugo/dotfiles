# Kitsugo Dotfiles

These are my Dotfiles for most of the programs I use - they partly work with Windows as well.  
You likely don't want to use these directly, but you are more than welcome to take them as inspiration or reference.

## Setup

#### Linux

```sh
git clone --depth 1 --separate-git-dir=$HOME/.dotfiles git@github.com:kitsugo/dotfiles.git dotfiles-tmp
rsync --recursive --exclude '.git' dotfiles-tmp/ $HOME/
rm --recursive dotfiles-tmp
alias got='git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME'
got config status.showUntrackedFiles no
cd .dotfiles/linux/
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

This project and all its files (if not specified otherwise) are licensed under the terms of the [GNU General Public License v3.0](https://www.gnu.org/licenses/gpl-3.0) license.
