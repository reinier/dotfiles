layer_state_t layer_state_set_user(layer_state_t state) {

	switch (get_highest_layer(state)) {
		case MAC_BASE:
			tap_code(KC_F21);
			break;
		case WIN_BASE:
			tap_code16(KC_F21);
			break;
		case _FN1:
			tap_code16(KC_F22);
			break;
		case _FN2:
			tap_code16(KC_F22);
			break;
		case _FN3:
			tap_code16(KC_F23);
			break;
	}
	return state;
}