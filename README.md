# Dot files

Configuration for my Mac and supported applications

## Hammerspoon

- Show my keymap with `MEH-=`
- To do all kinds of other scripting
- Handling of the leader key (F19) to activate apps, scripts, etc.
- To make scrolling easy with the Logi Ergo MX en Kensington mouse. Hold right mouse key and move mouse to scroll. (not in use for now)
- To serve as my url dispatcher to open links with the correct browser (not in use for now)

## Other productivity apps

Invisible in this repo, but I also use the following apps to be more productive:

- [Drafts](https://getdrafts.com/) - to quickly jot down notes and script text
- [Alfred](https://www.alfredapp.com/) - mostly used for searching through different services
- [CleanShot X](https://cleanshot.com/) - the best screenshot app there is
- [Homerow](https://www.homerow.app/)- to be less dependent on mouse
- [Barbee](https://apps.apple.com/us/app/barbee-hide-menu-bar-items/id1548711022) - To manage menubar icons

## Repository structure

This repository contains configuration for a couple of tools:

- `hammerspoon` – Lua scripts for [Hammerspoon](https://www.hammerspoon.org/) used for automation and window management.
- `karabiner` – JSON configuration for [Karabiner‑Elements](https://karabiner-elements.pqrs.org/).
- `aerospace.toml` – Configuration for the [Aerospace](https://aerospace.app/) tiling window manager.
- `Brewfile` – Homebrew bundle listing applications and command line tools.
- `backlog` – Planned improvements and refactoring tasks with detailed implementation plans.

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
- [Aerospace](https://aerospace.app/)

All other software I install via Homebrew is listed in `Brewfile`.

## Need to know after a Mac formatting session

### Show / hide invisible files in Finder

Hold down the Command, Shift and Period keys: `cmd + shift + .`

### Remove useless previews from icons in Finder

`defaults write com.apple.finder  QLInlinePreviewMinimumSupportedSize -int 512`

## Keyboards

I've used multiple (split) ortholineair keyboards recently (since 2022), including a Moonlander, Keychron Q15, Microdox, Geist Totem, and the Glove80.

The Glove80 seemed to be my endgame, but in the end the thing is just too big. I only use a portion of the keys (something like 34), so the space it takes up on my desk feels a bit absurd.

Right now I've settled on the Ferris (the [Halcyon Ferris](https://splitkb.com/collections/keyboard-kits/products/halcyon-ferris) to be precise), which fulfills my needs pretty well.

I'm using VIAL to configure the keyboard, but you can take a look at my keymap in the `hammerspoon/keyboard` directory, where I keep a visual overview of the keymap.

### Learnings

- Combo keys can work for less-used keys, but don't put them on roll-overs like `w`+`e` and `e`+`r`. The `f`+`d` keys are kind of a hidden roll-over because of the heavy use of the `ext` layer in combination with the alt-key.