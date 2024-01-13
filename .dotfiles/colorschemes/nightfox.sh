#!/bin/sh
# Nightfox colorscheme definitions

# Color definitions
background=#192330
foreground=#cdcecf
color0=#393b44
color1=#c94f6d
color2=#81b29a
color3=#dbc074
color4=#719cd6
color5=#9d79d6
color6=#63cdcf
color7=#dfdfe0
color8=#575860
color9=#d16983
color10=#8ebaa4
color11=#e0c989
color12=#86abdc
color13=#baa1e2
color14=#7ad5d6
color15=#e4e4e5
color16=#f4a261
color17=#d67ad2

# Color inputs
# I3bar / Swaybar
export U_COLOR_BAR_BG="$background"
export U_COLOR_BAR_FWS1="$color5"
export U_COLOR_BAR_FWS2="$color13"
export U_COLOR_BAR_FWS3="$color0"
export U_COLOR_BAR_IWS1=#738091
export U_COLOR_BAR_IWS2=#2b3b51
export U_COLOR_BAR_IWS3="$color7"
export U_COLOR_BAR_UWS1="$color3"
export U_COLOR_BAR_UWS2="$color11"
export U_COLOR_BAR_UWS3="$color0"

# I3blocks
export U_COLOR_BLOCKS_BG1="$background"
export U_COLOR_BLOCKS_BG2=#2b3b51
export U_COLOR_BLOCKS_BG3=#39506d
export U_COLOR_BLOCKS_1="$color5"
export U_COLOR_BLOCKS_2="$color4"
export U_COLOR_BLOCKS_3="$color2"
export U_COLOR_BLOCKS_4="$color11"
export U_COLOR_BLOCKS_5="$color6"
export U_COLOR_BLOCKS_6="$color17"
export U_COLOR_WARN="$color11"
export U_COLOR_CRIT="$color16"

# External themes and resources
export U_KITTY_THEME="$HOME/.config/kitty/theme_nightfox.conf"
export U_COLORSCHEME="nightfox"
