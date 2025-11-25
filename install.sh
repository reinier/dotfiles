#!/bin/bash
set -euo pipefail

REPO_DIR="$(cd "$(dirname "$0")" && pwd)"

link() {
  src="$REPO_DIR/$1"
  dest="$HOME/$2"
  mkdir -p "$(dirname "$dest")"
  if [ -e "$dest" ]; then
    echo "Skipping $dest (already exists)" >&2
  else
    ln -sf "$src" "$dest"
    echo "Linked $dest -> $src"
  fi
}

link z.sh z.sh
link .zprofile .zprofile
link .zshrc .zshrc
link karabiner .config/karabiner
link hammerspoon .hammerspoon
link aerospace.toml .aerospace.toml
link ghostty .config/ghostty/config

# macOS System Settings
echo "Configuring macOS system settings..."

# Finder
defaults write com.apple.finder AppleShowAllFiles -bool true
defaults write com.apple.finder ShowPathbar -bool true
defaults write com.apple.finder ShowStatusBar -bool true
killall Finder

# Dock
defaults write com.apple.dock autohide -bool true
killall Dock

# Trackpad
defaults write com.apple.AppleMultitouchTrackpad Clicking -bool true
defaults write com.apple.AppleMultitouchTrackpad TrackpadThreeFingerDrag -bool true

# Global settings
defaults write NSGlobalDomain NSNavPanelExpandedStateForSaveMode -bool true
defaults write NSGlobalDomain PMPrintingExpandedStateForPrint -bool true

# Spaces
defaults write com.apple.spaces spans-displays -bool true
killall SystemUIServer

echo "Dotfiles installed."
