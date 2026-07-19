# This repository has moved ➡️

**This repository has been moved off GitHub and onto my personal [Git page](https://git.kitsugo.com/dotfiles/about/). This GitHub repository only remains as commit-mirror to track activity without any code. For more information and the reason behind this, check [here](https://git.kitsugo.com/?p=about).**

3c2f6be

Commit-Mirroring powered by [autopilot](https://github.com/juni2k/autopilot)

---

# Kitsugo's Dotfiles 🦊

My dotfiles for Arch Linux / Artix Linux. They partially work on Windows as well, but are no longer maintained for it.  
You do not want to directly use these dotfiles as they are heavily tailored toward my setup and rely on the presence of files which are not part of this repository (e.g. `.dotfiles/extra`). However, you are more than welcome to take my dotfiles as inspiration or reference for your own.

## Overview

- Window Manager: **i3 / sway**
- Text editor / IDE: **NeoVim** (Custom config)
- Shell: **Bash**
- Terminal Emulator: **Kitty**
- File Manager: **lf**
- Menus: **rofi**
- Status Bar: **i3blocks** (Using mostly custom C scripts)
- Media Player: **mpv**
- Image Viewer: **nsxiv**
- PDF Viewer: **zathura**

## Setup

### Linux

Required packages to install on Arch Linux:

```
pacman -S openssh git rsync
```

Installation:

```sh
git clone --depth 1 --separate-git-dir=$HOME/.dotfiles https://git.kitsugo.com/git/dotfiles.git dotfiles-tmp
rsync -a --exclude '.git' dotfiles-tmp/ $HOME/
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
