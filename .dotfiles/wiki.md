## Common commands:

```sh
# Setup dotfiles
git init --bare $HOME/.dotfiles
alias got='git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME'
got remote add origin git@github.com:kitsugo/dotfiles.git
got config status.showUntrackedFiles no
got add -u
got commit && got push

# Create 1G data file for testing
head -c 1G /dev/urandom > file.txt

# Create an archive while excluding a subdirectory
7z a -x'!dir_to_exclude' archivename.7z /path/to/dir/*

# Purge git history
git purge-hist -m "New Commit"

# Cut song with ffmpeg: START/STOP being xx:xx:xx or seconds
ffmpeg -i file.mkv -ss START -to STOP -c copy file-2.mkv

# Strip mp3tags
for file in *; do id3convert -s "$file"; done
for file in *; do
    if [ -f "$file" ]; then
        id3convert -s "$file";
    fi
done

# Sync bi-directionally, run both commands
rsync -vatu SOURCE/ DEST/
rsync -vatu DEST/ SOURCE/

# Give flatpak file permissions
flatpak override <package_name> --filesystem=<path>

# Make flatpak take gsettings into account
flatpak run --command=$HOME/.config/sway/import-gsettings.sh <package_name>

# Use kitty to get font names
kitty +list-fonts

# Remove tasks in taskwarrior
task delete uid
task status:deleted purge

# Open and close encrypted rive
cryptsetup luksOpen /dev/sdX sdX
# Mount /dev/mapper/sdX
# Unmount /dev/mapper/sdX
cryptsetup luksClose sdX
```

### SSH Config Example

```
Host user1-github
    HostName github.com
    User git
    IdentityFile ~/.ssh/user1_rsa
    IdentitiesOnly yes
    AddKeysToAgent yes
Host user2-github
    HostName github.com
    User git
    IdentityFile ~/.ssh/user2_rsa
    IdentitiesOnly yes
    AddKeysToAgent yes

# If already setup, your Host + Hostname might need to be changed to 'github.com', 'gitlab' etc.
# Test:
# ssh -vT user1-github
# ssh -vT user2-github.
# Cloning:
# git clone user1-github:username1/project.git
# git clone user2-github:username2/project.git.
```

### No auth for polkit actions

In `/usr/share/polkit-1/actions/org.freedesktop.login1.policy`, check these:

```
<defaults>
    <allow_any>yes</allow_any>
    <allow_inactive>yes</allow_inactive>
    <allow_active>yes</allow_active>
</defaults>
```

### XDG-Portal-Desktop

In `/usr/share/xdg-desktop-portal/portals/`, set the `UseIn` flag to have the `XDG_CURRENT_DESKTOP`. In particular, append either `sway` or `i3`.

### OpenSSH on Windows

1. Win+R then type services.msc
2. Look for "OpenSSH Authentication Agent"
3. Choose it, start it and make startup type be Automatic
4. PS1: git config --global core.sshCommand C:/Windows/System32/OpenSSH/ssh.exe
5. Add "Host <name> AddKeysToAgent yes and IdentitiesOnly yes" to ssh-config
6. PS1: ssh-add $HOME/.ssh/your_file_name
7. Potentially restart
