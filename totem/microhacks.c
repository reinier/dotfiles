enum custom_keycodes {
  KC_CCCV= SAFE_RANGE,
  REPEAT,
  KC_LPRN_LR,
  KC_LCBR_LR,
  KC_DOT_ELIP,
  KC_COMM_AMP,
  KC_BSLS_PIPE,
  KC_ASTR_PERC,
  KC_DLR_EUR,
  KC_TILD_CIRC,
  // Other custom keys...
};

uint16_t copy_paste_timer;
uint16_t LPRN_LR_timer;
uint16_t LCBR_LR_timer;
uint16_t KC_DOT_ELIP_timer;
uint16_t KC_COMM_AMP_timer;
uint16_t KC_BSLS_PIPE_timer;
uint16_t KC_ASTR_PERC_timer;
uint16_t KC_DLR_EUR_timer;
uint16_t KC_TILD_CIRC_timer;

// Initialize variable holding the binary
// representation of active modifiers.
uint8_t mod_state;

bool process_record_user(uint16_t keycode, keyrecord_t * record) {
	
	if (!process_repeat_key(keycode, record, REPEAT)) { return false; }
	
	// Store the current modifier state in the variable for later reference
	mod_state = get_mods();
	switch (keycode) {
		case KC_CCCV:  // One key copy/paste
			if (record->event.pressed) {
				copy_paste_timer = timer_read();
			} else {
				if (timer_elapsed(copy_paste_timer) > TAPPING_TERM) {  // Hold, copy
					tap_code16(LGUI(KC_C));
				} else {  // Tap, paste
					tap_code16(LGUI(KC_V));
				}
			}
		return false;
		
		case KC_LPRN_LR:  // One key ()
			if (record->event.pressed) {
				LPRN_LR_timer = timer_read();
			} else {
				if (timer_elapsed(LPRN_LR_timer) > TAPPING_TERM) {  // Hold
					tap_code16(KC_RPRN);
				} else {  // Tap
					tap_code16(KC_LPRN);
				}
			}
		return false;
		
		case KC_LCBR_LR:  // One key ()
			if (record->event.pressed) {
				LCBR_LR_timer = timer_read();
			} else {
				if (timer_elapsed(LCBR_LR_timer) > TAPPING_TERM) {  // Hold
					tap_code16(KC_RCBR);
				} else {  // Tap
					tap_code16(KC_LCBR);
				}
			}
		return false;
		
		case KC_DOT_ELIP:  // One key dot and …
			if (record->event.pressed) {
				KC_DOT_ELIP_timer = timer_read();
			} else {
				if (timer_elapsed(KC_DOT_ELIP_timer) > TAPPING_TERM) {  // Hold
					tap_code16(A(KC_SCLN));
				} else {  // Tap
					tap_code16(KC_DOT);
				}
			}
		return false;
		
		case KC_COMM_AMP: // One key comma and ampersand
			if (record->event.pressed) {
					KC_COMM_AMP_timer = timer_read();
				} else {
					if (timer_elapsed(KC_COMM_AMP_timer) > TAPPING_TERM) {  // Hold
						tap_code16(KC_AMPR);
					} else {  // Tap
						tap_code16(KC_COMM);
					}
				}
		return false;
		
		case KC_BSLS_PIPE: // One key bsls and pipe
			if (record->event.pressed) {
					KC_BSLS_PIPE_timer = timer_read();
				} else {
					if (timer_elapsed(KC_BSLS_PIPE_timer) > TAPPING_TERM) {  // Hold
						tap_code16(KC_PIPE);
					} else {  // Tap
						tap_code16(KC_BSLS);
					}
				}
		return false;
		
		case KC_ASTR_PERC: // One key * and %
			if (record->event.pressed) {
					KC_ASTR_PERC_timer = timer_read();
				} else {
					if (timer_elapsed(KC_ASTR_PERC_timer) > TAPPING_TERM) {  // Hold
						tap_code16(KC_PERC);
					} else {  // Tap
						tap_code16(KC_ASTR);
					}
				}
		return false;
		
		case KC_DLR_EUR: // One key $ and €
			if (record->event.pressed) {
					KC_DLR_EUR_timer = timer_read();
				} else {
					if (timer_elapsed(KC_DLR_EUR_timer) > TAPPING_TERM) {  // Hold
						tap_code16(A(KC_2));
					} else {  // Tap
						tap_code16(KC_DLR);
					}
				}
		return false;
		
		case KC_TILD_CIRC: // One key ~ and ^
			if (record->event.pressed) {
					KC_TILD_CIRC_timer = timer_read();
				} else {
					if (timer_elapsed(KC_TILD_CIRC_timer) > TAPPING_TERM) {  // Hold
						tap_code16(KC_CIRC);
					} else {  // Tap
						tap_code16(KC_TILD);
					}
				}
		return false;
	}
	
	
	return true;
};