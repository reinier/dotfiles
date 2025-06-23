# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Repository Overview

This is a personal dotfiles repository for macOS productivity and automation setup, focusing on Hammerspoon automation, window management, and application configuration.

## Installation and Setup

- Run `./install.sh` to create symlinks for all configuration files
- Install dependencies with `brew bundle install` (uses Brewfile)
- The install script links configurations to appropriate locations in `$HOME`

## Key Components

### Hammerspoon Configuration (`hammerspoon/`)
- **Main entry point**: `hammerspoon/init.lua` - loads core modules and sets up global keybindings
- **Key modifier combinations**:
  - `hyperkey` = {"ctrl", "alt", "shift", "cmd"}
  - `mehkey` = {"ctrl", "alt", "shift"}
  - `reimod` = mehkey (user's custom modifier)
- **Core modules**:
  - MenuHammer: Menu-driven application launcher and action system (F19 key)
  - FadeLogo: Visual feedback spoon
  - Custom keymap display (MEH-= to toggle)
- **Configuration**: `menuHammerCustomConfig.lua` defines the complete menu structure with app launchers, window management, audio controls, and system actions

### Window Management
- Uses Aerospace tiling window manager (`aerospace.toml`)
- Menu-driven workspace switching via MenuHammer
- Aerospace commands: `/opt/homebrew/bin/aerospace move-node-to-workspace [1-4]`

### Keyboard Configuration
- Karabiner-Elements setup in `karabiner/` directory
- F19 key serves as leader/menu activation key
- Complex modifications stored in `karabiner/assets/complex_modifications/`

### Shell Configuration
- Zsh setup with `.zshrc` and `.zprofile`
- Z shell navigation script (`z.sh`)

## Development Commands

Since this is a configuration repository, there are no traditional build/test commands. Key operations:

- **Apply changes**: `./install.sh` (re-creates symlinks)
- **Install apps**: `brew bundle install`
- **Reload Hammerspoon**: Use MenuHammer menu (F19 → R) or `hs.reload()` in Hammerspoon console
- **Backup Karabiner**: Automatic backups stored in `karabiner/automatic_backups/`

## Architecture Notes

- **Hammerspoon Spoons**: Modular components in `hammerspoon/Spoons/` directory
- **MenuHammer Integration**: Custom menu configuration drives most user interactions
- **Secrets Management**: Uses secrets.lua for sensitive configuration (requires `.secrets.json`)
- **Workspace Management**: Aerospace window manager with 4 workspaces, menu-driven controls
- **Application Launching**: Consistent naming scheme for app launchers in MenuHammer config

## Key File Locations After Installation

- Hammerspoon: `~/.hammerspoon/`
- Karabiner: `~/.config/karabiner/`
- Aerospace: `~/.aerospace.toml`
- Shell: `~/.zshrc`, `~/.zprofile`, `~/z.sh`