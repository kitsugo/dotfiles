# Setup additional directives/programs needed for the dotfiles


# Create Windows-specific hardlinks / junctions to all necessary config files - This will overwrite exisisting configs!
# Neovim
if ( -not (Test-Path -Path '~\AppData\Local\nvim\' -PathType Container) ) {
	New-Item -ItemType Junction -Path ~\AppData\Local\nvim\ -Value .\..\..\.config\nvim\ -Force
}
# LF
if ( -not (Test-Path -Path '~\AppData\Local\lf\' -PathType Container) ) {
	New-Item -ItemType Junction -Path ~\AppData\Local\lf\ -Value .\lf\ -Force
}
# Git Config
New-Item -ItemType HardLink -Path ~\.gitconfig -Value .\..\..\.config\git\config -Force
# LF Icons
New-Item -ItemType HardLink -Path .\lf\icons -Value .\..\..\.config\lf\icons -Force
# PWS Profile
New-Item -ItemType HardLink -Path $PROFILE -Value .\profile.ps1 -Force
# WST Settings
New-Item -ItemType HardLink -Path ~\AppData\Local\Packages\Microsoft.WindowsTerminal_8wekyb3d8bbwe\LocalState\settings.json -Value .\wt_settings.json -Force
