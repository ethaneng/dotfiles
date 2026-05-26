#!/usr/bin/env bash

# ################################################################ #
# Centralized Theme Configuration
# ################################################################ #
#
# This file contains all color definitions for your dotfiles.
# Source this file in yabairc and other configs to maintain a
# cohesive theme across all tools.
#
# To change your theme:
# 1. Update the color values below
# 2. Reload yabai: yabai --restart-service
# 3. Reload borders: borders &
# 4. Update any other configs that use these colors
#
# Color format: 0xAARRGGBB (AA = alpha, RR = red, GG = green, BB = blue)
#

# Primary accent colors
export THEME_PRIMARY="0xff5c6370"      # Primary UI accent
export THEME_ACTIVE="0xffd75f5f"       # Active window highlight
export THEME_INACTIVE="0xff3e4451"     # Inactive window
export THEME_FOCUSED="0xff61afef"      # Focused state (blue)
export THEME_SERVICE="0xffff6c6b"      # Service mode indicator (red)

# Background and foreground
export THEME_BACKGROUND="0xff282c34"   # Background color
export THEME_FOREGROUND="0xffabb2bf"   # Foreground text

# Status colors
export THEME_SUCCESS="0xff98c379"      # Success/green
export THEME_WARNING="0xffe5c07b"      # Warning/yellow
export THEME_ERROR="0xffe06c75"        # Error/red
export THEME_INFO="0xff56b6c2"         # Info/cyan

# Opacity values
export THEME_OPACITY_ACTIVE="1.0"      # Active window opacity
export THEME_OPACITY_INACTIVE="0.90"   # Inactive window opacity

# Border settings
export THEME_BORDER_ACTIVE="0xffd75f5f"    # Active border color
export THEME_BORDER_INACTIVE="0xff3e4451"  # Inactive border color
export THEME_BORDER_WIDTH="5"              # Border width in pixels

# Window manager specific
export THEME_INSERT_FEEDBACK="0xffd75f5f"  # Insertion point indicator

# ################################################################ #
# Theme Presets (uncomment one to use)
# ################################################################ #

# Current Theme: Custom
# (Using the colors defined above)

# Dracula Theme (uncomment to use)
# export THEME_PRIMARY="0xff6272a4"
# export THEME_ACTIVE="0xffff79c6"
# export THEME_INACTIVE="0xff44475a"
# export THEME_FOCUSED="0xffbd93f9"
# export THEME_SERVICE="0xffff5555"
# export THEME_BACKGROUND="0xff282a36"
# export THEME_FOREGROUND="0xfff8f8f2"
# export THEME_SUCCESS="0xff50fa7b"
# export THEME_WARNING="0xfff1fa8c"
# export THEME_ERROR="0xffff5555"
# export THEME_INFO="0xff8be9fd"
# export THEME_BORDER_ACTIVE="0xffff79c6"
# export THEME_BORDER_INACTIVE="0xff44475a"

# Nord Theme (uncomment to use)
# export THEME_PRIMARY="0xff5e81ac"
# export THEME_ACTIVE="0xff88c0d0"
# export THEME_INACTIVE="0xff3b4252"
# export THEME_FOCUSED="0xff81a1c1"
# export THEME_SERVICE="0xffbf616a"
# export THEME_BACKGROUND="0xff2e3440"
# export THEME_FOREGROUND="0xffeceff4"
# export THEME_SUCCESS="0xffa3be8c"
# export THEME_WARNING="0xffebcb8b"
# export THEME_ERROR="0xffbf616a"
# export THEME_INFO="0xff8fbcbb"
# export THEME_BORDER_ACTIVE="0xff88c0d0"
# export THEME_BORDER_INACTIVE="0xff3b4252"

# Gruvbox Dark Theme (uncomment to use)
# export THEME_PRIMARY="0xff928374"
# export THEME_ACTIVE="0xfffb4934"
# export THEME_INACTIVE="0xff3c3836"
# export THEME_FOCUSED="0xff83a598"
# export THEME_SERVICE="0xffcc241d"
# export THEME_BACKGROUND="0xff282828"
# export THEME_FOREGROUND="0xffebdbb2"
# export THEME_SUCCESS="0xffb8bb26"
# export THEME_WARNING="0xfffabd2f"
# export THEME_ERROR="0xfffb4934"
# export THEME_INFO="0xff8ec07c"
# export THEME_BORDER_ACTIVE="0xfffb4934"
# export THEME_BORDER_INACTIVE="0xff3c3836"

# Tokyo Night Theme (uncomment to use)
# export THEME_PRIMARY="0xff7aa2f7"
# export THEME_ACTIVE="0xffbb9af7"
# export THEME_INACTIVE="0xff3b4261"
# export THEME_FOCUSED="0xff7dcfff"
# export THEME_SERVICE="0xfff7768e"
# export THEME_BACKGROUND="0xff1a1b26"
# export THEME_FOREGROUND="0xffc0caf5"
# export THEME_SUCCESS="0xff9ece6a"
# export THEME_WARNING="0xffe0af68"
# export THEME_ERROR="0xfff7768e"
# export THEME_INFO="0xff7dcfff"
# export THEME_BORDER_ACTIVE="0xffbb9af7"
# export THEME_BORDER_INACTIVE="0xff3b4261"
