# Dot files

My Mac and mechanical keyboard (QMK) configuration

For keyboard firmware install you need [QMK](https://beta.docs.qmk.fm):

- `brew tap homebrew/cask-drivers`
- `brew install --cask qmk-toolbox`
- `brew install qmk/qmk/qmk`
- `qmk setup`

## Keyboards

With this [QMK](https://beta.docs.qmk.fm) keymap I try to accomplish a couple of things:

- Keep qwerty my main layout for now, except for P at right pinky
- Only use 34 keys (I've tried 36 a couple of times but my thumbs get lost on more then two keys for some reason)
- Minimal number of layers for usability
- Dedicated CMD and SHIFT keys and [home row mods](https://precondition.github.io/home-row-mods) for ALT, CTRL and MEH
- Easy sync between my [Technik](https://boardsource.xyz/store/5ffb9b01edd0447f8023fdb2) and [Moonlander](https://www.zsa.io/moonlander/)
- Minimize pinky use on both sides for ergonomic reasons
- No tap dances
- Minimal use of combos

### The keymap and macros for use with the MEH-key

![Keymap base 34 layout](./hammerspoon/keyboard/keymap.png?raw=true)

![Mehmap](./hammerspoon/keyboard/mehmap.png?raw=true)

## Hammerspoon

- To make scrolling easy with the Logi Ergo MX en Kensington mouse
- To serve as my url dispatcher to open links with the correct browser
- To move windows
- To do all kinds of scripting

## Other productivity apps

Invisible in this repo, but I also use the following apps to be more productive:

- Keyboard Maestro (I make use of palettes quite heavily)
- Drafts (to quickly jot down notes and script text)
- Alfred (mostly used for searching through different services)
- CleanShot X (the best screenshot app there is)

## Install dotfiles on clean system

Symlink the config directories in the right place. Examples:

- `ln -s ~/dev/dotfiles/z.sh ~/z.sh`
- `ln -s ~/dev/dotfiles/.zprofile ~/.zprofile`
- `ln -s ~/dev/dotfiles/.zshrc ~/.zshrc`
- `ln -s ~/dev/dotfiles/karabiner ~/.config/karabiner`
- `ln -s ~/dev/dotfiles/hammerspoon ~/.hammerspoon`
- `ln -s ~/dev/dotfiles/technik ~/qmk_firmware/keyboards/boardsource/technik_o/keymaps/technik-reinier`
- `ln -s ~/dev/dotfiles/moonlander-mk3 ~/qmk_firmware/keyboards/moonlander/keymaps/moonlander-mk3`

### Show invisible files in Finder

Hold down the Command, Shift and Period keys: `cmd + shift + .`
