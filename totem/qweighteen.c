/*

# Qweighteen, a keymap with full QWERTY layout but with a focus on the eighteen most comfortable keys on the other layers. 

Inspired by the sixteen/eighteen key keyboard of [Ben Vallack](https://www.youtube.com/@BenVallack)

@TODO re-order layers so symbols layers are 1 and 2 instead of 1 and 4
*/

/*

## COMBOS

*/

enum combos {
	CBO_0,
	CBO_1,
	COMBO_LENGTH
};

uint16_t COMBO_LEN = COMBO_LENGTH;

const uint16_t PROGMEM combo0[] = { KC_LEFT, KC_DOWN, COMBO_END};
const uint16_t PROGMEM combo1[] = { KC_CCCV, KC_UP, COMBO_END};

combo_t key_combos[] = {
	[CBO_0] = COMBO(combo0, KC_BTN1),
	[CBO_1] = COMBO(combo1, KC_BTN2),
};

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
#define KR_0_1_10 KC_BSPC

// Mid row

#define KR_0_2_1 LT(2,KC_A)
#define KR_0_2_2 LT(4,KC_S)
#define KR_0_2_3 LT(1,KC_D)
#define KR_0_2_4 LT(3,KC_F)
#define KR_0_2_5 LSFT_T(KC_G)
//
#define KR_0_2_6 KC_H
#define KR_0_2_7 LT(3,KC_J)
#define KR_0_2_8 LT(1,KC_K)
#define KR_0_2_9 LT(4,KC_L)
#define KR_0_2_10 LT(2,KC_P)

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

#define KR_0_4_1 KC_CCCV
#define KR_0_4_2 OSM(MOD_LGUI)
#define KR_0_4_3 MEH_T(KC_SPACE)

#define KR_0_4_4 OSM(MOD_LSFT)
#define KR_0_4_5 KC_F19
#define KR_0_4_6 CW_TOGG

// ############################################
// ###### Layer 1 Symbols I
// ############################################

// Top row

#define KR_1_1_1 KC_NO
#define KR_1_1_2 KC_NO
#define KR_1_1_3 A(KC_2) // €
#define KR_1_1_4 KC_NO
#define KR_1_1_5 KC_NO

#define KR_1_1_6 KC_NO
#define KR_1_1_7 KC_NO
#define KR_1_1_8 KC_CIRC
#define KR_1_1_9 S(KC_SLASH) // ?
#define KR_1_1_10 KC_NO

// Mid row

#define KR_1_2_1 KC_NO
#define KR_1_2_2 S(KC_F19)
#define KR_1_2_3 KC_GRAVE
#define KR_1_2_4 KC_DQUO
#define KR_1_2_5 KC_NO
//
#define KR_1_2_6 KC_NO
#define KR_1_2_7 KC_HASH
#define KR_1_2_8 KC_AT
#define KR_1_2_9 KC_EXLM
#define KR_1_2_10 A(KC_SCLN)

// Lower row 

#define KR_1_3_1 KC_NO
#define KR_1_3_2 KC_NO
#define KR_1_3_3 KC_NO
#define KR_1_3_4 KC_NO
#define KR_1_3_5 KC_NO
//
#define KR_1_3_6 KC_NO
#define KR_1_3_7 KC_NO
#define KR_1_3_8 KC_NO
#define KR_1_3_9 KC_NO
#define KR_1_3_10 KC_NO

// Thumb cluster

#define KR_1_4_1 KC_TRNS
#define KR_1_4_2 KC_TRNS
#define KR_1_4_3 KC_QUOT

#define KR_1_4_4 KC_TRNS
#define KR_1_4_5 LLOCK
#define KR_1_4_6 KC_TRNS

// ############################################
// ###### Layer 4 Symbols II
// ############################################

// Top row

#define KR_4_1_1 KC_NO
#define KR_4_1_2 KC_TILD
#define KR_4_1_3 KC_BSLS
#define KR_4_1_4 KC_PIPE
#define KR_4_1_5 KC_NO

#define KR_4_1_6 KC_NO
#define KR_4_1_7 KC_RPRN
#define KR_4_1_8 KC_RBRC
#define KR_4_1_9 KC_RCBR
#define KR_4_1_10 KC_NO

// Mid row

#define KR_4_2_1 KC_UNDS
#define KR_4_2_2 KC_DLR
#define KR_4_2_3 KC_SLASH
#define KR_4_2_4 KC_PERC
#define KR_4_2_5 KC_NO
//
#define KR_4_2_6 KC_NO
#define KR_4_2_7 KC_LPRN
#define KR_4_2_8 KC_LBRC
#define KR_4_2_9 KC_LCBR
#define KR_4_2_10 KC_SCLN

