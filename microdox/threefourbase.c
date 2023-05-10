/*

# Everything for a 34-key keyboard

*/

/*

## COMBOS

*/

enum combos {
	CBO_0,
	CBO_1,
	CBO_2,
	CBO_3,
	CBO_4,
	COMBO_LENGTH
};

uint16_t COMBO_LEN = COMBO_LENGTH;

const uint16_t PROGMEM combo0[] = { KC_Q, KC_W, COMBO_END};
const uint16_t PROGMEM combo1[] = { KC_X, KC_C, COMBO_END};
const uint16_t PROGMEM combo2[] = { KC_Z, KC_X, COMBO_END};
const uint16_t PROGMEM combo3[] = { KC_COMMA, KC_DOT, COMBO_END};
const uint16_t PROGMEM combo4[] = { KC_C, KC_V, COMBO_END};

combo_t key_combos[] = {
	[CBO_0] = COMBO(combo0, KC_ESCAPE),
	[CBO_1] = COMBO(combo1, KC_TAB),
	[CBO_2] = COMBO(combo2, KC_GRAVE),
	[CBO_3] = COMBO(combo3, KC_ENTER),
	[CBO_4] = COMBO(combo4, KC_CCCV)
};

// # Layer 0

// Top row

#define KR_0_1_1 KC_Q
#define KR_0_1_2 KC_W
#define KR_0_1_3 LT(2, KC_E)
#define KR_0_1_4 LT(3, KC_R)
#define KR_0_1_5 KC_T
//
#define KR_0_1_6 KC_Y
#define KR_0_1_7 LT(3, KC_U)
#define KR_0_1_8 LT(2, KC_I)
#define KR_0_1_9 KC_O
#define KR_0_1_10 KC_BSPC

// Mid row

#define KR_0_2_1 KC_A
#define KR_0_2_2 LSFT_T(KC_S)
#define KR_0_2_3 LCTL_T(KC_D)
#define KR_0_2_4 LALT_T(KC_F)
#define KR_0_2_5 KC_G
//
#define KR_0_2_6 KC_H
#define KR_0_2_7 RALT_T(KC_J)
#define KR_0_2_8 RCTL_T(KC_K)
#define KR_0_2_9 RGUI_T(KC_L)
#define KR_0_2_10 KC_P

// Bottom row

// #define KR_0_3_0 KC_NO
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
#define KR_0_4_3 MT(MOD_MEH, KC_SPACE)

#define KR_0_4_4 TT(1)
#define KR_0_4_5 OSM(MOD_LSFT)
#define KR_0_4_6 KC_NO

// ############################################
// ###### Layer 1 Symbols
// ############################################

// Top row

#define KR_1_1_1 KC_TRNS
#define KR_1_1_2 KC_TILD
#define KR_1_1_3 KC_QUOT
#define KR_1_1_4 KC_PLUS
#define KR_1_1_5 KC_ASTR

#define KR_1_1_6 KC_CIRC
#define KR_1_1_7 KC_HASH
#define KR_1_1_8 KC_LCBR
#define KR_1_1_9 KC_RCBR
#define KR_1_1_10 KC_TRNS

// Mid row

#define KR_1_2_1 KC_TRNS
#define KR_1_2_2 KC_GRAVE
#define KR_1_2_3 KC_DQUO
#define KR_1_2_4 KC_MINUS
#define KR_1_2_5 KC_EQUAL
//
#define KR_1_2_6 KC_COLN
#define KR_1_2_7 KC_AT
#define KR_1_2_8 KC_LPRN
#define KR_1_2_9 KC_RPRN
#define KR_1_2_10 KC_SCLN

// Lower row

#define KR_1_3_1 KC_TRNS
#define KR_1_3_2 KC_AMPR
#define KR_1_3_3 KC_UNDS
#define KR_1_3_4 KC_PERC
#define KR_1_3_5 KC_PIPE
//
#define KR_1_3_6 LOPT(KC_SCLN) // …
#define KR_1_3_7 KC_EXLM
#define KR_1_3_8 KC_LBRC
#define KR_1_3_9 KC_RBRC
#define KR_1_3_10 KC_BSLS

