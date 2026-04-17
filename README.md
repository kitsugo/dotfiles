# 🦊 Kitsugo's Dotfiles

**This repository has been moved off GitHub and onto my personal [Git page](https://git.kitsugo.com/dotfiles/). This repository only remains as commit-mirror to track activity without any code. For more information check [here](https://git.kitsugo.com/?p=about).**

247f5b0

Commit-Mirroring powered by [autopilot](https://github.com/juni2k/autopilot)

---

My Dotfiles for Arch Linux / Artix Linux. They partly work with Windows as well, but are no longer maintained for that.  
You do not want to use these dotfiles directly since they are heavily tailored toward my setup and rely on the presence of non-public files (".dotfiles/extra"). However, you are more than welcome to take them as inspiration or reference for your own Dotfiles.

## Software

- Window Manager: **i3 / sway** (Switch Hyprland in progress)
- Text editor / IDE: **NeoVim** (Custom config)
- Shell: **Bash**
- Terminal Emulator: **Kitty**
- File Manager: **lf**
- Dynamic Menu: **rofi**
- Status Bar: **i3blocks** (Mostly custom C scripts)

## Setup

### Linux

Required packages to install on Arch Linux:

```
pacman -S openssh git rsync
```

Installation:

```sh
git clone --depth 1 --separate-git-dir=$HOME/.dotfiles https://git.kitsugo.com/git/dotfiles.git dotfiles-tmp
rsync --recursive --exclude '.git' dotfiles-tmp/ $HOME/
rm --recursive dotfiles-tmp
alias got='git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME'
got config status.showUntrackedFiles no
cd .dotfiles/linux/
./dotfiles_setup.sh
```

### Windows

```powershell
git clone --depth 1 https://git.kitsugo.com/git/dotfiles.git windotfiles
git config status.showUntrackedFiles no
cd .\.dotfiles\windows\
.\dotfiles_setup.ps1
```

## License

This project and all its files (if not specified otherwise) are licensed under the terms of the [GNU General Public License v3.0](https://www.gnu.org/licenses/gpl-3.0) license.
