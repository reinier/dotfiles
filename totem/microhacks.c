enum custom_keycodes {
  LLOCK = SAFE_RANGE,
  KC_CCCV,
  // Other custom keys...
};

uint16_t copy_paste_timer;

// Initialize variable holding the binary
// representation of active modifiers.
uint8_t mod_state;

bool process_record_user(uint16_t keycode, keyrecord_t * record) {
	
	if (!process_layer_lock(keycode, record, LLOCK)) { return false; }
	
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
	}
	return true;
};