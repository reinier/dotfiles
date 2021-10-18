# Microdox mk1

With this [QMK](https://beta.docs.qmk.fm) keymap I try to accomplish a couple of things:

- Keep qwerty my main layout for now, except for P at right pinky
- Only use 36 keys
- Minimal number of layers for usability
- All layers available on thumb cluster
- Mods on every layer ([home row mods](https://precondition.github.io/home-row-mods), layers 2 and 3 left hand only)
- Easy sync between my [Microdox](https://boardsource.xyz/store/5f2e7e4a2902de7151494f92) and [Moonlander](https://www.zsa.io/moonlander/) ([my Moonlander keymap](https://github.com/reinier/moonlander-mk1)) by adding an extra mapping in `definekeys.c`
- Minimize pinky use on both sides for ergonomic reasons
- I can always press the Hyper key to make sure I'm on layer 0
- Tab and space should be clear of tap dances to have a pleasurable typing experience

The keymap:

![Keymap microdox](./keymap.png?raw=true)

The keyboard:

![Microdox keyboard](./microdox.png?raw=true)

## TODO's
- Add media keys (layer 5?)
- Redefine A keys on layers 2 … 4
  - Right mouse on P?
  - Left mouse on mid right thumb key?
- Move `:` for layer 1 and 3 to same key on `P`? Move `!` to `L` and `;` to `.` and `=` to `G`
- Move CAPS to A on layer 2? (doesn't work with MOD)
- NAV home row left hand: open apps with F keys? (use hammerspoon? - Chrome, Slack, Safari, Craft, Omnifocus - Use tapdances to combine Chrome and Safari for example)