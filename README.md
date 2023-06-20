# Dot files

My Mac and mechanical keyboard (QMK) configuration

For keyboard firmware install you need [QMK](https://beta.docs.qmk.fm):

- `brew tap homebrew/cask-drivers`
- `brew install --cask qmk-toolbox`
- `brew install qmk/qmk/qmk`
- `qmk setup`

## Keyboards

![My Totem](/assets/totem.jpg)

After a couple of years experience with normal and low profile, I think I'm leaning towards sticking with low profile and ultra light switches (pink chocs, aka gchocs). My main keyboard right now is the Geist Totem with more keys then I need.

I named my [keymap Qweighteen and wrote a blogpost about its genesis](https://reinierladan.nl/blog/2023/qweighteen-keymap/). @benvallack is the main inspiration for going 18-keys only on the non-base layers.

With this [QMK](https://beta.docs.qmk.fm) keymap I try to accomplish a couple of things:

- Keep qwerty my main layout for now, except for P at right pinky
- Only use 32 keys on base layer and focus on 18 keys on other layers for usability (and sometime in the future migrate to a 100% 18-key keyboard).
- Minimal number of layers for usability
- Dedicated CMD and SHIFT keys and [home row mods](https://precondition.github.io/home-row-mods) for all the mods
- Easy sync between all my keyboards (but my main focus right now is the Totem, so other keymaps can be out of date)
- Minimize pinky use on both sides for ergonomic reasons
- No tap dances (can't get them to work comfortable)
- Space without meh-key on hold is present on Extend layer to use when selection stuff in graphical editor or screenshot tool
- Caps Word is a more convenient option compared to Capslock. After you typed a single word in all capital letters, the keyboard automatically returns to lowercase letters.
- Minimal use of combos (currently two in use)
- Lock layers with alternative right thumb key
- Base layer is always available by tapping leader key position (when on base layer, hammerspoon will show the hammermenu so you know you are on the base layer)
- A CCCV key (called `CP` on keymap) to suck something into the key by holding, and spitting it out by tapping. (CMD-C hold, CMD-V tap)

### Todo's, needs and wants

- I've tried working with a mouse layer, but it's not working for me right now. Will try again when absolutely comfortable with the current keymap.
- I can do a lot more on the Extend layer for Mouse + keyboard use.
- Find a place for media controls and F keys. Probably need new layer.
- Learn to get value out of a repeat key. Tried it once, didn't stick. Could replace the leader key on right thumb.
- Turn leader key in Layer Lock key on non-base layers.

### The keymap and macros for use with the MEH-key

![Keymap base 32 layout](./hammerspoon/keyboard/keymap.png?raw=true)

![Mehmap](./hammerspoon/keyboard/mehmap.png?raw=true)

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

Symlink the config directories in the right place. Examples:

- `ln -s ~/dev/dotfiles/z.sh ~/z.sh`
- `ln -s ~/dev/dotfiles/.zprofile ~/.zprofile`
- `ln -s ~/dev/dotfiles/.zshrc ~/.zshrc`
- `ln -s ~/dev/dotfiles/karabiner ~/.config/karabiner`
- `ln -s ~/dev/dotfiles/hammerspoon ~/.hammerspoon`
- `ln -s ~/dev/dotfiles/totem ~/qmk_firmware/keyboards/totem/keymaps/reinier`
- `ln -s ~/dev/dotfiles/technik ~/qmk_firmware/keyboards/boardsource/technik_o/keymaps/technik-reinier`
- `ln -s ~/dev/dotfiles/microdox ~/qmk_firmware/keyboards/boardsource/microdox/keymaps/microdox-reinier`
- `ln -s ~/dev/dotfiles/moonlander-mk3 ~/qmk_firmware/keyboards/moonlander/keymaps/moonlander-mk3`

### Build QMK keyboard firmware

- `qmk compile -kb totem -km reinier`

### Show / hide invisible files in Finder

Hold down the Command, Shift and Period keys: `cmd + shift + .`

### Remove useless previews from icons in Finder

`defaults write com.apple.finder  QLInlinePreviewMinimumSupportedSize -int 512`
