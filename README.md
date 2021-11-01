# Dot files

My Mac and mechanical keyboard (QMK) configuration

For keyboard firmware install you need QMK:
`brew tap homebrew/cask-drivers`
`brew install --cask qmk-toolbox`
`brew install qmk/qmk/qmk`
`qmk setup`

## Keyboards

With this [QMK](https://beta.docs.qmk.fm) keymap I try to accomplish a couple of things:

- Keep qwerty my main layout for now, except for P at right pinky
- Only use 36 keys
- Minimal number of layers for usability
- All layers available on thumb cluster
- Mods on every layer (1/2 [home row mods](https://precondition.github.io/home-row-mods)) with dedicated CMD and SHIFT keys.
- Easy sync between my [Microdox](https://boardsource.xyz/store/5f2e7e4a2902de7151494f92) and [Moonlander](https://www.zsa.io/moonlander/)
- Minimize pinky use on both sides for ergonomic reasons
- No tap dances. No combos.

The keymap:

![Keymap microdox](./keymap.png?raw=true)

The keyboard:

![Microdox keyboard](./microdox.png?raw=true)

## Hammerspoon

- To display the current layer of my mechanical 36-key keyboard
- To make scrolling easy with the Logi Ergo MX
- To serve as my url dispatcher to open links with the correct browser
- To move windows
- For easy app switching
- To do all kinds of scripting
- Some scripts available in hyper hyper mode (Hyper+H)

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