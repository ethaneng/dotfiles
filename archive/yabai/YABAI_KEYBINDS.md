# AeroSpace to Yabai Keybinding Migration Reference

This document provides a comprehensive mapping of all AeroSpace keybindings to their Yabai/skhd equivalents.

## Table of Contents

- [Configuration Structure](#configuration-structure)
- [Keybinding Mappings](#keybinding-mappings)
  - [Window Focus](#window-focus)
  - [Window Movement](#window-movement)
  - [Window Resize](#window-resize)
  - [Workspace Switching](#workspace-switching)
  - [Move Window to Workspace](#move-window-to-workspace)
  - [Layout Management](#layout-management)
  - [Service Mode](#service-mode)
  - [Multi-Monitor](#multi-monitor)
- [Helper Scripts](#helper-scripts)
- [Theme Configuration](#theme-configuration)
- [Setup Instructions](#setup-instructions)

---

## Configuration Structure

The configuration is split into modular files for maintainability:

```
~/.config/
├── skhd/
│   ├── skhdrc                 # Main config (loads all modules)
│   ├── focus.conf             # Window focus bindings
│   ├── move.conf              # Window movement bindings
│   ├── resize.conf            # Window resize bindings
│   ├── workspace.conf         # Workspace switching
│   ├── workspace_move.conf    # Move windows to workspaces
│   ├── layout.conf            # Layout management
│   ├── monitor.conf           # Multi-monitor operations
│   └── modes.conf             # Service mode bindings
├── yabai/
│   ├── yabairc                # Yabai configuration
│   └── helpers/
│       ├── update_borders.sh  # Border toggle on fullscreen
│       ├── wrap_display.sh    # Display wrap-around
│       └── close_others.sh    # Close all but current window
└── theme/
    └── colors.sh              # Centralized color scheme
```

---

## Keybinding Mappings

### Window Focus

| Key | AeroSpace | Yabai | Notes |
|-----|-----------|-------|-------|
| `alt-h` | `focus left --boundaries all-monitors-outer-frame` | `yabai -m window --focus west \|\| yabai -m display --focus west` | Monitor wrap-around |
| `alt-j` | `focus down --boundaries all-monitors-outer-frame` | `yabai -m window --focus south \|\| yabai -m display --focus south` | Monitor wrap-around |
| `alt-k` | `focus up --boundaries all-monitors-outer-frame` | `yabai -m window --focus north \|\| yabai -m display --focus north` | Monitor wrap-around |
| `alt-l` | `focus right --boundaries all-monitors-outer-frame` | `yabai -m window --focus east \|\| yabai -m display --focus east` | Monitor wrap-around |

**File**: `~/.config/skhd/focus.conf`

---

### Window Movement

| Key | AeroSpace | Yabai | Notes |
|-----|-----------|-------|-------|
| `alt-shift-h` | `move left` | `yabai -m window --swap west` | Uses --swap for predictable behavior |
| `alt-shift-j` | `move down` | `yabai -m window --swap south` | Preserves BSP tree structure |
| `alt-shift-k` | `move up` | `yabai -m window --swap north` | |
| `alt-shift-l` | `move right` | `yabai -m window --swap east` | |

**File**: `~/.config/skhd/move.conf`

**Service Mode Alternative**: In service mode, `alt-shift-hjkl` uses `--warp` instead of `--swap` for tree restructuring (closer to AeroSpace's `join-with`).

---

### Window Resize

| Key | AeroSpace | Yabai | Notes |
|-----|-----------|-------|-------|
| `alt-minus` | `resize smart -50` | `yabai -m window --ratio rel:-0.05` | Decreases split ratio by 5% |
| `alt-equal` | `resize smart +50` | `yabai -m window --ratio rel:0.05` | Increases split ratio by 5% |

**File**: `~/.config/skhd/resize.conf`

---

### Workspace Switching

| Key | AeroSpace | Yabai | Notes |
|-----|-----------|-------|-------|
| `alt-y` | `workspace y` | `yabai -m space --focus y` | Requires space label |
| `alt-u` | `workspace u` | `yabai -m space --focus u` | Requires space label |
| `alt-i` | `workspace i` | `yabai -m space --focus i` | Requires space label |
| `alt-o` | `workspace o` | `yabai -m space --focus o` | Requires space label |
| `alt-p` | `workspace p` | `yabai -m space --focus p` | Requires space label |
| `alt-tab` | `workspace-back-and-forth` | `yabai -m space --focus recent` | Perfect match |

**File**: `~/.config/skhd/workspace.conf`

**Required Setup**: Space labels must be configured in `yabairc`:
```bash
yabai -m space 1 --label y
yabai -m space 2 --label u
yabai -m space 3 --label i
yabai -m space 4 --label o
yabai -m space 5 --label p
```

---

### Move Window to Workspace

| Key | AeroSpace | Yabai | Notes |
|-----|-----------|-------|-------|
| `alt-cmd-y` | `move-node-to-workspace y` | `yabai -m window --space y; yabai -m space --focus y` | Follows focus |
| `alt-cmd-u` | `move-node-to-workspace u` | `yabai -m window --space u; yabai -m space --focus u` | Follows focus |
| `alt-cmd-i` | `move-node-to-workspace i` | `yabai -m window --space i; yabai -m space --focus i` | Follows focus |
| `alt-cmd-o` | `move-node-to-workspace o` | `yabai -m window --space o; yabai -m space --focus o` | Follows focus |
| `alt-cmd-p` | `move-node-to-workspace p` | `yabai -m window --space p; yabai -m space --focus p` | Follows focus |

**File**: `~/.config/skhd/workspace_move.conf`

---

### Layout Management

| Key | AeroSpace | Yabai | Notes |
|-----|-----------|-------|-------|
| `alt-slash` | `layout tiles horizontal vertical` | `yabai -m space --layout bsp` | BSP closest to "tiles" |
| `alt-comma` | `layout accordion horizontal vertical` | `yabai -m space --layout stack` | Stack closest to "accordion" |
| `alt-z` | `fullscreen` + callbacks | `yabai -m window --toggle zoom-fullscreen` + triggers | Includes Sketchybar & borders updates |
| `alt-f` | `layout floating tiling` | `yabai -m window --toggle float --grid 20:20:1:1:18:18` | Toggle float with centering |

**File**: `~/.config/skhd/layout.conf`

**Notes**:
- Yabai doesn't have exact "tiles" and "accordion" equivalents
- BSP (Binary Space Partition) is closest to AeroSpace's tiles layout
- Stack layout stacks windows vertically, similar to accordion

---

### Service Mode

| Key | AeroSpace | Yabai | Notes |
|-----|-----------|-------|-------|
| `alt-semicolon` | `mode service` | `skhd --set-mode service` | Enters service mode |
| `esc` (in service) | `reload-config` + exit | `yabai --restart-service` + exit | Reloads and exits |
| `r` (in service) | `flatten-workspace-tree` | `yabai -m space --balance` | Balances window sizes |
| `f` (in service) | `layout floating tiling` | `yabai -m window --toggle float` | Toggle float |
| `backspace` (in service) | `close-all-windows-but-current` | Script: `close_others.sh` | Closes all but focused |
| `alt-shift-h/j/k/l` (in service) | `join-with left/down/up/right` | `yabai -m window --warp [direction]` | Uses --warp for restructuring |

**File**: `~/.config/skhd/modes.conf`

**Visual Feedback**: Service mode changes the active window border color to red (`$THEME_SERVICE`) for visual indication.

---

### Multi-Monitor

| Key | AeroSpace | Yabai | Notes |
|-----|-----------|-------|-------|
| `alt-shift-tab` | `move-workspace-to-monitor --wrap-around next` | Script: `wrap_display.sh next` | Uses helper script for wrap-around |

**File**: `~/.config/skhd/monitor.conf`

**Additional Bindings** (commented out by default):
- `ctrl-alt-1/2/3`: Focus display by number
- `ctrl-cmd-1/2/3`: Move window to display and follow focus
- `ctrl-alt-n/p`: Cycle through displays
- `ctrl-cmd-n/p`: Move window to next/prev display

---

## Helper Scripts

### update_borders.sh

**Location**: `~/.config/yabai/helpers/update_borders.sh`

**Purpose**: Toggle JankyBorders visibility based on fullscreen state

**Usage**: Called automatically from `layout.conf` when toggling fullscreen (`alt-z`)

```bash
# Hide borders in fullscreen, show in normal mode
if [ "$FULLSCREEN" = "true" ]; then
  borders width=0
else
  borders width=5
fi
```

---

### wrap_display.sh

**Location**: `~/.config/yabai/helpers/wrap_display.sh`

**Purpose**: Move current space to next/previous display with wrap-around support

**Usage**: Called from `monitor.conf` with `alt-shift-tab`

```bash
# Calculates next display with wrap-around logic
wrap_display.sh next   # Move to next display
wrap_display.sh prev   # Move to previous display
```

---

### close_others.sh

**Location**: `~/.config/yabai/helpers/close_others.sh`

**Purpose**: Close all windows in current space except the focused one

**Usage**: Called from service mode with `backspace`

```bash
# Closes all non-focused windows in current space
```

---

## Theme Configuration

**Location**: `~/.config/theme/colors.sh`

All color values are centralized in this file for easy theme updates. The file includes:

### Current Theme Variables

```bash
THEME_PRIMARY         # Primary UI accent
THEME_ACTIVE          # Active window highlight
THEME_INACTIVE        # Inactive window
THEME_FOCUSED         # Focused state (blue)
THEME_SERVICE         # Service mode indicator (red)
THEME_BACKGROUND      # Background color
THEME_FOREGROUND      # Foreground text
THEME_SUCCESS         # Success/green
THEME_WARNING         # Warning/yellow
THEME_ERROR           # Error/red
THEME_INFO            # Info/cyan
THEME_OPACITY_ACTIVE  # Active window opacity
THEME_OPACITY_INACTIVE # Inactive window opacity
THEME_BORDER_ACTIVE   # Active border color
THEME_BORDER_INACTIVE # Inactive border color
THEME_BORDER_WIDTH    # Border width in pixels
```

### Included Theme Presets

The colors.sh file includes commented-out presets for:
- **Dracula**: Purple and pink accents
- **Nord**: Blue and arctic color palette
- **Gruvbox Dark**: Warm, retro groove
- **Tokyo Night**: Modern dark theme with blue/purple accents

To switch themes, simply uncomment the desired preset section.

---

## Setup Instructions

### 1. Install Required Tools

```bash
# Install yabai
brew install koekeishiya/formulae/yabai

# Install skhd
brew install koekeishiya/formulae/skhd

# Install jq (for helper scripts)
brew install jq

# Install JankyBorders (optional, for visual borders)
brew tap FelixKratz/formulae
brew install borders
```

### 2. Configure Yabai Scripting Addition (Optional)

For full yabai functionality (SIP partial disable required):

```bash
# Follow instructions at:
# https://github.com/koekeishiya/yabai/wiki/Installing-yabai-(latest-release)#configure-scripting-addition

# Add to sudoers file (visudo):
# <user> ALL=(root) NOPASSWD: sha256:<hash> <yabai> --load-sa
```

### 3. Start Services

```bash
# Start yabai
yabai --start-service

# Start skhd
skhd --start-service

# Start borders (optional)
borders &
```

### 4. Reload Configuration

```bash
# Reload yabai
yabai --restart-service

# Reload skhd
skhd --reload

# Or use service mode: alt-semicolon, then esc
```

### 5. Create Required Spaces

Yabai requires you to manually create spaces initially:

1. Open **Mission Control** (F3 or swipe up with three fingers)
2. Click the **+** button in the top-right to create new desktops
3. Create at least 5 spaces (for y, u, i, o, p workspaces)
4. Restart yabai to apply labels: `yabai --restart-service`

---

## Troubleshooting

### Spaces Not Labeled

**Problem**: Workspace switching doesn't work with letters (y/u/i/o/p)

**Solution**:
1. Ensure you have at least 5 spaces created in Mission Control
2. Restart yabai: `yabai --restart-service`
3. Check labels: `yabai -m query --spaces | jq '.[] | {index, label}'`

### Keybindings Not Working

**Problem**: skhd keybindings don't respond

**Solution**:
1. Check skhd is running: `pgrep skhd`
2. Reload config: `skhd --reload`
3. Check for errors in console: `log stream --process skhd --level debug`
4. Verify Accessibility permissions: System Settings → Privacy & Security → Accessibility

### Helper Scripts Not Executing

**Problem**: Scripts like `update_borders.sh` don't run

**Solution**:
1. Make scripts executable: `chmod +x ~/.config/yabai/helpers/*.sh`
2. Check script paths in skhd configs match actual locations
3. Verify scripts have proper shebang: `#!/usr/bin/env bash`

### Service Mode Visual Feedback Not Showing

**Problem**: Border doesn't change color in service mode

**Solution**:
1. Ensure yabai supports window borders (requires scripting addition)
2. Check if borders is running: `pgrep borders`
3. Verify theme colors are sourced: `source ~/.config/theme/colors.sh`

### JankyBorders Not Updating on Fullscreen

**Problem**: Borders don't hide in fullscreen

**Solution**:
1. Make sure `update_borders.sh` is executable
2. Test script manually: `~/.config/yabai/helpers/update_borders.sh`
3. Check if `jq` is installed: `which jq`

---

## Key Differences from AeroSpace

### Philosophy
- **AeroSpace**: Automatic tree-based container management
- **Yabai**: Manual BSP (Binary Space Partition) management

### Container Management
- **AeroSpace**: Automatic container creation and normalization
- **Yabai**: Manual tree structure with explicit control

### Floating Windows
- **AeroSpace**: Uses `[[on-window-detected]]` rules in TOML
- **Yabai**: Uses `yabai -m rule --add` in yabairc

### Layout Differences
- **AeroSpace tiles**: → Yabai BSP
- **AeroSpace accordion**: → Yabai stack
- No direct equivalent to AeroSpace's `join-with` (uses `--warp` as closest alternative)

### Callbacks
- **AeroSpace**: `exec-on-workspace-change`, `on-focus-changed`
- **Yabai**: `yabai -m signal` for event handling

---

## Additional Yabai Features

These features don't exist in your AeroSpace config but are available in yabai:

### Balance Windows
```bash
shift + alt - 0 : yabai -m space --balance
```

### Rotate/Mirror Tree
```bash
alt - r : yabai -m space --rotate 90          # Rotate 90°
alt - x : yabai -m space --mirror x-axis       # Mirror horizontally
alt - y : yabai -m space --mirror y-axis       # Mirror vertically
```

### Window Zoom
```bash
alt - d : yabai -m window --toggle zoom-parent # Toggle parent zoom
```

### Sticky Windows
```bash
alt - s : yabai -m window --toggle sticky      # Window on all spaces
```

### Picture-in-Picture
```bash
alt - p : yabai -m window --toggle sticky --toggle pip
```

### Insertion Point
```bash
ctrl + alt - h : yabai -m window --insert west
ctrl + alt - j : yabai -m window --insert south
ctrl + alt - k : yabai -m window --insert north
ctrl + alt - l : yabai -m window --insert east
```

---

## Quick Reference Card

### Most Common Keybindings

| Action | Key |
|--------|-----|
| Focus window | `alt-hjkl` |
| Move window | `alt-shift-hjkl` |
| Resize window | `alt-minus/equal` |
| Switch workspace | `alt-yuiop` |
| Move to workspace | `alt-cmd-yuiop` |
| Back to recent workspace | `alt-tab` |
| Toggle fullscreen | `alt-z` |
| Toggle floating | `alt-f` |
| Enter service mode | `alt-semicolon` |
| Exit service mode | `esc` (in service mode) |

---

## Updating Your Theme

To change your color scheme:

1. Edit `~/.config/theme/colors.sh`
2. Either modify existing values or uncomment a preset theme
3. Reload yabai: `yabai --restart-service`
4. Reload skhd: `skhd --reload`
5. Restart borders: `killall borders && borders &`

Example - Switch to Dracula theme:
```bash
# In colors.sh, uncomment the Dracula section
# Then reload services:
yabai --restart-service
skhd --reload
killall borders && borders &
```

---

## Resources

- [Yabai Documentation](https://github.com/koekeishiya/yabai)
- [skhd Documentation](https://github.com/koekeishiya/skhd)
- [JankyBorders](https://github.com/FelixKratz/JankyBorders)
- [AeroSpace Documentation](https://nikitabobko.github.io/AeroSpace/)

---

*Generated as part of AeroSpace to Yabai migration*
