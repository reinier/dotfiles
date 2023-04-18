// Copyright 2022-2023 Google LLC
//
// Licensed under the Apache License, Version 2.0 (the "License");
// you may not use this file except in compliance with the License.
// You may obtain a copy of the License at
//
//     https://www.apache.org/licenses/LICENSE-2.0
//
// Unless required by applicable law or agreed to in writing, software
// distributed under the License is distributed on an "AS IS" BASIS,
// WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
// See the License for the specific language governing permissions and
// limitations under the License.

/**
 * @file repeat_key.c
 * @brief Repeat Key implementation
 */

#include "repeat_key.h"

// This library makes use of keyrecord_t's `.keycode` field. This field is only
// present when Combos are enabled, which we check here. Enable Combos in your
// rules.mk by setting:
//   COMBO_ENABLE = yes
#ifndef COMBO_ENABLE
#error "repeat_key: Please set `COMBO_ENABLE = yes` in rules.mk."
#else

// Variables saving the state of the last key press.
static keyrecord_t last_record = {0};
static uint8_t last_mods = 0;
// Signed count of the number of times the last key has been repeated or
// alternate repeated: it is 0 when a key is pressed normally, positive when
// repeated, and negative when alternate repeated.
static int8_t last_repeat_count = 0;

// The repeat_count, but set to 0 outside of repeat_key_invoke() so that it is
// nonzero only while a repeated key is being processed.
static int8_t processing_repeat_count = 0;

/** @brief Updates `last_repeat_count` in direction `dir`. */
static void update_last_repeat_count(int8_t dir) {
  if (dir * last_repeat_count < 0) {
	last_repeat_count = dir;
  } else if (dir * last_repeat_count < 127) {
	last_repeat_count += dir;
  }
}

static void set_repeat_key_record(uint16_t keycode, keyrecord_t* record) {
  last_record = *record;
  last_record.keycode = keycode;
  last_repeat_count = 0;
}

static void repeat_key_invoke(const keyevent_t* event) {
  // It is possible (e.g. in rolled presses) that the last key changes while the
  // Repeat Key is pressed. To prevent stuck keys, it is important to remember
  // separately what key record was processed on press so that the the
  // corresponding record is generated on release.
  static keyrecord_t registered_record = {0};
  static int8_t registered_repeat_count = 0;
  // Since this function calls process_record(), it may recursively call itself.
  // We return early if `processing_repeat_count` is nonzero to prevent infinite
  // recursion.
  if (processing_repeat_count || !last_record.keycode) {
	return;
  }

  if (event->pressed) {
	update_last_repeat_count(1);
	// On press, apply the last mods state, stacking on top of current mods.
	register_weak_mods(last_mods);
	registered_record = last_record;
	registered_repeat_count = last_repeat_count;
  }

  // Generate a keyrecord and plumb it into the event pipeline.
  registered_record.event = *event;
  processing_repeat_count = registered_repeat_count;
  process_record(&registered_record);
  processing_repeat_count = 0;

  // On release, restore the mods state.
  if (!event->pressed) {
	unregister_weak_mods(last_mods);
  }
}

/**
 * @brief Find alternate keycode from a table of opposing keycode pairs.
 * @param table Array of pairs of basic keycodes, declared as PROGMEM.
 * @param table_size_bytes The size of the table in bytes.
 * @param target The basic keycode to find.
 * @return The alternate basic keycode, or KC_NO if none was found.
 *
 * @note The table keycodes and target must be basic keycodes.
 *
 * This helper is used several times below to define alternate keys. Given a
 * table of pairs of basic keycodes, the function finds the pair containing
 * `target` and returns the other keycode in the pair.
 */
static uint8_t find_alt_keycode(const uint8_t (*table)[2],
								uint8_t table_size_bytes, uint8_t target) {
  const uint8_t* keycodes = (const uint8_t*)table;
  for (uint8_t i = 0; i < table_size_bytes; ++i) {
	if (target == pgm_read_byte(keycodes + i)) {
	  // Xor (i ^ 1) the index to get the other element in the pair.
	  return pgm_read_byte(keycodes + (i ^ 1));
	}
  }
  return KC_NO;
}

