/*

# Everything for a base 36 keyboard keymap like the Microdox

*/

/*

Hook for when switching layers. Now used to 'silently' sent Hammerspoon signals about the keyboard layer. It uses shift and alt to prevent the Mac from beeping when Hammerspoon is running and the keyboard is returning from the OSL to the base layer. `layer_state_set_user` is run multiple times, even in between key down and key up of a key in the OSL. This collides with the F key which then gets the modifier of the One Shot key. I prevent this by adding modifiers to the F keys.

*/


// #include "print.h"

layer_state_t layer_state_set_user(layer_state_t state) {
  switch (get_highest_layer(state)) {
    case 1:
        SEND_STRING(SS_DOWN(X_LSFT) SS_DOWN(X_LALT) SS_TAP(X_F17) SS_UP(X_LSFT) SS_UP(X_LALT)); 
        break;
    case 2:
        SEND_STRING(SS_DOWN(X_LSFT) SS_DOWN(X_LALT) SS_TAP(X_F18) SS_UP(X_LSFT) SS_UP(X_LALT)); 
        break;
    case 3:
        SEND_STRING(SS_DOWN(X_LSFT) SS_DOWN(X_LALT) SS_TAP(X_F19) SS_UP(X_LSFT) SS_UP(X_LALT)); 
        break;    
    default:
        //print("reinier");
        SEND_STRING(SS_DOWN(X_LSFT) SS_DOWN(X_LALT) SS_TAP(X_F16) SS_UP(X_LSFT) SS_UP(X_LALT)); 
        break;  
  }
  return state;
}

// COMBOS

// enum combos {
//   C_UP,
//   C_DOWN,
//   C_LEFT,
//   C_RIGHT,
//   COMBO_LENGTH
// };
// 
// uint16_t COMBO_LEN = COMBO_LENGTH;
// 
// const uint16_t PROGMEM combo_left[]  = {KC_N, KC_M, COMBO_END};
// const uint16_t PROGMEM combo_down[]  = {KC_M, KC_COMM, COMBO_END};
// const uint16_t PROGMEM combo_up[]    = {KC_COMM, KC_DOT, COMBO_END};
// const uint16_t PROGMEM combo_right[] = {KC_DOT, KC_SLSH, COMBO_END};
// 
// combo_t key_combos[] = {
//     [C_LEFT]  = COMBO(combo_left, KC_LEFT),
//     [C_DOWN]  = COMBO(combo_down, KC_DOWN),
//     [C_UP]    = COMBO(combo_up, KC_UP),
//     [C_RIGHT] = COMBO(combo_right, KC_RGHT),
// };

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

#define KR_0_2_1 KC_A
#define KR_0_2_2 KC_S
#define KR_0_2_3 LCTL_T(KC_D)
#define KR_0_2_4 LALT_T(KC_F)
#define KR_0_2_5 KC_G
//
#define KR_0_2_6 KC_H
#define KR_0_2_7 RALT_T(KC_J)
#define KR_0_2_8 RCTL_T(KC_K)
#define KR_0_2_9 KC_L
#define KR_0_2_10 KC_P

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
#define KR_0_4_3 OSM(MOD_LSFT)

#define KR_0_4_4 OSM(MOD_LGUI)
#define KR_0_4_5 TO(1)
#define KR_0_4_6 HYPR_T(KC_ENTER)



// ###### Layer 1 Characters

#define KR_1_1_1 KC_ESC
#define KR_1_1_2 KC_DEL
#define KR_1_1_3 LALT(KC_2) // €
#define KR_1_1_4 LSFT(KC_6)
#define KR_1_1_5 LSFT(KC_BSLASH)

// #define KR_1_1_3 
// #define KR_1_1_4 
// #define KR_1_1_5 LSFT(KC_BSLASH)
//
#define KR_1_1_6 KC_AMPR
#define KR_1_1_7 LSFT(KC_LBRC)
#define KR_1_1_8 LSFT(KC_RBRC)
#define KR_1_1_9 KC_UNDS
#define KR_1_1_10 KC_BSPC

// Mid row

#define KR_1_2_1 LSFT(KC_2) // @
#define KR_1_2_2 KC_DQUO
#define KR_1_2_3 KC_QUOT
#define KR_1_2_4 KC_MINUS
#define KR_1_2_5 KC_EXLM
//
#define KR_1_2_6 KC_COLN
#define KR_1_2_7 KC_LPRN
#define KR_1_2_8 KC_RPRN
#define KR_1_2_9 KC_HASH
#define KR_1_2_10 KC_PEQL

