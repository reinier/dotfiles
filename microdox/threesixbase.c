/*

# Everything for a base 36 keyboard keymap like the Microdox

No tap dances. No combos. Home row mods. Only three layers. Zen.

*/

/*

Hook for when switching layers. Now used to 'silently' sent Hammerspoon signals about the keyboard layer. It uses shift and alt to prevent the Mac from beeping when Hammerspoon is running and the keyboard is returning from the OSL to the base layer. `layer_state_set_user` is run multiple times, even in between key down and key up of a key in the OSL. This collides with the F key which then gets the modifier of the One Shot key. I prevent this by adding modifiers to the F keys.

*/

layer_state_t layer_state_set_user(layer_state_t state) {
  switch (get_highest_layer(state)) {
    case 1:
        SEND_STRING(SS_DOWN(X_LSFT) SS_DOWN(X_LALT) SS_TAP(X_F17) SS_UP(X_LSFT) SS_UP(X_LALT)); 
        break;
    case 2:
        SEND_STRING(SS_DOWN(X_LSFT) SS_DOWN(X_LALT) SS_TAP(X_F18) SS_UP(X_LSFT) SS_UP(X_LALT)); 
        break;
    default:
        SEND_STRING(SS_DOWN(X_LSFT) SS_DOWN(X_LALT) SS_TAP(X_F16) SS_UP(X_LSFT) SS_UP(X_LALT)); 
        break;  
  }
  return state;
}

/*

------------------------------------

## 36 Base Keymap

------------------------------------

*/

// # Layer 0

// Top row

#define KR_0_1_1 KC_Q
#define KR_0_1_2 KC_W
#define KR_0_1_3 KC_E
#define KR_0_1_4 KC_R
#define KR_0_1_5 KC_T
//
#define KR_0_1_6 KC_Y
#define KR_0_1_7 KC_U
#define KR_0_1_8 KC_I
#define KR_0_1_9 KC_O
#define KR_0_1_10 KC_BSPC

// Mid row

#define KR_0_2_1 LCTL_T(KC_A)
#define KR_0_2_2 LALT_T(KC_S)
#define KR_0_2_3 LSFT_T(KC_D)
#define KR_0_2_4 LGUI_T(KC_F)
#define KR_0_2_5 KC_G
//
#define KR_0_2_6 KC_H
#define KR_0_2_7 RGUI_T(KC_J)
#define KR_0_2_8 RSFT_T(KC_K)
#define KR_0_2_9 RALT_T(KC_L)
#define KR_0_2_10 RCTL_T(KC_P)

// Bottom row

#define KR_0_3_1 KC_Z
#define KR_0_3_2 KC_X
#define KR_0_3_3 KC_C
#define KR_0_3_4 KC_V
#define KR_0_3_5 KC_B
//
#define KR_0_3_6 KC_N
#define KR_0_3_7 KC_M
#define KR_0_3_8 KC_COMM
#define KR_0_3_9 KC_DOT
#define KR_0_3_10 KC_SLSH

// Thumb cluster

#define KR_0_4_1 KC_TAB
#define KR_0_4_2 KC_SPACE
#define KR_0_4_3 TT(2)

#define KR_0_4_4 OSL(1) 
#define KR_0_4_5 KC_F19 
#define KR_0_4_6 KC_ENTER



// ###### Layer 1 Characters

#define KR_1_1_1 KC_ESC
#define KR_1_1_2 LALT(KC_2) // €
#define KR_1_1_3 KC_MINUS
#define KR_1_1_4 KC_QUOT
#define KR_1_1_5 LSFT(KC_BSLASH)
//
#define KR_1_1_6 LSFT(KC_6)
#define KR_1_1_7 LSFT(KC_LBRC)
#define KR_1_1_8 LSFT(KC_RBRC)
#define KR_1_1_9 KC_DEL
#define KR_1_1_10 KC_BSPC

// Mid row

#define KR_1_2_1 KC_AMPR
#define KR_1_2_2 LSFT(KC_2)
#define KR_1_2_3 KC_EXLM
#define KR_1_2_4 KC_DQUO
#define KR_1_2_5 KC_SCLN
//
#define KR_1_2_6 KC_COLN
#define KR_1_2_7 KC_LPRN
#define KR_1_2_8 KC_RPRN
#define KR_1_2_9 KC_HASH
#define KR_1_2_10 KC_UNDS

// Lower row

#define KR_1_3_1 KC_NO
#define KR_1_3_2 KC_NO
#define KR_1_3_3 KC_NO
#define KR_1_3_4 KC_GRV
#define KR_1_3_5 KC_NO
//
#define KR_1_3_6 KC_TILD
#define KR_1_3_7 KC_LBRC
#define KR_1_3_8 KC_RBRC
#define KR_1_3_9 LOPT(KC_SCLN)
#define KR_1_3_10 KC_BSLASH


#define KR_1_4_1 KC_TRNS
#define KR_1_4_2 KC_TRNS
#define KR_1_4_3 KC_NO

#define KR_1_4_4 KC_TRNS
#define KR_1_4_5 KC_TRNS
#define KR_1_4_6 KC_TRNS

// ##### Layer 2 Navigation and numbers

#define KR_2_1_1 KC_ESC
#define KR_2_1_2 KC_ASTR
#define KR_2_1_3 KC_MINUS
#define KR_2_1_4 KC_PPLS
#define KR_2_1_5 KC_PEQL
//
#define KR_2_1_6 LCTL(KC_TAB)
#define KR_2_1_7 LGUI(KC_GRV)
#define KR_2_1_8 KC_UP
#define KR_2_1_9 KC_DEL
#define KR_2_1_10 KC_BSPC


#define KR_2_2_1 LCTL_T(KC_1)
#define KR_2_2_2 LALT_T(KC_2)
#define KR_2_2_3 LSFT_T(KC_3)
#define KR_2_2_4 LGUI_T(KC_4)
#define KR_2_2_5 KC_5
//
#define KR_2_2_6 KC_COLN
#define KR_2_2_7 KC_LEFT
#define KR_2_2_8 KC_DOWN
#define KR_2_2_9 KC_RGHT
#define KR_2_2_10 KC_CAPS


#define KR_2_3_1 KC_6
#define KR_2_3_2 KC_7
#define KR_2_3_3 KC_8
#define KR_2_3_4 KC_9
#define KR_2_3_5 KC_0
//
#define KR_2_3_6 KC_PERC
#define KR_2_3_7 KC_RGUI
#define KR_2_3_8 KC_TRNS
#define KR_2_3_9 KC_TRNS
#define KR_2_3_10 KC_TRNS

#define KR_2_4_1 KC_TRNS
#define KR_2_4_2 KC_TRNS
#define KR_2_4_3 KC_TRNS

#define KR_2_4_4 KC_NO
#define KR_2_4_5 KC_TRNS
#define KR_2_4_6 KC_TRNS