static void alt_repeat_key_invoke(const keyevent_t* event) {
  static keyrecord_t registered_record = {0};
  static int8_t registered_repeat_count = 0;
  // Since this function calls process_record(), it may recursively call itself.
  // We return early if `processing_repeat_count` is nonzero to prevent infinite
  // recursion.
  if (processing_repeat_count) {
	return;
  }

  if (event->pressed) {
	registered_record = (keyrecord_t){
#ifndef NO_ACTION_TAPPING
		.tap.interrupted = false,
		.tap.count = 0,
#endif
		.keycode = get_alt_repeat_key_keycode(),
	};
  }

  // Early return if there is no alternate key defined.
  if (!registered_record.keycode) {
	return;
  }

  if (event->pressed) {
	update_last_repeat_count(-1);
	registered_repeat_count = last_repeat_count;
  }

  // Generate a keyrecord and plumb it into the event pipeline.
  registered_record.event = *event;
  processing_repeat_count = registered_repeat_count;
  process_record(&registered_record);
  processing_repeat_count = 0;
}

__attribute__((weak)) bool get_repeat_key_eligible(uint16_t keycode,
												   keyrecord_t* record) {
  switch (keycode) {
	// Ignore MO, TO, TG, TT, and TL layer switch keys.
	case QK_MOMENTARY ... QK_MOMENTARY_MAX:
	case QK_TO ... QK_TO_MAX:
	case QK_TOGGLE_LAYER ... QK_TOGGLE_LAYER_MAX:
	case QK_LAYER_TAP_TOGGLE ... QK_LAYER_TAP_TOGGLE_MAX:
	  // Ignore mod keys.
	case KC_LCTL ... KC_RGUI:
	case KC_HYPR:
	case KC_MEH:
#ifndef NO_ACTION_ONESHOT  // Ignore one-shot keys.
	case QK_ONE_SHOT_LAYER ... QK_ONE_SHOT_LAYER_MAX:
	case QK_ONE_SHOT_MOD ... QK_ONE_SHOT_MOD_MAX:
#endif  // NO_ACTION_ONESHOT
#ifdef TRI_LAYER_ENABLE  // Ignore Tri Layer keys.
	case QK_TRI_LAYER_LOWER:
	case QK_TRI_LAYER_UPPER:
#endif  // TRI_LAYER_ENABLE
	  return false;

	  // Ignore hold events on tap-hold keys.
#ifndef NO_ACTION_TAPPING
	case QK_MOD_TAP ... QK_MOD_TAP_MAX:
#ifndef NO_ACTION_LAYER
	case QK_LAYER_TAP ... QK_LAYER_TAP_MAX:
#endif  // NO_ACTION_LAYER
	  if (record->tap.count == 0) {
		return false;
	  }
	  break;
#endif  // NO_ACTION_TAPPING

#ifdef SWAP_HANDS_ENABLE
	case QK_SWAP_HANDS ... QK_SWAP_HANDS_MAX:
	  if (IS_SWAP_HANDS_KEYCODE(keycode) || record->tap.count == 0) {
		return false;
	  }
	  break;
#endif  // SWAP_HANDS_ENABLE
  }

  return true;
}

static bool get_repeat_key_eligible_wrapper(uint16_t keycode,
											keyrecord_t* record,
											uint8_t* remembered_mods) {
  return get_repeat_key_eligible(keycode, record) &&
		 get_repeat_key_eligible_user(keycode, record, remembered_mods);
}

bool process_repeat_key(uint16_t keycode, keyrecord_t* record,
						uint16_t repeat_keycode) {
  if (get_repeat_key_count()) {
	return true;
  }

  if (keycode == repeat_keycode) {
	repeat_key_invoke(&record->event);
	return false;
  } else if (record->event.pressed) {
	uint8_t remembered_mods = get_mods() | get_weak_mods();
#ifndef NO_ACTION_ONESHOT
	remembered_mods |= get_oneshot_mods();
#endif  // NO_ACTION_ONESHOT

	if (get_repeat_key_eligible_wrapper(keycode, record, &remembered_mods)) {
	  set_repeat_key_record(keycode, record);
	  set_repeat_key_mods(remembered_mods);
	}
  }

  return true;
}

