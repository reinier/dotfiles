/*

# Everything for the Totem keyboard with a focus on 16 keys to transition to slowly

*/

// # Layer 0

// Top row

#define KR_0_1_1 KC_Q
#define KR_0_1_2 LCTL_T(KC_W)
#define KR_0_1_3 LALT_T(KC_E)
#define KR_0_1_4 LSFT_T(KC_R)
#define KR_0_1_5 KC_T
//
#define KR_0_1_6 KC_Y
#define KR_0_1_7 RGUI_T(KC_U)
#define KR_0_1_8 RALT_T(KC_I)
#define KR_0_1_9 RCTL_T(KC_O)
#define KR_0_1_10 KC_NO

// Mid row

#define KR_0_2_1 KC_A
#define KR_0_2_2 LT(2,KC_S)
#define KR_0_2_3 LT(1,KC_D)
#define KR_0_2_4 LT(3,KC_F)
#define KR_0_2_5 LSFT_T(KC_G)
//
#define KR_0_2_6 KC_H
#define KR_0_2_7 LT(3,KC_J)
#define KR_0_2_8 LT(1,KC_K)
#define KR_0_2_9 LT(2,KC_L)
#define KR_0_2_10 KC_P

// Bottom row

#define KR_0_3_1 KC_Z
#define KR_0_3_2 KC_X
#define KR_0_3_3 KC_C
#define KR_0_3_4 KC_V
#define KR_0_3_5 KC_B

#define KR_0_3_6 KC_N
#define KR_0_3_7 KC_M
#define KR_0_3_8 KC_COMM
#define KR_0_3_9 KC_DOT
#define KR_0_3_10 KC_SLASH

// Thumb cluster

#define KR_0_4_1 KC_NO
#define KR_0_4_2 OSM(MOD_LGUI)
#define KR_0_4_3 MEH_T(KC_SPACE)

#define KR_0_4_4 TT(3)
#define KR_0_4_5 OSM(MOD_LSFT)
#define KR_0_4_6 KC_NO

// ############################################
// ###### Layer 1 Symbols
// ############################################

// Top row

#define KR_1_1_1 KC_NO
#define KR_1_1_2 KC_TILD
#define KR_1_1_3 KC_DQUO
#define KR_1_1_4 KC_PLUS
#define KR_1_1_5 KC_ASTR

#define KR_1_1_6 KC_CIRC
#define KR_1_1_7 KC_EXLM
#define KR_1_1_8 KC_AT
#define KR_1_1_9 KC_HASH
#define KR_1_1_10 KC_NO

// Mid row

#define KR_1_2_1 KC_NO
#define KR_1_2_2 KC_GRAVE
#define KR_1_2_3 KC_QUOT
#define KR_1_2_4 KC_MINUS
#define KR_1_2_5 KC_EQUAL
//
#define KR_1_2_6 KC_COLN
#define KR_1_2_7 KC_LPRN
#define KR_1_2_8 KC_LBRC
#define KR_1_2_9 KC_LCBR
#define KR_1_2_10 KC_SCLN

// Lower row

#define KR_1_3_1 KC_NO
#define KR_1_3_2 KC_AMPR
#define KR_1_3_3 KC_UNDS
#define KR_1_3_4 KC_PERC
#define KR_1_3_5 KC_PIPE
//
#define KR_1_3_6 LOPT(KC_SCLN) // …
#define KR_1_3_7 KC_RPRN
#define KR_1_3_8 KC_RBRC
#define KR_1_3_9 KC_RCBR
#define KR_1_3_10 KC_BSLS

// Thumb cluser

#define KR_1_4_1 KC_TRNS
#define KR_1_4_2 KC_TRNS
#define KR_1_4_3 KC_TRNS

#define KR_1_4_4 KC_TRNS
#define KR_1_4_5 KC_TRNS
#define KR_1_4_6 KC_TRNS

// ############################################
// ##### Layer 2 NUM
// ############################################

// Top row

#define KR_2_1_1 KC_NO
#define KR_2_1_2 KC_DLR
#define KR_2_1_3 LALT(KC_2) // €
#define KR_2_1_4 KC_PLUS
#define KR_2_1_5 KC_ASTR
//
#define KR_2_1_6 KC_TRNS
#define KR_2_1_7 KC_7
#define KR_2_1_8 KC_8
#define KR_2_1_9 KC_9
#define KR_2_1_10 KC_NO


#define KR_2_2_1 KC_NO
#define KR_2_2_2 KC_DOT
#define KR_2_2_3 KC_COMM
#define KR_2_2_4 KC_MINUS
#define KR_2_2_5 KC_PEQL
//
#define KR_2_2_6 KC_COLN
#define KR_2_2_7 KC_4
#define KR_2_2_8 KC_5
#define KR_2_2_9 KC_6
#define KR_2_2_10 KC_NO


