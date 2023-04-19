enum custom_keycodes {
  REPEAT = SAFE_RANGE,
  // Other custom keys...
};

/* Repeat key as described in: https://getreuer.info/posts/keyboards/repeat-key/ */
#include "features/repeat_key.h"

// Initialize variable holding the binary
// representation of active modifiers.
uint8_t mod_state;
bool process_record_user(uint16_t keycode, keyrecord_t * record) {
	
	if (!process_repeat_key(keycode, record, REPEAT)) { return false; }
	
	// Store the current modifier state in the variable for later reference
	mod_state = get_mods();
	switch (keycode) {
		
		case KC_BSPC:
		{
			// Initialize a boolean variable that keeps track
			// of the delete key status: registered or not?
			static bool delkey_registered;
			if (record->event.pressed) {
					// Detect the activation of either shift keys
					if (mod_state & MOD_MASK_SHIFT) {
							// First temporarily canceling both shifts so that
							// shift isn't applied to the KC_DEL keycode
							del_mods(MOD_MASK_SHIFT);
							register_code(KC_DEL);
							// Update the boolean variable to reflect the status of KC_DEL
							delkey_registered = true;
							// Reapplying modifier state so that the held shift key(s)
							// still work even after having tapped the Backspace/Delete key.
							set_mods(mod_state);
							return false;
					}
			} else { // on release of KC_BSPC
					// In case KC_DEL is still being sent even after the release of KC_BSPC
					if (delkey_registered) {
							unregister_code(KC_DEL);
							delkey_registered = false;
							return false;
					}
			}
			// Let QMK process the KC_BSPC keycode as usual outside of shift
			return true;
		}

	}
	
	
	
	return true;
};