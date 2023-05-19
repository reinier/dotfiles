/*

# WORK IN PROGRESS

Eighteen key keyboard, with base as sixteen

*/

// # Layer 0

// Top row

#define KR_0_1_1 KC_NO
#define KR_0_1_2 KC_L
#define KR_0_1_3 KC_G
#define KR_0_1_4 KC_D
#define KR_0_1_5 KC_NO
//
#define KR_0_1_6 KC_NO
#define KR_0_1_7 KC_H
#define KR_0_1_8 KC_U
#define KR_0_1_9 KC_O
#define KR_0_1_10 KC_NO

// Mid row

#define KR_0_2_1 KC_NO
#define KR_0_2_2 KC_S
#define KR_0_2_3 KC_R
#define KR_0_2_4 KC_T
#define KR_0_2_5 KC_NO
//
#define KR_0_2_6 KC_NO
#define KR_0_2_7 KC_N
#define KR_0_2_8 KC_E
#define KR_0_2_9 KC_A
#define KR_0_2_10 KC_NO

// Bottom row

#define KR_0_3_1 KC_I
#define KR_0_3_2 KC_NO
#define KR_0_3_3 KC_NO
#define KR_0_3_4 KC_NO
#define KR_0_3_5 KC_SPACE

#define KR_0_3_6 OSL(1)
#define KR_0_3_7 KC_NO
#define KR_0_3_8 KC_NO
#define KR_0_3_9 KC_NO
#define KR_0_3_10 KC_C

// Thumb cluster

#define KR_0_4_1 KC_NO
#define KR_0_4_2 KC_NO
#define KR_0_4_3 KC_NO

#define KR_0_4_4 KC_NO
#define KR_0_4_5 KC_NO
#define KR_0_4_6 KC_NO

// ############################################
// ###### Layer 1 ALPHA 2
// ############################################

// Top row

#define KR_1_1_1 KC_NO
#define KR_1_1_2 KC_V
#define KR_1_1_3 KC_W
#define KR_1_1_4 KC_M
#define KR_1_1_5 KC_NO

#define KR_1_1_6 KC_NO
#define KR_1_1_7 KC_F
#define KR_1_1_8 KC_QUOT
#define KR_1_1_9 KC_Z
#define KR_1_1_10 KC_NO

// Mid row

#define KR_1_2_1 KC_NO
#define KR_1_2_2 KC_J
#define KR_1_2_3 KC_P
#define KR_1_2_4 KC_K
#define KR_1_2_5 KC_NO
//
#define KR_1_2_6 KC_NO
#define KR_1_2_7 KC_B
#define KR_1_2_8 KC_DOT
#define KR_1_2_9 KC_X
#define KR_1_2_10 KC_NO

// Lower row

#define KR_1_3_1 KC_Q
#define KR_1_3_2 KC_NO
#define KR_1_3_3 KC_NO
#define KR_1_3_4 KC_NO
#define KR_1_3_5 OSM(MOD_LSFT)
//
#define KR_1_3_6 OSL(2)
#define KR_1_3_7 KC_NO
#define KR_1_3_8 KC_NO
#define KR_1_3_9 KC_NO
#define KR_1_3_10 KC_Y

// Thumb cluser

#define KR_1_4_1 KC_NO
#define KR_1_4_2 KC_NO
#define KR_1_4_3 KC_NO

#define KR_1_4_4 KC_NO
#define KR_1_4_5 KC_NO
#define KR_1_4_6 KC_NO

// ############################################
// ##### Layer 2 Alpha 2 Caps
// ############################################

// Top row

#define KR_2_1_1 KC_NO
#define KR_2_1_2 S(KC_V)
#define KR_2_1_3 S(KC_W)
#define KR_2_1_4 S(KC_M)
#define KR_2_1_5 KC_NO
//
#define KR_2_1_6 KC_NO
#define KR_2_1_7 S(KC_F)
#define KR_2_1_8 KC_NO
#define KR_2_1_9 S(KC_Z)
#define KR_2_1_10 KC_NO


#define KR_2_2_1 KC_NO
#define KR_2_2_2 S(KC_J)
#define KR_2_2_3 S(KC_P)
#define KR_2_2_4 S(KC_K)
#define KR_2_2_5 KC_NO
//
#define KR_2_2_6 KC_NO
#define KR_2_2_7 S(KC_B)
#define KR_2_2_8 KC_COMMA
#define KR_2_2_9 S(KC_X)
#define KR_2_2_10 KC_NO


#define KR_2_3_1 S(KC_Q)
#define KR_2_3_2 KC_NO
#define KR_2_3_3 KC_NO
#define KR_2_3_4 KC_NO
#define KR_2_3_5 TO(0)
//
#define KR_2_3_6 KC_NO
#define KR_2_3_7 KC_NO
#define KR_2_3_8 KC_NO
#define KR_2_3_9 KC_NO
#define KR_2_3_10 S(KC_Y)

// Thumb cluster

#define KR_2_4_1 KC_NO
#define KR_2_4_2 KC_NO
#define KR_2_4_3 KC_NO

#define KR_2_4_4 KC_NO
#define KR_2_4_5 KC_NO
#define KR_2_4_6 KC_NO

// ############################################
// ##### Layer 3 EXTENDED
// ############################################

// Top row

#define KR_3_1_1 KC_ESC
#define KR_3_1_2 KC_TRNS
#define KR_3_1_3 LGUI(LSFT(KC_5)) // Screenshot with Cleanshot
#define KR_3_1_4 KC_TRNS
#define KR_3_1_5 KC_TRNS
//
#define KR_3_1_6 KC_DELETE
#define KR_3_1_7 KC_TRNS
#define KR_3_1_8 KC_UP
#define KR_3_1_9 KC_TRNS
#define KR_3_1_10 KC_BSPC

// Mid row

#define KR_3_2_1 KC_TAB
#define KR_3_2_2 KC_TRNS
#define KR_3_2_3 KC_TRNS
#define KR_3_2_4 KC_TRNS
#define KR_3_2_5 KC_BSPC
//
#define KR_3_2_6 KC_BSPC
#define KR_3_2_7 KC_LEFT
#define KR_3_2_8 KC_DOWN
#define KR_3_2_9 KC_RIGHT
#define KR_3_2_10 KC_ENTER

// Bottom row

#define KR_3_3_1 KC_TRNS
#define KR_3_3_2 KC_TRNS
#define KR_3_3_3 KC_TRNS
#define KR_3_3_4 KC_ENTER
#define KR_3_3_5 KC_SPACE

#define KR_3_3_6 A(KC_BSPC)
#define KR_3_3_7 A(KC_LEFT)
#define KR_3_3_8 KC_TAB
#define KR_3_3_9 A(KC_RIGHT)
#define KR_3_3_10 KC_TRNS

// Thumb cluser

#define KR_3_4_1 KC_TRNS
#define KR_3_4_2 KC_TRNS
#define KR_3_4_3 TO(0)

#define KR_3_4_4 TO(2) // To number layer
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