// Thumb cluser

#define KR_1_4_1 KC_TRNS
#define KR_1_4_2 KC_TRNS
#define KR_1_4_3 TO(0)

#define KR_1_4_4 TO(2)
#define KR_1_4_5 KC_TRNS
#define KR_1_4_6 KC_TRNS

// ############################################
// ##### Layer 2 NUM
// ############################################

// Top row

#define KR_2_1_1 KC_ESC
#define KR_2_1_2 KC_DLR
#define KR_2_1_3 LALT(KC_2) // €
#define KR_2_1_4 KC_PLUS
#define KR_2_1_5 KC_ASTR
//
#define KR_2_1_6 KC_TRNS
#define KR_2_1_7 KC_7
#define KR_2_1_8 KC_8
#define KR_2_1_9 KC_9
#define KR_2_1_10 KC_TRNS


#define KR_2_2_1 KC_TAB
#define KR_2_2_2 LSFT_T(KC_DOT)
#define KR_2_2_3 LCTL_T(KC_COMM)
#define KR_2_2_4 LALT_T(KC_MINUS)
#define KR_2_2_5 KC_PEQL
//
#define KR_2_2_6 KC_COLN
#define KR_2_2_7 RALT_T(KC_4)
#define KR_2_2_8 RCTL_T(KC_5)
#define KR_2_2_9 RGUI_T(KC_6)
#define KR_2_2_10 KC_ENTER


#define KR_2_3_1 KC_TRNS
#define KR_2_3_2 KC_TRNS
#define KR_2_3_3 KC_UNDS
#define KR_2_3_4 KC_PERC
#define KR_2_3_5 KC_SPACE
//
#define KR_2_3_6 KC_0
#define KR_2_3_7 KC_1
#define KR_2_3_8 KC_2
#define KR_2_3_9 KC_3
#define KR_2_3_10 KC_SLSH

// Thumb cluser

#define KR_2_4_1 KC_TRNS
#define KR_2_4_2 KC_TRNS
#define KR_2_4_3 TO(0)

#define KR_2_4_4 TO(3)
#define KR_2_4_5 KC_TRNS
#define KR_2_4_6 KC_TRNS

// ############################################
// ##### Layer 3 EXTENDED
// ############################################

// Top row

#define KR_3_1_1 KC_ESC
#define KR_3_1_2 KC_TRNS
#define KR_3_1_3 LGUI(LSFT(KC_5)) // Screenshot with Cleanshot
#define KR_3_1_4 KC_DELETE
#define KR_3_1_5 KC_BSPC
//
#define KR_3_1_6 KC_PAGE_UP
#define KR_3_1_7 LGUI(KC_LBRC)
#define KR_3_1_8 KC_UP
#define KR_3_1_9 LGUI(KC_RBRC)
#define KR_3_1_10 KC_TRNS

// Mid row

#define KR_3_2_1 KC_TRNS
#define KR_3_2_2 KC_TRNS
#define KR_3_2_3 KC_TRNS
#define KR_3_2_4 KC_TRNS
#define KR_3_2_5 KC_ENTER
//
#define KR_3_2_6 KC_PAGE_DOWN
#define KR_3_2_7 KC_LEFT
#define KR_3_2_8 KC_DOWN
#define KR_3_2_9 KC_RIGHT
#define KR_3_2_10 KC_ENTER

#define KR_3_3_1 KC_TRNS
#define KR_3_3_2 KC_TRNS
#define KR_3_3_3 KC_TRNS
#define KR_3_3_4 KC_TRNS
#define KR_3_3_5 KC_SPACE

#define KR_3_3_6 KC_TRNS
#define KR_3_3_7 A(KC_LEFT)
#define KR_3_3_8 KC_TAB
#define KR_3_3_9 A(KC_RIGHT)
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