// Lower row

#define KR_4_3_1 KC_NO
#define KR_4_3_2 KC_NO
#define KR_4_3_3 KC_NO
#define KR_4_3_4 KC_NO
#define KR_4_3_5 KC_NO
//
#define KR_4_3_6 KC_NO
#define KR_4_3_7 KC_NO
#define KR_4_3_8 KC_NO
#define KR_4_3_9 KC_NO
#define KR_4_3_10 KC_NO

// Thumb cluster

#define KR_4_4_1 KC_TRNS
#define KR_4_4_2 KC_TRNS
#define KR_4_4_3 KC_AMPR

#define KR_4_4_4 KC_TRNS
#define KR_4_4_5 LLOCK
#define KR_4_4_6 KC_TRNS

// ############################################
// ##### Layer 2 NUM
// ############################################

// Top row


#define KR_2_1_1 KC_NO
#define KR_2_1_2 KC_PLUS
#define KR_2_1_3 KC_5
#define KR_2_1_4 KC_6
#define KR_2_1_5 KC_NO
//
#define KR_2_1_6 KC_NO
#define KR_2_1_7 KC_7
#define KR_2_1_8 KC_8
#define KR_2_1_9 KC_9
#define KR_2_1_10 KC_NO


#define KR_2_2_1 KC_ASTR
#define KR_2_2_2 KC_MINUS
#define KR_2_2_3 KC_0
#define KR_2_2_4 KC_1
#define KR_2_2_5 KC_NO
//
#define KR_2_2_6 KC_NO
#define KR_2_2_7 KC_2
#define KR_2_2_8 KC_3
#define KR_2_2_9 KC_4
#define KR_2_2_10 KC_PEQL


#define KR_2_3_1 KC_NO
#define KR_2_3_2 KC_NO
#define KR_2_3_3 KC_NO
#define KR_2_3_4 KC_NO
#define KR_2_3_5 KC_NO
//
#define KR_2_3_6 KC_NO
#define KR_2_3_7 KC_NO
#define KR_2_3_8 KC_NO
#define KR_2_3_9 KC_NO
#define KR_2_3_10 KC_NO

// Thumb cluster


#define KR_2_4_1 KC_TRNS
#define KR_2_4_2 KC_TRNS
#define KR_2_4_3 KC_COLN

#define KR_2_4_4 KC_TRNS
#define KR_2_4_5 LLOCK
#define KR_2_4_6 KC_TRNS

// ############################################
// ##### Layer 3 EXTENDED
// ############################################

// Top row

#define KR_3_1_1 KC_NO
#define KR_3_1_2 LCTL_T(KC_ESC)
#define KR_3_1_3 LALT_T(KC_PGUP) 
#define KR_3_1_4 LSFT_T(KC_F18) // Mapped to main screenshot action in Cleanshot
#define KR_3_1_5 KC_NO
//
#define KR_3_1_6 KC_NO
#define KR_3_1_7 KC_CCCV // copy on hold, paste on tap
#define KR_3_1_8 KC_UP
#define KR_3_1_9 KC_BSPC
#define KR_3_1_10 KC_NO

// Mid row

#define KR_3_2_1 KC_TAB
#define KR_3_2_2 KC_DELETE
#define KR_3_2_3 LALT_T(KC_PGDN)
#define KR_3_2_4 CW_TOGG
#define KR_3_2_5 KC_NO
//
#define KR_3_2_6 KC_NO
#define KR_3_2_7 KC_LEFT
#define KR_3_2_8 KC_DOWN
#define KR_3_2_9 KC_RIGHT
#define KR_3_2_10 KC_ENTER

// Bottom row

#define KR_3_3_1 KC_NO
#define KR_3_3_2 KC_NO
#define KR_3_3_3 KC_NO
#define KR_3_3_4 KC_NO
#define KR_3_3_5 KC_NO

#define KR_3_3_6 KC_NO
#define KR_3_3_7 KC_NO
#define KR_3_3_8 KC_NO
#define KR_3_3_9 KC_NO
#define KR_3_3_10 KC_NO

// Thumb cluster

#define KR_3_4_1 KC_TRNS
#define KR_3_4_2 KC_TRNS
#define KR_3_4_3 KC_SPACE

#define KR_3_4_4 KC_TRNS
#define KR_3_4_5 LLOCK
#define KR_3_4_6 KC_TRNS
