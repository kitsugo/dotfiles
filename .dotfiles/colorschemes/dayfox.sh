#!/bin/sh
# Dayfox colorscheme definitions

background=#f6f2ee
foreground=#3d2b5a
color0=#352c24
color1=#a5222f
color2=#396847
color3=#ac5402
color4=#2848a9
color5=#6e33ce
color6=#287980
color7=#f2e9e1
color8=#534c45
color9=#b3434e
color10=#577f63
color11=#b86e28
color12=#4863b6
color13=#8452d5
color14=#488d93
color15=#f4ece6
color16=#955f61
color17=#a440b5

# Color inputs
# I3bar / Swaybar
export U_COLOR_BAR_BG="$background"
export U_COLOR_BAR_FWS1="$color1"
export U_COLOR_BAR_FWS2="$color9"
export U_COLOR_BAR_FWS3="$color7"
export U_COLOR_BAR_IWS1=#837a72
export U_COLOR_BAR_IWS2=#e7d2be
export U_COLOR_BAR_IWS3="$color0"
export U_COLOR_BAR_UWS1="$color4"
export U_COLOR_BAR_UWS2="$color12"
export U_COLOR_BAR_UWS3="$color7"

# I3blocks
export U_COLOR_BLOCKS_BG1=#e7d2be
export U_COLOR_BLOCKS_BG2=#e4dcd4
export U_COLOR_BLOCKS_BG3=#f2e9e1
export U_COLOR_BLOCKS_1="$color1"
export U_COLOR_BLOCKS_2="$color3"
export U_COLOR_BLOCKS_3="$color2"
export U_COLOR_WARN="$color4"
export U_COLOR_CRIT="$color5"

# External themes and resources
export U_KITTY_THEME="$HOME/.config/kitty/theme_dayfox.conf"
