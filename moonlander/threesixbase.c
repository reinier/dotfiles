/*

# Everything for a 34-key keyboard

*/

enum combos {
	QW_CBO,
	ZX_CBO,
	XC_CBO,
	VB_CBO,
	COMBO_LENGTH
};

uint16_t COMBO_LEN = COMBO_LENGTH;

const uint16_t PROGMEM qw_combo[]   = {KC_Q, KC_W, COMBO_END};
const uint16_t PROGMEM zx_combo[]   = {KC_Z, KC_X, COMBO_END};
const uint16_t PROGMEM xc_combo[]   = {KC_X, KC_C, COMBO_END};
const uint16_t PROGMEM vb_combo[]   = {KC_V, KC_B, COMBO_END};

combo_t key_combos[] = {
	[QW_CBO] = COMBO(qw_combo, KC_ESC),
	[ZX_CBO] = COMBO(zx_combo, KC_BSPC),
	[XC_CBO] = COMBO(xc_combo, OSM(MOD_LGUI)),
	[VB_CBO] = COMBO(vb_combo, KC_SPACE),

};

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

#define KR_0_4_1 OSM(MOD_LSFT)
#define KR_0_4_2 MEH_T(KC_SPACE)
#define KR_0_4_3 LT(3, KC_ENTER)

#define KR_0_4_4 TT(2)
#define KR_0_4_5 TT(1)
#define KR_0_4_6 OSM(MOD_LGUI)


// ###### Layer 1 Symbols

#define KR_1_1_1 KC_ESC
#define KR_1_1_2 KC_TILD
#define KR_1_1_3 LSFT(KC_QUOT)
#define KR_1_1_4 KC_PPLS
#define KR_1_1_5 KC_ASTR

#define KR_1_1_6 LSFT(KC_6) // ^
#define KR_1_1_7 KC_AT // @
#define KR_1_1_8 KC_EXLM
#define KR_1_1_9 KC_HASH
#define KR_1_1_10 KC_BSPC

// Mid row

#define KR_1_2_1 KC_TAB
#define KR_1_2_2 (KC_GRV)
#define KR_1_2_3 LCTL_T(KC_QUOT)
#define KR_1_2_4 LALT_T(KC_MINUS)
#define KR_1_2_5 KC_PEQL
//
#define KR_1_2_6 LSFT(KC_SCLN) // :
#define KR_1_2_7 KC_LPRN
#define KR_1_2_8 KC_RPRN
#define KR_1_2_9 KC_SCLN
#define KR_1_2_10 KC_NO

// Lower row

#define KR_1_3_1 KC_CAPS
#define KR_1_3_2 KC_AMPR
#define KR_1_3_3 LSFT(KC_MINUS) // _
#define KR_1_3_4 KC_PERC
#define KR_1_3_5 KC_SPACE
//
#define KR_1_3_6 LSFT(KC_BSLASH) // |
#define KR_1_3_7 KC_LBRC
#define KR_1_3_8 KC_RBRC
#define KR_1_3_9 LOPT(KC_SCLN) // …
#define KR_1_3_10 KC_BSLASH

// Thumb cluser

#define KR_1_4_1 KC_TRNS
#define KR_1_4_2 TO(0)
#define KR_1_4_3 KC_TRNS

#define KR_1_4_4 KC_NO
#define KR_1_4_5 KC_NO
#define KR_1_4_6 KC_TRNS

// ##### Layer 2 Numbers

#define KR_2_1_1 KC_ESC
#define KR_2_1_2 LSFT(KC_4) // $
#define KR_2_1_3 LALT(KC_2) // €
#define KR_2_1_4 KC_PPLS
#define KR_2_1_5 KC_ASTR
//
#define KR_2_1_6 KC_NO
#define KR_2_1_7 KC_7
#define KR_2_1_8 KC_8
#define KR_2_1_9 KC_9
#define KR_2_1_10 KC_BSPC


#define KR_2_2_1 KC_TAB
#define KR_2_2_2 KC_DOT
#define KR_2_2_3 LCTL_T(KC_COMM)
#define KR_2_2_4 LALT_T(KC_MINUS)
#define KR_2_2_5 KC_PEQL
//
#define KR_2_2_6 KC_COLN
#define KR_2_2_7 RALT_T(KC_4)
#define KR_2_2_8 RCTL_T(KC_5)
#define KR_2_2_9 KC_6
#define KR_2_2_10 KC_NO


#define KR_2_3_1 KC_CAPS
#define KR_2_3_2 KC_NO
#define KR_2_3_3 LSFT(KC_MINUS) // _
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
#define KR_2_4_2 TO(0)
#define KR_2_4_3 KC_TRNS

#define KR_2_4_4 KC_NO
#define KR_2_4_5 KC_NO
#define KR_2_4_6 KC_TRNS

// ##### Layer 3 NAV