bool process_repeat_key_with_alt(uint16_t keycode, keyrecord_t* record,
								 uint16_t repeat_keycode,
								 uint16_t alt_repeat_keycode) {
  if (keycode == alt_repeat_keycode) {
	alt_repeat_key_invoke(&record->event);
	return false;
  }

  return process_repeat_key(keycode, record, repeat_keycode);
}

int8_t get_repeat_key_count(void) { return processing_repeat_count; }

uint16_t get_repeat_key_keycode(void) { return last_record.keycode; }

uint8_t get_repeat_key_mods(void) { return last_mods; }

void set_repeat_key_keycode(uint16_t keycode) {
  set_repeat_key_record(keycode, &(keyrecord_t){
#ifndef NO_ACTION_TAPPING
									 .tap.interrupted = false,
									 .tap.count = 1,
#endif
								 });
}

void set_repeat_key_mods(uint8_t mods) { last_mods = mods; }

uint16_t get_alt_repeat_key_keycode(void) {
  uint16_t keycode = last_record.keycode;
  uint8_t mods = last_mods;

  // Call the user callback first to give it a chance to override the default
  // alternate key definitions that follow.
  uint16_t alt_keycode = get_alt_repeat_key_keycode_user(keycode, mods);

  if (alt_keycode != KC_TRNS) {
	return alt_keycode;
  }

  // Convert 8-bit mods to the 5-bit format used in keycodes. This is lossy: if
  // left and right handed mods were mixed, they all become right handed.
  mods = ((mods & 0xf0) ? /* set right hand bit */ 0x10 : 0)
		 // Combine right and left hand mods.
		 | (((mods >> 4) | mods) & 0xf);

  switch (keycode) {
	case QK_MODS ... QK_MODS_MAX:  // Unpack modifier + basic key.
	  mods |= QK_MODS_GET_MODS(keycode);
	  keycode = QK_MODS_GET_BASIC_KEYCODE(keycode);
	  break;

#ifndef NO_ACTION_TAPPING
	case QK_MOD_TAP ... QK_MOD_TAP_MAX:
	  keycode = QK_MOD_TAP_GET_TAP_KEYCODE(keycode);
	  break;
#ifndef NO_ACTION_LAYER
	case QK_LAYER_TAP ... QK_LAYER_TAP_MAX:
	  keycode = QK_LAYER_TAP_GET_TAP_KEYCODE(keycode);
	  break;
#endif  // NO_ACTION_LAYER
#endif  // NO_ACTION_TAPPING

#ifdef SWAP_HANDS_ENABLE
	case QK_SWAP_HANDS ... QK_SWAP_HANDS_MAX:
	  if (IS_SWAP_HANDS_KEYCODE(keycode)) {
		return KC_NO;
	  }
	  keycode = QK_SWAP_HANDS_GET_TAP_KEYCODE(keycode);
	  break;
#endif  // SWAP_HANDS_ENABLE
  }

  if (IS_QK_BASIC(keycode)) {
	if ((mods & (MOD_LCTL | MOD_LALT | MOD_LGUI))) {
	  // The last key was pressed with a modifier other than Shift. The
	  // following maps
	  //   mod + F <-> mod + B
	  // and a few others, supporting several core hotkeys used in Emacs, Vim,
	  // less, and other programs.
	  // clang-format off
	  static const uint8_t pairs[][2] PROGMEM = {
		  {KC_F   , KC_B   },  // Forward / Backward.
		  {KC_D   , KC_U   },  // Down / Up.
		  {KC_N   , KC_P   },  // Next / Previous.
		  {KC_A   , KC_E   },  // Home / End.
	  };
	  // clang-format on
	  alt_keycode = find_alt_keycode(pairs, sizeof(pairs), keycode);
	} else {
	  // The last key was pressed with no mods or only Shift. The following map
	  // a few more Vim hotkeys.
	  // clang-format off
	  static const uint8_t pairs[][2] PROGMEM = {
		  {KC_J   , KC_K   },  // Down / Up.
		  {KC_H   , KC_L   },  // Left / Right.
		  // These two lines map W and E to B, and B to W.
		  {KC_W   , KC_B   },  // Forward / Backward by word.
		  {KC_E   , KC_B   },  // Forward / Backward by word.
	  };
	  // clang-format on
	  alt_keycode = find_alt_keycode(pairs, sizeof(pairs), keycode);
	}

	if (!alt_keycode) {
	  // The following key pairs are considered with any mods.
	  // clang-format off
	  static const uint8_t pairs[][2] PROGMEM = {
		  {KC_LEFT, KC_RGHT},  // Left / Right Arrow.
		  {KC_UP  , KC_DOWN},  // Up / Down Arrow.
		  {KC_HOME, KC_END },  // Home / End.
		  {KC_PGUP, KC_PGDN},  // Page Up / Page Down.
		  {KC_BSPC, KC_DEL },  // Backspace / Delete.
		  {KC_LBRC, KC_RBRC},  // Brackets [ ] and { }.
#ifdef EXTRAKEY_ENABLE
		  {KC_WBAK, KC_WFWD},  // Browser Back / Forward.
		  {KC_MNXT, KC_MPRV},  // Next / Previous Media Track.
		  {KC_MFFD, KC_MRWD},  // Fast Forward / Rewind Media.
		  {KC_VOLU, KC_VOLD},  // Volume Up / Down.
		  {KC_BRIU, KC_BRID},  // Brightness Up / Down.
#endif  // EXTRAKEY_ENABLE
#ifdef MOUSEKEY_ENABLE
		  {KC_MS_L, KC_MS_R},  // Mouse Cursor Left / Right.
		  {KC_MS_U, KC_MS_D},  // Mouse Cursor Up / Down.
		  {KC_WH_L, KC_WH_R},  // Mouse Wheel Left / Right.
		  {KC_WH_U, KC_WH_D},  // Mouse Wheel Up / Down.
#endif  // MOUSEKEY_ENABLE
	  };
	  // clang-format on
	  alt_keycode = find_alt_keycode(pairs, sizeof(pairs), keycode);
	}

	if (alt_keycode) {
	  // Combine basic keycode with mods.
	  return (mods << 8) | alt_keycode;
	}
  }

  return KC_NO;  // No alternate key found.
}

