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
	COMBO_LENGTH
};

uint16_t COMBO_LEN = COMBO_LENGTH;

const uint16_t PROGMEM combo0[] = { KC_Q, KC_W, COMBO_END};
const uint16_t PROGMEM combo1[] = { KC_X, KC_C, COMBO_END};
const uint16_t PROGMEM combo2[] = { KC_Z, KC_X, COMBO_END};
const uint16_t PROGMEM combo3[] = { KC_COMMA, KC_DOT, COMBO_END};


combo_t key_combos[] = {
	[CBO_0] = COMBO(combo0, KC_ESCAPE),
	[CBO_1] = COMBO(combo1, KC_TAB),
	[CBO_2] = COMBO(combo2, KC_GRAVE),
	[CBO_3] = COMBO(combo3, KC_ENTER),
};

/* TAPDANCES */

enum tap_dance_codes {
  DANCE_0,
  DANCE_1,
  DANCE_2,
  DANCE_3,
  DANCE_4,
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

#define KR_0_2_1 LSFT_T(KC_A)
#define KR_0_2_2 LCTL_T(KC_S)
#define KR_0_2_3 LALT_T(KC_D)
#define KR_0_2_4 MEH_T(KC_F)
#define KR_0_2_5 LGUI_T(KC_G)
//
#define KR_0_2_6 KC_H
#define KR_0_2_7 MEH_T(KC_J)
#define KR_0_2_8 RALT_T(KC_K)
#define KR_0_2_9 RCTL_T(KC_L)
#define KR_0_2_10 RSFT_T(KC_P)

// Bottom row

// #define KR_0_3_0 KC_NO
#define KR_0_3_1 KC_Z
#define KR_0_3_2 KC_X
#define KR_0_3_3 KC_C
#define KR_0_3_4 LT(3, KC_V)
#define KR_0_3_5 KC_B

#define KR_0_3_6 KC_N
#define KR_0_3_7 KC_M
#define KR_0_3_8 KC_COMM
#define KR_0_3_9 KC_DOT
#define KR_0_3_10 KC_SLASH

// Thumb cluster

#define KR_0_4_1 KC_NO
#define KR_0_4_2 OSM(MOD_LSFT)
#define KR_0_4_3 KC_SPACE

#define KR_0_4_4 TT(1)
#define KR_0_4_5 OSM(MOD_LGUI)
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

#define KR_1_2_1 TO(3)
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
#define KR_2_2_2 LCTL_T(KC_DOT)
#define KR_2_2_3 LALT_T(KC_COMM)
#define KR_2_2_4 MEH_T(KC_MINUS)
#define KR_2_2_5 KC_PEQL
//
#define KR_2_2_6 KC_COLN
#define KR_2_2_7 MEH_T(KC_4)
#define KR_2_2_8 MT(MOD_RALT, KC_5)
#define KR_2_2_9 MT(MOD_RCTL, KC_6)
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

#define KR_2_4_4 KC_TRNS
#define KR_2_4_5 KC_TRNS
#define KR_2_4_6 KC_TRNS

// ############################################
// ##### Layer 3 EXTENDED
// ############################################

// Top row

#define KR_3_1_1 KC_ESC
#define KR_3_1_2 LGUI(KC_W)
#define KR_3_1_3 LGUI(LSFT(KC_5)) // Screenshot with Cleanshot
#define KR_3_1_4 KC_DELETE
#define KR_3_1_5 KC_BSPC
//
#define KR_3_1_6 KC_PAGE_UP
#define KR_3_1_7 LGUI(KC_LBRC)
#define KR_3_1_8 KC_UP
#define KR_3_1_9 LGUI(KC_RBRC)
#define KR_3_1_10 KC_DELETE

#define KR_3_2_1 TD(DANCE_1)
#define KR_3_2_2 TD(DANCE_2)
#define KR_3_2_3 TD(DANCE_3)
#define KR_3_2_4 TD(DANCE_4)
#define KR_3_2_5 KC_ENTER
//
#define KR_3_2_6 KC_PAGE_DOWN
#define KR_3_2_7 KC_LEFT
#define KR_3_2_8 KC_DOWN
#define KR_3_2_9 KC_RIGHT
#define KR_3_2_10 KC_ENTER

#define KR_3_3_1 LGUI(KC_Z)
#define KR_3_3_2 LGUI(KC_X)
#define KR_3_3_3 LGUI(KC_C)
#define KR_3_3_4 LGUI(KC_V)
#define KR_3_3_5 KC_SPACE

#define KR_3_3_6 KC_TRNS
#define KR_3_3_7 S(A(KC_LEFT))
#define KR_3_3_8 KC_TAB
#define KR_3_3_9 S(A(KC_RIGHT))
#define KR_3_3_10 KC_TRNS

// Thumb cluser

#define KR_3_4_1 KC_TRNS
#define KR_3_4_2 KC_TRNS
#define KR_3_4_3 TO(0)

#define KR_3_4_4 TO(4)
#define KR_3_4_5 KC_TRNS
#define KR_3_4_6 KC_TRNS

// ############################################
// ##### Layer 4 Mouse
// ############################################

// Top row

#define KR_4_1_1 KC_ESC
#define KR_4_1_2 LGUI(KC_W)
#define KR_4_1_3 LGUI(LSFT(KC_5)) // Screenshot with Cleanshot
#define KR_4_1_4 KC_TRNS
#define KR_4_1_5 KC_BSPC
//
#define KR_4_1_6 KC_MS_WH_DOWN
#define KR_4_1_7 KC_MS_WH_RIGHT
#define KR_4_1_8 KC_MS_UP
#define KR_4_1_9 KC_MS_WH_LEFT
#define KR_4_1_10 KC_TRNS


#define KR_4_2_1 TD(DANCE_1)
#define KR_4_2_2 TD(DANCE_2)
#define KR_4_2_3 TD(DANCE_3)
#define KR_4_2_4 KC_BTN1
#define KR_4_2_5 KC_BTN2
//
#define KR_4_2_6 KC_MS_WH_UP
#define KR_4_2_7 KC_MS_LEFT
#define KR_4_2_8 KC_MS_DOWN
#define KR_4_2_9 KC_MS_RIGHT
#define KR_4_2_10 KC_ENTER


#define KR_4_3_1 LGUI(KC_Z)
#define KR_4_3_2 LGUI(KC_X)
#define KR_4_3_3 LGUI(KC_C)
#define KR_4_3_4 LGUI(KC_V)
#define KR_4_3_5 KC_SPACE

#define KR_4_3_6 KC_TRNS
#define KR_4_3_7 KC_TRNS
#define KR_4_3_8 KC_TAB
#define KR_4_3_9 KC_TRNS
#define KR_4_3_10 KC_TRNS

// Thumb cluser

#define KR_4_4_1 KC_TRNS
#define KR_4_4_2 KC_TRNS
#define KR_4_4_3 TO(0)

#define KR_4_4_4 TO(3)
#define KR_4_4_5 KC_TRNS
#define KR_4_4_6 KC_TRNS

// ############################################
// TAP DANCE
// ############################################

typedef struct {
	bool is_press_action;
	uint8_t step;
} tap;

enum {
	SINGLE_TAP = 1,
	SINGLE_HOLD,
	DOUBLE_TAP,
	DOUBLE_HOLD,
	DOUBLE_SINGLE_TAP,
	MORE_TAPS
};

static tap dance_state[5];

uint8_t dance_step(tap_dance_state_t *state);

uint8_t dance_step(tap_dance_state_t *state) {
	if (state->count == 1) {
		if (state->interrupted || !state->pressed) return SINGLE_TAP;
		else return SINGLE_HOLD;
	} else if (state->count == 2) {
		if (state->interrupted) return DOUBLE_SINGLE_TAP;
		else if (state->pressed) return DOUBLE_HOLD;
		else return DOUBLE_TAP;
	}
	return MORE_TAPS;
}


void dance_0_finished(tap_dance_state_t *state, void *user_data);
void dance_0_reset(tap_dance_state_t *state, void *user_data);

void dance_0_finished(tap_dance_state_t *state, void *user_data) {
	dance_state[0].step = dance_step(state);
	switch (dance_state[0].step) {
		case SINGLE_TAP: layer_move(2); break;
		case SINGLE_HOLD: layer_on(1); break;
		case DOUBLE_TAP: layer_move(2); break;
		case DOUBLE_SINGLE_TAP: layer_move(2); break;
	}
}

void dance_0_reset(tap_dance_state_t *state, void *user_data) {
	wait_ms(10);
	switch (dance_state[0].step) {
		case SINGLE_HOLD: layer_off(1); break;
	}
	dance_state[0].step = 0;
}
void on_dance_1(tap_dance_state_t *state, void *user_data);
void dance_1_finished(tap_dance_state_t *state, void *user_data);
void dance_1_reset(tap_dance_state_t *state, void *user_data);

void on_dance_1(tap_dance_state_t *state, void *user_data) {
	if(state->count == 3) {
		tap_code16(LGUI(KC_A));
		tap_code16(LGUI(KC_A));
		tap_code16(LGUI(KC_A));
	}
	if(state->count > 3) {
		tap_code16(LGUI(KC_A));
	}
}

void dance_1_finished(tap_dance_state_t *state, void *user_data) {
	dance_state[1].step = dance_step(state);
	switch (dance_state[1].step) {
		case SINGLE_TAP: register_code16(LGUI(KC_A)); break;
		case SINGLE_HOLD: register_code16(KC_LSFT); break;
		case DOUBLE_TAP: register_code16(LGUI(KC_A)); register_code16(LGUI(KC_A)); break;
		case DOUBLE_SINGLE_TAP: tap_code16(LGUI(KC_A)); register_code16(LGUI(KC_A));
	}
}

void dance_1_reset(tap_dance_state_t *state, void *user_data) {
	wait_ms(10);
	switch (dance_state[1].step) {
		case SINGLE_TAP: unregister_code16(LGUI(KC_A)); break;
		case SINGLE_HOLD: unregister_code16(KC_LSFT); break;
		case DOUBLE_TAP: unregister_code16(LGUI(KC_A)); break;
		case DOUBLE_SINGLE_TAP: unregister_code16(LGUI(KC_A)); break;
	}
	dance_state[1].step = 0;
}
void on_dance_2(tap_dance_state_t *state, void *user_data);
void dance_2_finished(tap_dance_state_t *state, void *user_data);
void dance_2_reset(tap_dance_state_t *state, void *user_data);

void on_dance_2(tap_dance_state_t *state, void *user_data) {
	if(state->count == 3) {
		tap_code16(LGUI(KC_S));
		tap_code16(LGUI(KC_S));
		tap_code16(LGUI(KC_S));
	}
	if(state->count > 3) {
		tap_code16(LGUI(KC_S));
	}
}

void dance_2_finished(tap_dance_state_t *state, void *user_data) {
	dance_state[2].step = dance_step(state);
	switch (dance_state[2].step) {
		case SINGLE_TAP: register_code16(LGUI(KC_S)); break;
		case SINGLE_HOLD: register_code16(KC_LCTL); break;
		case DOUBLE_TAP: register_code16(LGUI(KC_S)); register_code16(LGUI(KC_S)); break;
		case DOUBLE_SINGLE_TAP: tap_code16(LGUI(KC_S)); register_code16(LGUI(KC_S));
	}
}

void dance_2_reset(tap_dance_state_t *state, void *user_data) {
	wait_ms(10);
	switch (dance_state[2].step) {
		case SINGLE_TAP: unregister_code16(LGUI(KC_S)); break;
		case SINGLE_HOLD: unregister_code16(KC_LCTL); break;
		case DOUBLE_TAP: unregister_code16(LGUI(KC_S)); break;
		case DOUBLE_SINGLE_TAP: unregister_code16(LGUI(KC_S)); break;
	}
	dance_state[2].step = 0;
}
void on_dance_3(tap_dance_state_t *state, void *user_data);
void dance_3_finished(tap_dance_state_t *state, void *user_data);
void dance_3_reset(tap_dance_state_t *state, void *user_data);

void on_dance_3(tap_dance_state_t *state, void *user_data) {
	if(state->count == 3) {
		tap_code16(LGUI(KC_D));
		tap_code16(LGUI(KC_D));
		tap_code16(LGUI(KC_D));
	}
	if(state->count > 3) {
		tap_code16(LGUI(KC_D));
	}
}

void dance_3_finished(tap_dance_state_t *state, void *user_data) {
	dance_state[3].step = dance_step(state);
	switch (dance_state[3].step) {
		case SINGLE_TAP: register_code16(LGUI(KC_D)); break;
		case SINGLE_HOLD: register_code16(KC_LALT); break;
		case DOUBLE_TAP: register_code16(LGUI(KC_D)); register_code16(LGUI(KC_D)); break;
		case DOUBLE_SINGLE_TAP: tap_code16(LGUI(KC_D)); register_code16(LGUI(KC_D));
	}
}

void dance_3_reset(tap_dance_state_t *state, void *user_data) {
	wait_ms(10);
	switch (dance_state[3].step) {
		case SINGLE_TAP: unregister_code16(LGUI(KC_D)); break;
		case SINGLE_HOLD: unregister_code16(KC_LALT); break;
		case DOUBLE_TAP: unregister_code16(LGUI(KC_D)); break;
		case DOUBLE_SINGLE_TAP: unregister_code16(LGUI(KC_D)); break;
	}
	dance_state[3].step = 0;
}
void on_dance_4(tap_dance_state_t *state, void *user_data);
void dance_4_finished(tap_dance_state_t *state, void *user_data);
void dance_4_reset(tap_dance_state_t *state, void *user_data);

void on_dance_4(tap_dance_state_t *state, void *user_data) {
	if(state->count == 3) {
		tap_code16(LGUI(KC_F));
		tap_code16(LGUI(KC_F));
		tap_code16(LGUI(KC_F));
	}
	if(state->count > 3) {
		tap_code16(LGUI(KC_F));
	}
}

void dance_4_finished(tap_dance_state_t *state, void *user_data) {
	dance_state[4].step = dance_step(state);
	switch (dance_state[4].step) {
		case SINGLE_TAP: register_code16(LGUI(KC_F)); break;
		case SINGLE_HOLD: register_code16(KC_LGUI); break;
		case DOUBLE_TAP: register_code16(LGUI(KC_F)); register_code16(LGUI(KC_F)); break;
		case DOUBLE_SINGLE_TAP: tap_code16(LGUI(KC_F)); register_code16(LGUI(KC_F));
	}
}

void dance_4_reset(tap_dance_state_t *state, void *user_data) {
	wait_ms(10);
	switch (dance_state[4].step) {
		case SINGLE_TAP: unregister_code16(LGUI(KC_F)); break;
		case SINGLE_HOLD: unregister_code16(KC_LGUI); break;
		case DOUBLE_TAP: unregister_code16(LGUI(KC_F)); break;
		case DOUBLE_SINGLE_TAP: unregister_code16(LGUI(KC_F)); break;
	}
	dance_state[4].step = 0;
}

tap_dance_action_t tap_dance_actions[] = {
		[DANCE_0] = ACTION_TAP_DANCE_FN_ADVANCED(NULL, dance_0_finished, dance_0_reset),
		[DANCE_1] = ACTION_TAP_DANCE_FN_ADVANCED(on_dance_1, dance_1_finished, dance_1_reset),
		[DANCE_2] = ACTION_TAP_DANCE_FN_ADVANCED(on_dance_2, dance_2_finished, dance_2_reset),
		[DANCE_3] = ACTION_TAP_DANCE_FN_ADVANCED(on_dance_3, dance_3_finished, dance_3_reset),
		[DANCE_4] = ACTION_TAP_DANCE_FN_ADVANCED(on_dance_4, dance_4_finished, dance_4_reset),
};
