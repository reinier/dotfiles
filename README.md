# Dot files

My Mac and mechanical keyboard (QMK) configuration

For keyboard firmware install you need QMK:
`brew tap homebrew/cask-drivers`
`brew install --cask qmk-toolbox`
`brew install qmk/qmk/qmk`
`qmk setup`

## Microdox mk1

With this [QMK](https://beta.docs.qmk.fm) keymap I try to accomplish a couple of things:

- Keep qwerty my main layout for now, except for P at right pinky
- Only use 36 keys
- Minimal number of layers for usability
- All layers available on thumb cluster
- Mods on every layer ([home row mods](https://precondition.github.io/home-row-mods)) except for layer 1. Layers 2 and 3 left hand only.
- Easy sync between my [Microdox](https://boardsource.xyz/store/5f2e7e4a2902de7151494f92) and [Moonlander](https://www.zsa.io/moonlander/)
- Minimize pinky use on both sides for ergonomic reasons
- I can always press the F19 key to make sure I'm on layer 0
- Tab, space and enter should be clear of tap dances to have a pleasurable typing experience

The keymap:

![Keymap microdox](./keymap.png?raw=true)

The keyboard:

![Microdox keyboard](./microdox.png?raw=true)

### TODO's
- Add media keys (layer 5?)

## Install

Symlink the config directories in the right place. Examples:
- `ln -s ~/dev/dotfiles/karabiner ~/.config/karabiner`
- `ln -s ~/dev/dotfiles/z.sh ~/z.sh`
- `ln -s ~/dev/dotfiles/microdox ~/qmk_firmware/keyboards/boardsource/microdox/keymaps/microdox-mk2`
- `ln -s ~/dev/dotfiles/moonlander ~/qmk_firmware/keyboards/moonlander/keymaps/moonlander-mk2`

Show invisible files in Finder: 
Hold down the Command, Shift and Period keys: `cmd + shift + .`