// Lower row

#define KR_1_3_1 KC_TILD
#define KR_1_3_2 KC_BSLASH
#define KR_1_3_3 KC_GRV
#define KR_1_3_4 KC_PPLS
#define KR_1_3_5 KC_ASTR
//
#define KR_1_3_6 KC_SCLN
#define KR_1_3_7 KC_LBRC
#define KR_1_3_8 KC_RBRC
#define KR_1_3_9 LOPT(KC_SCLN)
#define KR_1_3_10 TO(3)


#define KR_1_4_1 KC_TRNS
#define KR_1_4_2 TO(0)
#define KR_1_4_3 KC_TRNS

#define KR_1_4_4 KC_TRNS
#define KR_1_4_5 TO(2)
#define KR_1_4_6 KC_TRNS

// ##### Layer 2 Numbers

#define KR_2_1_1 KC_ESC
#define KR_2_1_2 KC_DEL
#define KR_2_1_3 KC_TRNS
#define KR_2_1_4 KC_PERC
#define KR_2_1_5 KC_NO
//
#define KR_2_1_6 KC_NO
#define KR_2_1_7 KC_7
#define KR_2_1_8 KC_8
#define KR_2_1_9 KC_9
#define KR_2_1_10 KC_BSPC


#define KR_2_2_1 KC_NO
#define KR_2_2_2 KC_DOT
#define KR_2_2_3 LCTL_T(KC_COMM)
#define KR_2_2_4 LALT_T(KC_MINUS)
#define KR_2_2_5 KC_NO
//
#define KR_2_2_6 KC_TRNS
#define KR_2_2_7 RALT_T(KC_4)
#define KR_2_2_8 RCTL_T(KC_5)
#define KR_2_2_9 KC_6
#define KR_2_2_10 KC_TRNS


#define KR_2_3_1 KC_NO
#define KR_2_3_2 KC_NO
#define KR_2_3_3 KC_SLSH
#define KR_2_3_4 KC_TRNS
#define KR_2_3_5 KC_TRNS
//
#define KR_2_3_6 KC_0
#define KR_2_3_7 KC_1
#define KR_2_3_8 KC_2
#define KR_2_3_9 KC_3
#define KR_2_3_10 TO(3)

#define KR_2_4_1 KC_TRNS
#define KR_2_4_2 TO(0)
#define KR_2_4_3 KC_TRNS

#define KR_2_4_4 KC_TRNS
#define KR_2_4_5 TO(1)
#define KR_2_4_6 KC_TRNS

// ##### Layer 3 Navigation

#define KR_3_1_1 KC_ESC
#define KR_3_1_2 KC_DEL
#define KR_3_1_3 KC_CAPS
#define KR_3_1_4 LGUI(KC_GRV)
#define KR_3_1_5 LCTL(KC_TAB)
//
#define KR_3_1_6 KC_NO
#define KR_3_1_7 KC_NO
#define KR_3_1_8 KC_UP
#define KR_3_1_9 KC_NO
#define KR_3_1_10 KC_BSPC


#define KR_3_2_1 KC_NO
#define KR_3_2_2 KC_NO
#define KR_3_2_3 KC_LCTL
#define KR_3_2_4 KC_LALT
#define KR_3_2_5 KC_NO
//
#define KR_3_2_6 KC_NO
#define KR_3_2_7 KC_LEFT
#define KR_3_2_8 KC_DOWN
#define KR_3_2_9 KC_RGHT
#define KR_3_2_10 KC_NO


#define KR_3_3_1 KC_NO
#define KR_3_3_2 KC_NO
#define KR_3_3_3 KC_NO
#define KR_3_3_4 KC_NO
#define KR_3_3_5 KC_NO
//
#define KR_3_3_6 KC_NO
#define KR_3_3_7 KC_NO
#define KR_3_3_8 KC_NO
#define KR_3_3_9 KC_NO
#define KR_3_3_10 KC_NO

#define KR_3_4_1 KC_TRNS
#define KR_3_4_2 TO(0)
#define KR_3_4_3 KC_TRNS

#define KR_3_4_4 KC_TRNS
#define KR_3_4_5 TO(1)
#define KR_3_4_6 KC_TRNS