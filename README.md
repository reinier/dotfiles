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

## Install dotfiles on clean system

Symlink the config directories in the right place.

- `ln -s ~/dev/dotfiles/z.sh ~/z.sh`
- `ln -s ~/dev/dotfiles/.zprofile ~/.zprofile`
- `ln -s ~/dev/dotfiles/.zshrc ~/.zshrc`
- `mkdir .config`
- `ln -s ~/dev/dotfiles/karabiner ~/.config/karabiner`
- `ln -s ~/dev/dotfiles/hammerspoon ~/.hammerspoon`

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