#define KR_2_3_1 KC_TRNS
#define KR_2_3_2 KC_TRNS
#define KR_2_3_3 KC_UNDS
#define KR_2_3_4 KC_PERC
#define KR_2_3_5 KC_NO
//
#define KR_2_3_6 KC_0
#define KR_2_3_7 KC_1
#define KR_2_3_8 KC_2
#define KR_2_3_9 KC_3
#define KR_2_3_10 KC_TRNS

// Thumb cluser

#define KR_2_4_1 KC_TRNS
#define KR_2_4_2 KC_TRNS
#define KR_2_4_3 KC_TRNS

#define KR_2_4_4 KC_TRNS
#define KR_2_4_5 KC_TRNS
#define KR_2_4_6 KC_TRNS

// ############################################
// ##### Layer 3 EXTENDED
// ############################################

/* #define KR_3_1_3 G(S(KC_5)) // Screenshot with Cleanshot */

// Top row

#define KR_3_1_1 KC_TRNS
#define KR_3_1_2 LCTL_T(KC_ESC)
#define KR_3_1_3 LALT_T(KC_F18)
#define KR_3_1_4 LSFT_T(KC_F19)
#define KR_3_1_5 KC_TRNS
//
#define KR_3_1_6 KC_NO
#define KR_3_1_7 KC_CCCV
#define KR_3_1_8 KC_UP
#define KR_3_1_9 KC_BSPC
#define KR_3_1_10 KC_NO

// Mid row

#define KR_3_2_1 KC_TAB
#define KR_3_2_2 KC_DELETE
#define KR_3_2_3 LALT_T(KC_F20)
#define KR_3_2_4 KC_F21
#define KR_3_2_5 KC_TRNS
//
#define KR_3_2_6 KC_TRNS
#define KR_3_2_7 KC_LEFT
#define KR_3_2_8 KC_DOWN
#define KR_3_2_9 KC_RIGHT
#define KR_3_2_10 KC_ENTER

// Bottom row

#define KR_3_3_1 KC_TRNS
#define KR_3_3_2 KC_TRNS
#define KR_3_3_3 KC_TRNS
#define KR_3_3_4 KC_TRNS
#define KR_3_3_5 KC_TRNS

#define KR_3_3_6 KC_TRNS
#define KR_3_3_7 KC_TRNS
#define KR_3_3_8 KC_TRNS
#define KR_3_3_9 KC_TRNS
#define KR_3_3_10 KC_TRNS

// Thumb cluser

#define KR_3_4_1 KC_TRNS
#define KR_3_4_2 KC_TRNS
#define KR_3_4_3 TO(0)

#define KR_3_4_4 KC_TRNS
#define KR_3_4_5 KC_TRNS
#define KR_3_4_6 KC_TRNS









// ############################################
// ##### Layer 4 Mouse // DISCONTINUED
// ############################################

// Top row

#define KR_4_1_1 KC_TRNS
#define KR_4_1_2 KC_TRNS
#define KR_4_1_3 KC_TRNS
#define KR_4_1_4 KC_TRNS
#define KR_4_1_5 KC_TRNS
//
#define KR_4_1_6 KC_TRNS
#define KR_4_1_7 KC_TRNS
#define KR_4_1_8 KC_TRNS
#define KR_4_1_9 KC_TRNS
#define KR_4_1_10 KC_TRNS


#define KR_4_2_1 KC_TRNS
#define KR_4_2_2 KC_TRNS
#define KR_4_2_3 KC_TRNS
#define KR_4_2_4 KC_TRNS
#define KR_4_2_5 KC_TRNS
//
#define KR_4_2_6 KC_TRNS
#define KR_4_2_7 KC_TRNS
#define KR_4_2_8 KC_TRNS
#define KR_4_2_9 KC_TRNS
#define KR_4_2_10 KC_TRNS


#define KR_4_3_1 KC_TRNS
#define KR_4_3_2 KC_TRNS
#define KR_4_3_3 KC_TRNS
#define KR_4_3_4 KC_TRNS
#define KR_4_3_5 KC_TRNS

#define KR_4_3_6 KC_TRNS
#define KR_4_3_7 KC_TRNS
#define KR_4_3_8 KC_TRNS
#define KR_4_3_9 KC_TRNS
#define KR_4_3_10 KC_TRNS

// Thumb cluser

#define KR_4_4_1 KC_TRNS
#define KR_4_4_2 KC_TRNS
#define KR_4_4_3 KC_TRNS

#define KR_4_4_4 KC_TRNS
#define KR_4_4_5 KC_TRNS
#define KR_4_4_6 KC_TRNS
