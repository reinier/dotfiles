# Dot files

My Mac and mechanical keyboard (QMK) configuration

For keyboard firmware install you need QMK:

- `brew tap homebrew/cask-drivers`
- `brew install --cask qmk-toolbox`
- `brew install qmk/qmk/qmk`
- `qmk setup`

## Keyboards

With this [QMK](https://beta.docs.qmk.fm) keymap I try to accomplish a couple of things:

- Keep qwerty my main layout for now, except for P at right pinky
- Only use 34 keys
- Minimal number of layers for usability
- All layers available on thumb cluster
- Dedicated CMD and SHIFT keys and [home row mods](https://precondition.github.io/home-row-mods) for ALT and CTRL
- Easy sync between my [Microdox](https://boardsource.xyz/store/5f2e7e4a2902de7151494f92) and [Moonlander](https://www.zsa.io/moonlander/)
- Minimize pinky use on both sides for ergonomic reasons
- Minimal use of tap dances and combos

The keymap:

![Keymap microdox](./keymap.png?raw=true)

The keyboard:

![Microdox keyboard](./microdox.png?raw=true)

## Hammerspoon

- To make scrolling easy with the Logi Ergo MX
- To serve as my url dispatcher to open links with the correct browser
- To move windows
- To do all kinds of scripting

## Other productivity apps

Invisible in this repo, but I also use the following apps to be more productive:

- Keyboard Maestro (I make use of palettes quite heavily)
- Drafts (to quickly jot down notes and script text)
- ~~Alfred~~ (Stopped using it because it overlaps too much with Keyboard Maestro and Hammerspoon)
- CleanShot X (the best screenshot app there is)
- Menuwhere (to navigate app menus with my keyboard)

## Install

Symlink the config directories in the right place. Examples:

- `ln -s ~/dev/dotfiles/z.sh ~/z.sh`
- `ln -s ~/dev/dotfiles/.zprofile ~/.zprofile`
- `ln -s ~/dev/dotfiles/.zshrc ~/.zshrc`
- `ln -s ~/dev/dotfiles/karabiner ~/.config/karabiner`
- `ln -s ~/dev/dotfiles/hammerspoon ~/.hammerspoon`
- `ln -s ~/dev/dotfiles/microdox ~/qmk_firmware/keyboards/boardsource/microdox/keymaps/microdox-mk2`
- `ln -s ~/dev/dotfiles/moonlander ~/qmk_firmware/keyboards/moonlander/keymaps/moonlander-mk2`

Show invisible files in Finder:
Hold down the Command, Shift and Period keys: `cmd + shift + .`