void repeat_key_register(void) {
  repeat_key_invoke(&MAKE_KEYEVENT(0, 0, true));
}

void repeat_key_unregister(void) {
  repeat_key_invoke(&MAKE_KEYEVENT(0, 0, false));
}

void repeat_key_tap(void) {
  repeat_key_register();
  wait_ms(TAP_CODE_DELAY);
  repeat_key_unregister();
}

bool alt_repeat_key_register(void) {
  if (get_alt_repeat_key_keycode()) {
	alt_repeat_key_invoke(&MAKE_KEYEVENT(0, 0, true));
	return true;
  }
  return false;
}

bool alt_repeat_key_unregister(void) {
  if (get_alt_repeat_key_keycode()) {
	alt_repeat_key_invoke(&MAKE_KEYEVENT(0, 0, false));
	return true;
  }
  return false;
}

bool alt_repeat_key_tap(void) {
  if (get_alt_repeat_key_keycode()) {
	alt_repeat_key_register();
	wait_ms(TAP_CODE_DELAY);
	alt_repeat_key_unregister();
	return true;
  }
  return false;
}

// Default implementation of get_repeat_key_eligible_user().
__attribute__((weak)) bool get_repeat_key_eligible_user(
	uint16_t keycode, keyrecord_t* record, uint8_t* remembered_mods) {
  return true;
}

// Default implementation of get_alt_repeat_key_keycode_user().
__attribute__((weak)) uint16_t get_alt_repeat_key_keycode_user(uint16_t keycode,
															   uint8_t mods) {
  return get_rev_repeat_key_keycode_user(keycode, mods);
}

// Default implementation of deprecated callback.
__attribute__((weak)) uint16_t get_rev_repeat_key_keycode_user(uint16_t keycode,
															   uint8_t mods) {
  return KC_TRNS;
}

#endif