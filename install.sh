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

echo "Dotfiles installed."