#define KR_3_1_1 KC_ESC
#define KR_3_1_2 KC_NO
#define KR_3_1_3 KC_NO
#define KR_3_1_4 KC_NO
#define KR_3_1_5 KC_NO
//
#define KR_3_1_6 KC_PGUP
#define KR_3_1_7 LGUI(KC_LBRC)
#define KR_3_1_8 KC_UP
#define KR_3_1_9 LGUI(KC_RBRC)
#define KR_3_1_10 KC_BSPC


#define KR_3_2_1 KC_TAB
#define KR_3_2_2 KC_NO
#define KR_3_2_3 KC_LCTL
#define KR_3_2_4 KC_LALT
#define KR_3_2_5 KC_NO
//
#define KR_3_2_6 KC_PGDOWN
#define KR_3_2_7 KC_LEFT
#define KR_3_2_8 KC_DOWN
#define KR_3_2_9 KC_RIGHT
#define KR_3_2_10 KC_NO


#define KR_3_3_1 KC_CAPS
#define KR_3_3_2 KC_NO
#define KR_3_3_3 KC_NO
#define KR_3_3_4 KC_NO
#define KR_3_3_5 KC_SPACE

#define KR_3_3_6 KC_NO
#define KR_3_3_7 LSFT(KC_LEFT)
#define KR_3_3_8 KC_TAB
#define KR_3_3_9 LSFT(KC_RIGHT)
#define KR_3_3_10 KC_NO

// Thumb cluser

#define KR_3_4_1 KC_TRNS
#define KR_3_4_2 TO(0)
#define KR_3_4_3 KC_TRNS

#define KR_3_4_4 TO(4)
#define KR_3_4_5 KC_NO
#define KR_3_4_6 KC_TRNS

// ##### Layer 4 Mouse

#define KR_4_1_1 KC_ESC
#define KR_4_1_2 KC_MS_ACCEL1
#define KR_4_1_3 KC_MS_ACCEL2
#define KR_4_1_4 LSG(KC_4) // Screenshot button `cmd shift 4`
#define KR_4_1_5 KC_NO
//
#define KR_4_1_6 KC_MS_WH_DOWN
#define KR_4_1_7 KC_MS_WH_RIGHT
#define KR_4_1_8 KC_MS_UP
#define KR_4_1_9 KC_MS_WH_LEFT
#define KR_4_1_10 KC_BSPC


#define KR_4_2_1 KC_TAB
#define KR_4_2_2 KC_NO
#define KR_4_2_3 KC_MS_ACCEL0
#define KR_4_2_4 KC_MS_BTN1
#define KR_4_2_5 KC_MS_BTN2
//
#define KR_4_2_6 KC_MS_WH_UP
#define KR_4_2_7 KC_MS_LEFT
#define KR_4_2_8 KC_MS_DOWN
#define KR_4_2_9 KC_MS_RIGHT
#define KR_4_2_10 KC_NO


#define KR_4_3_1 KC_CAPS
#define KR_4_3_2 KC_NO
#define KR_4_3_3 KC_LCTRL
#define KR_4_3_4 KC_LALT
#define KR_4_3_5 KC_SPACE

#define KR_4_3_6 KC_NO
#define KR_4_3_7 KC_NO
#define KR_4_3_8 KC_NO
#define KR_4_3_9 KC_NO
#define KR_4_3_10 KC_NO

// Thumb cluser

#define KR_4_4_1 KC_TRNS
#define KR_4_4_2 TO(0)
#define KR_4_4_3 KC_ENTER

#define KR_4_4_4 TO(3)
#define KR_4_4_5 KC_NO
#define KR_4_4_6 KC_TRNS


// DUMMIES

#define KR_0_1_0  KC_NO
#define KR_0_1_11 KC_NO
#define KR_0_2_0  KC_NO
#define KR_0_2_11 KC_NO
#define KR_0_3_0  KC_NO
#define KR_0_3_11 KC_NO

#define KR_1_1_0  KC_NO
#define KR_1_1_11 KC_NO
#define KR_1_2_0  KC_NO
#define KR_1_2_11 KC_NO
#define KR_1_3_0  KC_NO
#define KR_1_3_11 KC_NO

#define KR_2_1_0  KC_NO
#define KR_2_1_11 KC_NO
#define KR_2_2_0  KC_NO
#define KR_2_2_11 KC_NO
#define KR_2_3_0  KC_NO
#define KR_2_3_11 KC_NO

#define KR_3_1_0  KC_NO
#define KR_3_1_11 KC_NO
#define KR_3_2_0  KC_NO
#define KR_3_2_11 KC_NO
#define KR_3_3_0  KC_NO
#define KR_3_3_11 KC_NO

#define KR_4_1_0  KC_NO
#define KR_4_1_11 KC_NO
#define KR_4_2_0  KC_NO
#define KR_4_2_11 KC_NO
#define KR_4_3_0  KC_NO
#define KR_4_3_11 KC_NO