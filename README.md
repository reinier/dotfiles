# Dot files

My Mac and mechanical keyboard (QMK) configuration

For keyboard firmware install you need [QMK](https://beta.docs.qmk.fm):

- `brew tap homebrew/cask-drivers`
- `brew install --cask qmk-toolbox`
- `brew install qmk/qmk/qmk`
- `qmk setup`

## Keyboards

![My T	echnik keyboard for on the road](/assets/technik.jpg)

After a couple of years experience with normal and low profile, I think I'm leaning towards sticking with low profile and ultra light switches (pink chocs, aka gchocs)

With this [QMK](https://beta.docs.qmk.fm) keymap I try to accomplish a couple of things:

- Keep qwerty my main layout for now, except for P at right pinky
- Only use 34 keys, experimenting with 36 keys again.
- Minimal number of layers for usability
- Dedicated CMD, SHIFT and MEH keys and [home row mods](https://precondition.github.io/home-row-mods) for ALT and CTRL
- Easy sync between all my keyboards
- Minimize pinky use on both sides for ergonomic reasons
- No tap dances
- Minimal use of combos (currently four in use)
- Base layer is always available by tapping right thumb and then left thumb
- Arrows are always available through the extend layer which is a hold on the spacebar away.
- Fast access NUM layer by holding space (extend layer) and tapping right thumb
- A CCCV key (combo on C and V for now) to suck something into the key by holding, and spitting it out by tapping. (CMD-C hold, CMD-V tap)
- I've tried working with a mouse layer, but it's not working for me right now.
- Not too many hold keys, they conflict with my typing speed too much.
- When there is a need for a modifier on a symbol, first hit the modifier on the base layer and then switch to the symbols layer.

### Todo's, needs and wants

- Shift on default thumb. Probably the right one.
- If MEH key doesnt work on dedicated inner thumb keys, move it to hold on G and H.
- On Totem I've got extra pinky keys available, not sure what to do with them or if I even want to.
- I can do a lot more on the Extend layer for Mouse + keyboard use.
- Train yourself in using backspaced on the Extend layer (H key) instead of the top right position (not comfortable at all)

### The keymap and macros for use with the MEH-key

![Keymap base 34 layout](./hammerspoon/keyboard/keymap.png?raw=true)

![Mehmap](./hammerspoon/keyboard/mehmap.png?raw=true)

## Hammerspoon

- To make scrolling easy with the Logi Ergo MX en Kensington mouse
- To serve as my url dispatcher to open links with the correct browser
- Show my keymap with MEH-B
- To do all kinds of other scripting

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
- `ln -s ~/dev/dotfiles/totem ~/qmk_firmware/keyboards/totem/keymaps/reinier`
- `ln -s ~/dev/dotfiles/microdox ~/qmk_firmware/keyboards/boardsource/microdox/keymaps/microdox-reinier`
- `ln -s ~/dev/dotfiles/moonlander-mk3 ~/qmk_firmware/keyboards/moonlander/keymaps/moonlander-mk3`

### Show invisible files in Finder

Hold down the Command, Shift and Period keys: `cmd + shift + .`
