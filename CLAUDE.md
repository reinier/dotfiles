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
- **Main entry point**: `hammerspoon/init.lua` - streamlined configuration loading only active components
- **Key modifier combinations**:
  - `hyperkey` = {"ctrl", "alt", "shift", "cmd"}
  - `mehkey` = {"ctrl", "alt", "shift"}
  - `reimod` = mehkey (user's custom modifier)
- **Active components only**:
  - **MenuHammer.spoon**: Menu-driven application launcher and action system (F19 key)
  - **FadeLogo.spoon**: Startup visual feedback
  - **SpoonInstall.spoon**: Spoon package manager
  - **showkeymap.lua**: Custom keymap display (MEH-= to toggle between keymap and mehmap)
  - **secrets.lua**: Secure credential management (requires `.secrets.json`)
  - **directory-watchers.lua**: Automated file organization system with computer-specific configuration
- **Configuration**: `menuHammerCustomConfig.lua` defines the complete menu structure with app launchers, window management, audio controls, and system actions
- **Optimized**: Removed unused components (ergomouse, windowmanagement, yabai, appswitcher, etc.) for cleaner configuration

### Window Management
- Uses Aerospace tiling window manager (`aerospace.toml`)
- Menu-driven workspace switching via MenuHammer
- Aerospace commands: `/opt/homebrew/bin/aerospace move-node-to-workspace [1-4]`

### Keyboard Configuration
- Karabiner-Elements setup in `karabiner/` directory
- F19 key serves as leader/menu activation key
- Complex modifications stored in `karabiner/assets/complex_modifications/`

### Directory Watcher System
- **Configuration**: `directory-watchers-config.yaml` - YAML-based configuration for automated file organization
- **Computer-specific targeting**: Each watcher configuration specifies which computer it applies to
- **Path expansion**: Supports `~` (home directory) and relative paths
- **MenuHammer integration**: 
  - **F19 → Scripts → C**: Copy Computer Name (needed for configuration)
  - **F19 → Scripts → S**: Show Directory Watcher Status
  - **F19 → Scripts → L**: Reload Directory Watchers
- **Features**:
  - Monitors source directories for new files
  - Automatically moves files to target directories
  - Creates target directories if they don't exist
  - Provides notifications and console logging
  - Handles errors gracefully
  - Multi-computer safe (only processes watchers for current computer)

### Shell Configuration
- Zsh setup with `.zshrc` and `.zprofile`
- Z shell navigation script (`z.sh`)

## Development Commands

Since this is a configuration repository, there are no traditional build/test commands. Key operations:

- **Apply changes**: `./install.sh` (re-creates symlinks)
- **Install apps**: `brew bundle install`
- **Reload Hammerspoon**: Use MenuHammer menu (F19 → R) or `hs.reload()` in Hammerspoon console
- **Directory Watchers**: Use F19 → Scripts → L to reload configuration after changes
- **Backup Karabiner**: Automatic backups stored in `karabiner/automatic_backups/`

## Testing and Validation

**IMPORTANT**: Lua runtime is NOT installed on this system. Do not attempt to run `lua` commands or test Lua scripts directly via command line. 

- **Hammerspoon Lua Testing**: All Lua code testing must be done within the Hammerspoon environment using the Hammerspoon console or by reloading the configuration
- **Syntax Validation**: Code changes should be validated by reloading Hammerspoon configuration and checking for errors
- **API Testing**: Timer API and other integrations should be tested through the Hammerspoon interface, not standalone Lua execution
- **Directory Watcher Testing**: Test file operations by adding files to configured source directories and verifying they are moved to target locations

## Architecture Notes

- **Hammerspoon Spoons**: Only essential spoons remain in `hammerspoon/Spoons/` directory (MenuHammer, FadeLogo, SpoonInstall)
- **MenuHammer Integration**: Custom menu configuration drives most user interactions via F19 key
- **Secrets Management**: Uses secrets.lua for sensitive configuration (requires `.secrets.json`)
- **Directory Watcher System**: Automated file organization with YAML configuration, computer-specific targeting, and MenuHammer integration
- **Workspace Management**: Aerospace window manager with 4 workspaces, menu-driven controls
- **Application Launching**: Consistent naming scheme for app launchers in MenuHammer config
- **Optimized Configuration**: Cleaned up unused components for better performance and maintainability
- **Single Window Manager**: Uses Aerospace exclusively (removed conflicting Amethyst/Yabai references)

## Backlog & Future Improvements

The `backlog/` directory contains planned improvements and refactoring tasks:

- **Purpose**: Organized storage for enhancement plans, technical debt items, and future feature ideas
- **Format**: Markdown files with structured plans including problem statements, proposed solutions, and implementation strategies
- **Usage**: When suggesting improvements or picking up development work, reference backlog items to understand context and priorities
- **Current Items**: 
  - `timer-api-refactor.md` - Plan to refactor the monolithic timer-api.lua into modular components
  - ~~`directory-watcher-system.md` - Plan for automated file organization system~~ **COMPLETED**

When working on this repository, check the backlog directory for relevant planned improvements that could be implemented alongside current tasks.

## Directory Watcher Configuration Guide

### Setup Process
1. **Get Computer Name**: Use F19 → Scripts → C to copy your computer's identifier
2. **Edit Configuration**: Modify `hammerspoon/directory-watchers-config.yaml`
3. **Reload Watchers**: Use F19 → Scripts → L to apply changes

### Configuration Example
```yaml
watchers:
  - source: "~/Downloads"
    target: "~/Documents/Auto-Sorted"
    computer: "Your-Computer-Name"
    enabled: true
    description: "Auto-sort downloads"
```

### Management Commands
- **F19 → Scripts → C**: Copy Computer Name for configuration
- **F19 → Scripts → S**: Show active watcher status in console
- **F19 → Scripts → L**: Reload directory watcher configuration

### Multi-Computer Support
- Each watcher specifies a `computer` field matching the computer name
- Only watchers for the current computer are activated
- Safe to share configuration across multiple machines via dotfiles

## Key File Locations After Installation

- Hammerspoon: `~/.hammerspoon/`
- Karabiner: `~/.config/karabiner/`
- Aerospace: `~/.aerospace.toml`
- Shell: `~/.zshrc`, `~/.zprofile`, `~/z.sh`