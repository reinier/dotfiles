# Dot files

My Mac and mechanical keyboard (QMK) configuration

## ‼️ Keymaps are moved to this repository

🚚 [reinier/rlkeymaps](https://github.com/reinier/rlkeymaps)

## Hammerspoon

- To make scrolling easy with the Logi Ergo MX en Kensington mouse. Hold right mouse key and move mouse to scroll.
- To serve as my url dispatcher to open links with the correct browser (not in use for now)
- Show my keymap with MEH-B
- To do all kinds of other scripting
- Handling of the leader key (F19)

## Other productivity apps

Invisible in this repo, but I also use the following apps to be more productive:

- [Amethyst](https://ianyh.com/amethyst/) (for window management)
- [Keyboard Maestro](https://www.keyboardmaestro.com/main/) (I make use of palettes quite heavily)
- [Drafts](https://getdrafts.com/) (to quickly jot down notes and script text)
- [Alfred](https://www.alfredapp.com/) (mostly used for searching through different services)
- [CleanShot X](https://cleanshot.com/) (the best screenshot app there is)

## Repository structure

This repository contains configuration for a couple of tools:

- `hammerspoon` – Lua scripts for [Hammerspoon](https://www.hammerspoon.org/) used for automation and window management.
- `karabiner` – JSON configuration for [Karabiner‑Elements](https://karabiner-elements.pqrs.org/).
- `aerospace.toml` – Configuration for the [Aerospace](https://aerospace.app/) tiling window manager.
- `yabairc` – Settings for the [Yabai](https://github.com/koekeishiya/yabai) window manager.
- `Brewfile` – Homebrew bundle listing applications and command line tools.

## Install dotfiles on a clean system

Run the provided script to create the necessary symlinks:

```bash
./install.sh
```

This will place all configuration files in your `$HOME` directory. You can also
inspect the script and link them manually if you prefer.

### Dependencies

Make sure the following applications are installed:

- [Hammerspoon](https://www.hammerspoon.org/)
- [Karabiner‑Elements](https://karabiner-elements.pqrs.org/)
- [Yabai](https://github.com/koekeishiya/yabai) (optional)
- [Aerospace](https://aerospace.app/) (optional)

All other software I install via Homebrew is listed in `Brewfile`.

### Show / hide invisible files in Finder

Hold down the Command, Shift and Period keys: `cmd + shift + .`

### Remove useless previews from icons in Finder

`defaults write com.apple.finder  QLInlinePreviewMinimumSupportedSize -int 512`

### Set Arc as 'Chrome browser' in Keyboard Maestro

- `defaults write com.stairways.keyboardmaestro.engine AppleScriptGoogleChromeBundleID -string "company.thebrowser.Browser"`
- `defaults write com.stairways.keyboardmaestro.engine BrowserGoogleChromeName -string "Arc"`

## Get and set config for 3rd party apps

For example [Amethyst](https://ianyh.com/amethyst/)

- `defaults export com.amethyst.Amethyst ~/Desktop/Amethyst.plist`
- `defaults import com.amethyst.Amethyst ~/Desktop/Amethyst.plist`