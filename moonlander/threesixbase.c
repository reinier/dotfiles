/*

# Everything for a base 36 keyboard keymap like the Microdox


Please note that I've changed the tap dances so often that the variable and function names don't match up with what they actually do anymore.
*/

/*

------------------------------------

## Tapdances

------------------------------------

*/

enum td_keycodes {
  DOT_EL, // `…` when tripple tap, `.` when tapped
  EUR_DOL, // `$` when double pressed, `€` when tapped
  PI_PASTE, // `SHFT-OPT-CMD v` when held, | when tapped
  ESC_FRC, // `Force quit` when double tapped, ESC when tapped
  CMD_EXL, // `CMD` when held, `!` when tapped
  ALT_AMP,
  CTRL_AMP,
  CMD_LPRN,
  SFT_RPRN,
  ALT_COLN,
  THE_THUMB,
  RIGHT_THUMB,
  TO_BASE
};

typedef enum {
  TD_NONE,
  TD_UNKNOWN,
  TD_SINGLE_TAP,
  TD_SINGLE_HOLD,
  TD_DOUBLE_TAP,
  TD_DOUBLE_HOLD,
  TD_DOUBLE_SINGLE_TAP, // Send two single taps
  TD_TRIPLE_TAP,
  TD_TRIPLE_HOLD
} td_state_t;

typedef struct {
  bool is_press_action;
  td_state_t state;
} td_tap_t;

// Create a global instance of the tapdance state type
static td_state_t td_state;

// Initialize tap structure associated with example tap dance key
static td_tap_t thethumb_tap_state = {
  .is_press_action = true,
  .state = TD_NONE
};

static td_tap_t rightthumb_tap_state = {
  .is_press_action = true,
  .state = TD_NONE
};

static td_tap_t tobase_tap_state = {
  .is_press_action = true,
  .state = TD_NONE
};


// Declare your tapdance functions:

// Function to determine the current tapdance state
td_state_t cur_dance(qk_tap_dance_state_t *state);

// `finished` and `reset` functions for each tapdance keycode
void dotel_finished(qk_tap_dance_state_t *state, void *user_data);
void dotel_reset(qk_tap_dance_state_t *state, void *user_data);

void eurdol_finished(qk_tap_dance_state_t *state, void *user_data);
void eurdol_reset(qk_tap_dance_state_t *state, void *user_data);

void pipaste_finished(qk_tap_dance_state_t *state, void *user_data);
void pipaste_reset(qk_tap_dance_state_t *state, void *user_data);

void escfrc_finished(qk_tap_dance_state_t *state, void *user_data);
void escfrc_reset(qk_tap_dance_state_t *state, void *user_data);

void cmdexl_finished(qk_tap_dance_state_t *state, void *user_data);
void cmdexl_reset(qk_tap_dance_state_t *state, void *user_data);

void altamp_finished(qk_tap_dance_state_t *state, void *user_data);
void altamp_reset(qk_tap_dance_state_t *state, void *user_data);

void ctrlamp_finished(qk_tap_dance_state_t *state, void *user_data);
void ctrlamp_reset(qk_tap_dance_state_t *state, void *user_data);

void cmdlprn_finished(qk_tap_dance_state_t *state, void *user_data);
void cmdlprn_reset(qk_tap_dance_state_t *state, void *user_data);

void sftrprn_finished(qk_tap_dance_state_t *state, void *user_data);
void sftrprn_reset(qk_tap_dance_state_t *state, void *user_data);

void altcoln_finished(qk_tap_dance_state_t *state, void *user_data);
void altcoln_reset(qk_tap_dance_state_t *state, void *user_data);

void thethumb_finished(qk_tap_dance_state_t *state, void *user_data);
void thethumb_reset(qk_tap_dance_state_t *state, void *user_data);

void rightthumb_finished(qk_tap_dance_state_t *state, void *user_data);
void thethumb_reset(qk_tap_dance_state_t *state, void *user_data);


/* Return an integer that corresponds to what kind of tap dance should be executed.
 *
 * How to figure out tap dance state: interrupted and pressed.
 *
 * Interrupted: If the state of a tap dance is "interrupted", that means that another key has been hit
 *  under the tapping term. This is typically indicitive that you are trying to "tap" the key.
 *
 * Pressed: Whether or not the key is still being pressed. If this value is true, that means the tapping term
 *  has ended, but the key is still being pressed down. This generally means the key is being "held".
 *
 * One thing that is currenlty not possible with qmk software in regards to tap dance is to mimic the "permissive hold"
 *  feature. In general, advanced tap dances do not work well if they are used with commonly typed letters.
 *  For example "A". Tap dances are best used on non-letter keys that are not hit while typing letters.
 *
 * Good places to put an advanced tap dance:
 *  z,q,x,j,k,v,b, any function key, home/end, comma, semi-colon
 *
 * Criteria for "good placement" of a tap dance key:
 *  Not a key that is hit frequently in a sentence
 *  Not a key that is used frequently to double tap, for example 'tab' is often double tapped in a terminal, or
 *    in a web form. So 'tab' would be a poor choice for a tap dance.
 *  Letters used in common words as a double. For example 'p' in 'pepper'. If a tap dance function existed on the
 *    letter 'p', the word 'pepper' would be quite frustating to type.
 *
 * For the third point, there does exist the 'TD_DOUBLE_SINGLE_TAP', however this is not fully tested
 *
 */
td_state_t cur_dance(qk_tap_dance_state_t *state) {
  if (state->count == 1) {
  if (state->interrupted || !state->pressed) return TD_SINGLE_TAP;
  // Key has not been interrupted, but the key is still held. Means you want to send a 'HOLD'.
  else return TD_SINGLE_HOLD;
  } else if (state->count == 2) {
  // TD_DOUBLE_SINGLE_TAP is to distinguish between typing "pepper", and actually wanting a double tap
  // action when hitting 'pp'. Suggested use case for this return value is when you want to send two
  // keystrokes of the key, and not the 'double tap' action/macro.
  if (state->interrupted) return TD_DOUBLE_SINGLE_TAP;
  else if (state->pressed) return TD_DOUBLE_HOLD;
  else return TD_DOUBLE_TAP;
  }

  // Assumes no one is trying to type the same letter three times (at least not quickly).
  // If your tap dance key is 'KC_W', and you want to type "www." quickly - then you will need to add
  // an exception here to return a 'TD_TRIPLE_SINGLE_TAP', and define that enum just like 'TD_DOUBLE_SINGLE_TAP'
  if (state->count == 3) {
  if (state->interrupted || !state->pressed) return TD_TRIPLE_TAP;
  else return TD_TRIPLE_HOLD;
  } else return TD_UNKNOWN;
}

// Handle the possible states for each tapdance keycode you define:

// DOTEL

void dotel_finished(qk_tap_dance_state_t *state, void *user_data) {
  td_state = cur_dance(state);
  switch (td_state) {
  case TD_SINGLE_TAP: // .
    register_code16(KC_DOT);
    break;
  case TD_DOUBLE_TAP: // ..
    tap_code16(KC_DOT);
    register_code16(KC_DOT);  
    break;
  case TD_TRIPLE_TAP: // …
    register_code16(LOPT(KC_SCLN));
    break;
  default:
    break;
  }
}

void dotel_reset(qk_tap_dance_state_t *state, void *user_data) {
  switch (td_state) {
  case TD_SINGLE_TAP:
    unregister_code16(KC_DOT);
    break;
  case TD_DOUBLE_TAP:
    unregister_code16(KC_DOT);
    break;
  case TD_TRIPLE_TAP:
    unregister_code16(LOPT(KC_SCLN));
    break;
  default:
    break;
  }
}

// EURDOL

void eurdol_finished(qk_tap_dance_state_t *state, void *user_data) {
  td_state = cur_dance(state);
  switch (td_state) {
  case TD_SINGLE_TAP: // €
    register_code16(LALT(KC_2));
    break;
  case TD_DOUBLE_TAP: // $
    register_code16(LSFT(KC_4));
    break;
  default:
    break;
  }
}

void eurdol_reset(qk_tap_dance_state_t *state, void *user_data) {
  switch (td_state) {
  case TD_SINGLE_TAP:
    unregister_code16(LALT(KC_2));
    break;
  case TD_DOUBLE_TAP:
    unregister_code16(LSFT(KC_4));
    break;
  default:
    break;
  }
}

// PIPASTE

void pipaste_finished(qk_tap_dance_state_t *state, void *user_data) {
  td_state = cur_dance(state);
  switch (td_state) {
  case TD_SINGLE_TAP: // |
    register_code16(LSFT(KC_BSLASH));
    break;
  case TD_DOUBLE_TAP: // Paste and match style
    register_code16(LSA(LGUI(KC_V)));
    break;
  default:
    break;
  }
}

void pipaste_reset(qk_tap_dance_state_t *state, void *user_data) {
  switch (td_state) {
  case TD_SINGLE_TAP:
    unregister_code16(LSFT(KC_BSLASH));
    break;
  case TD_DOUBLE_TAP:
    unregister_code16(LSA(LGUI(KC_V)));
    break;
  default:
    break;
  }
}

// ESCFORCE

void escfrc_finished(qk_tap_dance_state_t *state, void *user_data) {
  td_state = cur_dance(state);
  switch (td_state) {
  case TD_SINGLE_TAP: // Paste and match style
    register_code16(KC_ESC);
    break;
  case TD_DOUBLE_TAP: // |
    register_code16(LAG(KC_ESC));
    break;
  default:
    break;
  }
}

void escfrc_reset(qk_tap_dance_state_t *state, void *user_data) {
  switch (td_state) {
  case TD_SINGLE_TAP:
    unregister_code16(KC_ESC);
    break;
  case TD_DOUBLE_TAP:
    unregister_code16(LAG(KC_ESC));
    break;
  default:
    break;
  }
}

// CMD '

void cmdexl_finished(qk_tap_dance_state_t *state, void *user_data) {
  td_state = cur_dance(state);
  switch (td_state) {
  case TD_SINGLE_TAP:
    register_code16(KC_QUOT);
    break;
  case TD_SINGLE_HOLD:
    register_code16(KC_LGUI);
    break;
  default:
    break;
  }
}

void cmdexl_reset(qk_tap_dance_state_t *state, void *user_data) {
  switch (td_state) {
  case TD_SINGLE_TAP:
    unregister_code16(KC_QUOT);
    break;
  case TD_SINGLE_HOLD:
    unregister_code16(KC_LGUI);
    break;
  default:
    break;
  }
}

// ALT @ &

void altamp_finished(qk_tap_dance_state_t *state, void *user_data) {
  td_state = cur_dance(state);
  switch (td_state) {
  case TD_SINGLE_TAP:
    register_code16(LSFT(KC_2));
    break;
  case TD_SINGLE_HOLD:
    register_code16(KC_LALT);
    break;
  default:
    break;
  }
}

void altamp_reset(qk_tap_dance_state_t *state, void *user_data) {
  switch (td_state) {
  case TD_SINGLE_TAP:
    unregister_code16(LSFT(KC_2));
    break;
  case TD_SINGLE_HOLD:
    unregister_code16(KC_LALT);
    break;
  default:
    break;
  }
}


// LCTL_T(KC_AMPR)

void ctrlamp_finished(qk_tap_dance_state_t *state, void *user_data) {
  td_state = cur_dance(state);
  switch (td_state) {
  case TD_SINGLE_TAP:
    register_code16(KC_AMPR);
    break;
  case TD_SINGLE_HOLD:
    register_code16(KC_LCTRL);
    break;
  default:
    break;
  }
}

void ctrlamp_reset(qk_tap_dance_state_t *state, void *user_data) {
  switch (td_state) {
  case TD_SINGLE_TAP:
    unregister_code16(KC_AMPR);
    break;
  case TD_SINGLE_HOLD:
    unregister_code16(KC_LCTRL);
    break;
  default:
    break;
  }
}

// CMD LPRN

void cmdlprn_finished(qk_tap_dance_state_t *state, void *user_data) {
  td_state = cur_dance(state);
  switch (td_state) {
  case TD_SINGLE_TAP:
    register_code16(KC_LPRN);
    break;
  case TD_SINGLE_HOLD:
    register_code16(KC_RGUI);
    break;
  default:
    break;
  }
}

void cmdlprn_reset(qk_tap_dance_state_t *state, void *user_data) {
  switch (td_state) {
  case TD_SINGLE_TAP:
    unregister_code16(KC_LPRN);
    break;
  case TD_SINGLE_HOLD:
    unregister_code16(KC_RGUI);
    break;
  default:
    break;
  }
}

// SHIFT RPRN

void sftrprn_finished(qk_tap_dance_state_t *state, void *user_data) {
  td_state = cur_dance(state);
  switch (td_state) {
  case TD_SINGLE_TAP:
    register_code16(KC_RPRN);
    break;
  case TD_SINGLE_HOLD:
    register_code(KC_RALT);
    break;
  default:
    break;
  }
}

void sftrprn_reset(qk_tap_dance_state_t *state, void *user_data) {
  switch (td_state) {
  case TD_SINGLE_TAP:
    unregister_code16(KC_RPRN);
    break;
  case TD_SINGLE_HOLD:
    unregister_code(KC_RALT);
    break;
  default:
    break;
  }
}

// CTRL + : 

void altcoln_finished(qk_tap_dance_state_t *state, void *user_data) {
  td_state = cur_dance(state);
  switch (td_state) {
  case TD_SINGLE_TAP:
    register_code16(KC_COLN);
    break;
  case TD_SINGLE_HOLD:
    register_code16(KC_RCTRL);
    break;
  default:
    break;
  }
}

void altcoln_reset(qk_tap_dance_state_t *state, void *user_data) {
  switch (td_state) {
  case TD_SINGLE_TAP:
    unregister_code16(KC_COLN);
    break;
  case TD_SINGLE_HOLD:
    unregister_code16(KC_RCTRL);
    break;
  default:
    break;
  }
}

// THE THUMB

// Functions that control what our tap dance key does
void thethumb_finished(qk_tap_dance_state_t *state, void *user_data) {
  
  thethumb_tap_state.state = cur_dance(state);
  switch (thethumb_tap_state.state) {
    case TD_SINGLE_TAP:
      // Check to see if the layer is already set
      if (layer_state_is(2)) {
        // If already set, then switch it off
        layer_off(2);
        register_code16(LCTL(KC_F13));
        unregister_code16(LCTL(KC_F13));
      } else {
        // If not already set, then switch the layer on
        layer_on(2);
        register_code16(LCTL(KC_F15));
        unregister_code16(LCTL(KC_F15));
      }
      break;
    case TD_SINGLE_HOLD:
      layer_on(2);
      register_code16(LCTL(KC_F15));
      unregister_code16(LCTL(KC_F15));
      break;
    case TD_DOUBLE_TAP:
      // Check to see if the layer is already set
      if (layer_state_is(3)) {
        // If already set, then switch it off
        layer_off(3);
        register_code16(LCTL(KC_F13));
        unregister_code16(LCTL(KC_F13));
      } else {
        // If not already set, then switch the layer on
        layer_on(3);
        register_code16(LCTL(KC_F16));
        unregister_code16(LCTL(KC_F16));
      }
      break;
    case TD_DOUBLE_HOLD:
      layer_on(3);
      register_code16(LCTL(KC_F16));
      unregister_code16(LCTL(KC_F16));
      break;
    case TD_TRIPLE_TAP:
    // Check to see if the layer is already set
    if (layer_state_is(4)) {
      // If already set, then switch it off
      layer_off(4);
      register_code16(LCTL(KC_F13));
      unregister_code16(LCTL(KC_F13));
    } else {
      // If not already set, then switch the layer on
      layer_on(4);
      register_code16(LCTL(KC_F17));
      unregister_code16(LCTL(KC_F17));
    }
    break;
    case TD_TRIPLE_HOLD:
      layer_on(4);
      register_code16(LCTL(KC_F17));
      unregister_code16(LCTL(KC_F17));
      break;
    default:
      break;
  }
}

void thethumb_reset(qk_tap_dance_state_t *state, void *user_data) {
  // If the key was held down and now is released then switch off the layer
  if (thethumb_tap_state.state == TD_SINGLE_HOLD) {
    layer_off(2);
    register_code16(LCTL(KC_F13));
    unregister_code16(LCTL(KC_F13));
  } else if (thethumb_tap_state.state == TD_DOUBLE_HOLD) {
    layer_off(3);
    register_code16(LCTL(KC_F13));
    unregister_code16(LCTL(KC_F13));
  } else if (thethumb_tap_state.state == TD_TRIPLE_HOLD) {
    layer_off(4);
    register_code16(LCTL(KC_F13));
    unregister_code16(LCTL(KC_F13));
  }
  thethumb_tap_state.state = TD_NONE;
}

// Insert THE RIGHT THUMB here
// its possible to add layer 1 as a OSL with:
// layer_on(1);
// set_oneshot_layer(1, ONESHOT_START);
// clear_oneshot_layer_state(ONESHOT_PRESSED);
// https://www.reddit.com/r/olkb/comments/4izhrp/qmk_oneshot_question/
// From the docs:
// For one shot layers, you need to call set_oneshot_layer(LAYER, ONESHOT_START) on key down, and clear_oneshot_layer_state(ONESHOT_PRESSED) on key up. If you want to cancel the oneshot, call reset_oneshot_layer().

// After adding THE RIGHT THUMB you can signal the computer about what layer you are on
// https://balatero.com/writings/qmk/add-visual-layer-indicator-for-qmk-to-mac-os/
// F15 = layer 0
// F20 = layer 1
// F21 = layer 2
// Use modifiers on the K keys?

// THE THUMB

// Functions that control what our tap dance key does
void rightthumb_finished(qk_tap_dance_state_t *state, void *user_data) {
  rightthumb_tap_state.state = cur_dance(state);
  switch (rightthumb_tap_state.state) {
    case TD_SINGLE_TAP:
      layer_on(1);
      set_oneshot_layer(1, ONESHOT_START);
      clear_oneshot_layer_state(ONESHOT_PRESSED);
      break;
    case TD_SINGLE_HOLD:
      layer_on(1);
      register_code16(LCTL(KC_F14));
      unregister_code16(LCTL(KC_F14));
      break;
    default:
      break;
  }
}

void rightthumb_reset(qk_tap_dance_state_t *state, void *user_data) {
  // If the key was held down and now is released then switch off the layer
  if (rightthumb_tap_state.state == TD_SINGLE_HOLD) {
    layer_off(1);
    register_code16(LCTL(KC_F13));
    unregister_code16(LCTL(KC_F13));
  }
  rightthumb_tap_state.state = TD_NONE;
}

// Sent layer key to computer when one shot layer change finished
void oneshot_layer_changed_user(uint8_t layer) {
  if (layer == 1) {
    register_code16(LCTL(KC_F14));
    unregister_code16(LCTL(KC_F14));
  }
  if (!layer) {
    register_code16(LCTL(KC_F13));
    unregister_code16(LCTL(KC_F13));
  }
}

// Functions that control what our tap dance key does
void tobase_finished(qk_tap_dance_state_t *state, void *user_data) {
  tobase_tap_state.state = cur_dance(state);
  switch (tobase_tap_state.state) {
    case TD_SINGLE_TAP:
      layer_move(0);
      register_code16(LCTL(KC_F13));
      unregister_code16(LCTL(KC_F13));
      break;
    default:
      break;
  }
}

void tobase_reset(qk_tap_dance_state_t *state, void *user_data) {
  tobase_tap_state.state = TD_NONE;
}

// Define `ACTION_TAP_DANCE_FN_ADVANCED()` for each tapdance keycode, passing in `finished` and `reset` functions
qk_tap_dance_action_t tap_dance_actions[] = {
  [DOT_EL] = ACTION_TAP_DANCE_FN_ADVANCED(NULL, dotel_finished, dotel_reset),
  [EUR_DOL] = ACTION_TAP_DANCE_FN_ADVANCED(NULL, eurdol_finished, eurdol_reset),
  [PI_PASTE] = ACTION_TAP_DANCE_FN_ADVANCED(NULL, pipaste_finished, pipaste_reset),
  [ESC_FRC] = ACTION_TAP_DANCE_FN_ADVANCED(NULL, escfrc_finished, escfrc_reset),
  [CMD_EXL] = ACTION_TAP_DANCE_FN_ADVANCED(NULL, cmdexl_finished, cmdexl_reset),
  [ALT_AMP] = ACTION_TAP_DANCE_FN_ADVANCED(NULL, altamp_finished, altamp_reset),
  [CTRL_AMP] = ACTION_TAP_DANCE_FN_ADVANCED(NULL, ctrlamp_finished, ctrlamp_reset),
  [CMD_LPRN] = ACTION_TAP_DANCE_FN_ADVANCED(NULL, cmdlprn_finished, cmdlprn_reset),
  [SFT_RPRN] = ACTION_TAP_DANCE_FN_ADVANCED(NULL, sftrprn_finished, sftrprn_reset),
  [ALT_COLN] = ACTION_TAP_DANCE_FN_ADVANCED(NULL, altcoln_finished, altcoln_reset),
  [THE_THUMB] = ACTION_TAP_DANCE_FN_ADVANCED_TIME(NULL, thethumb_finished, thethumb_reset, 275),
  [RIGHT_THUMB] = ACTION_TAP_DANCE_FN_ADVANCED_TIME(NULL, rightthumb_finished, rightthumb_reset, 275),
  [TO_BASE] = ACTION_TAP_DANCE_FN_ADVANCED_TIME(NULL, tobase_finished, tobase_reset, 275),
};



/*

------------------------------------

## 36 Base Keymap

------------------------------------

*/

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

#define KR_0_2_1 LCTL_T(KC_A)
#define KR_0_2_2 LALT_T(KC_S)
#define KR_0_2_3 LSFT_T(KC_D)
#define KR_0_2_4 LGUI_T(KC_F)
#define KR_0_2_5 KC_G
//
#define KR_0_2_6 KC_H
#define KR_0_2_7 RGUI_T(KC_J)
#define KR_0_2_8 RSFT_T(KC_K)
#define KR_0_2_9 RALT_T(KC_L)
#define KR_0_2_10 RCTL_T(KC_P)

// Bottom row

#define KR_0_3_1 KC_Z
#define KR_0_3_2 KC_X
#define KR_0_3_3 KC_C
#define KR_0_3_4 KC_V
#define KR_0_3_5 KC_B
//
#define KR_0_3_6 KC_N
#define KR_0_3_7 KC_M
#define KR_0_3_8 KC_COMM
#define KR_0_3_9 TD(DOT_EL)
#define KR_0_3_10 KC_SLSH

// Thumb cluster

#define KR_0_4_1 KC_TAB
#define KR_0_4_2 KC_SPACE
#define KR_0_4_3 TD(THE_THUMB)

#define KR_0_4_4 HYPR_T(KC_ENTER)
#define KR_0_4_5 TD(RIGHT_THUMB)
#define KR_0_4_6 KC_MEH



// ###### Layer 1 Characters

#define KR_1_1_1 KC_ESC
#define KR_1_1_2 KC_DEL
#define KR_1_1_3 TD(EUR_DOL)
#define KR_1_1_4 KC_GRV
#define KR_1_1_5 KC_NO
//
#define KR_1_1_6 KC_NO
#define KR_1_1_7 KC_UNDS
#define KR_1_1_8 KC_EXLM
#define KR_1_1_9 KC_TILD
#define KR_1_1_10 KC_BSPC

// Mid row

#define KR_1_2_1 TD(CTRL_AMP)
#define KR_1_2_2 TD(ALT_AMP)
#define KR_1_2_3 LSFT_T(KC_MINUS)
#define KR_1_2_4 TD(CMD_EXL)
#define KR_1_2_5 KC_DQUO
//
#define KR_1_2_6 KC_HASH
#define KR_1_2_7 TD(CMD_LPRN)
#define KR_1_2_8 TD(SFT_RPRN)
#define KR_1_2_9 TD(ALT_COLN)
#define KR_1_2_10 RCTL_T(KC_SCLN)

// Lower row

#define KR_1_3_1 KC_NO
#define KR_1_3_2 KC_NO
#define KR_1_3_3 KC_NO
#define KR_1_3_4 TD(PI_PASTE)
#define KR_1_3_5 KC_NO
//
#define KR_1_3_6 KC_NO
#define KR_1_3_7 KC_LBRC
#define KR_1_3_8 KC_RBRC
#define KR_1_3_9 KC_NO
#define KR_1_3_10 KC_BSLASH


#define KR_1_4_1 KC_TAB
#define KR_1_4_2 KC_SPACE
#define KR_1_4_3 KC_NO

#define KR_1_4_4 HYPR_T(KC_ENTER)
#define KR_1_4_5 KC_NO
#define KR_1_4_6 TD(TO_BASE)

// ##### Layer 2 Navigation

#define KR_2_1_1 KC_ESC
#define KR_2_1_2 KC_DEL
#define KR_2_1_3 KC_CAPS
#define KR_2_1_4 LGUI(KC_GRV)
#define KR_2_1_5 LCTL(KC_TAB)
//
#define KR_2_1_6 KC_PGUP
#define KR_2_1_7 LGUI(KC_LBRC)
#define KR_2_1_8 KC_UP
#define KR_2_1_9 LGUI(KC_RBRC)
#define KR_2_1_10 KC_BSPC


#define KR_2_2_1 KC_LCTRL
#define KR_2_2_2 KC_LALT
#define KR_2_2_3 KC_LSFT
#define KR_2_2_4 KC_LCMD
#define KR_2_2_5 KC_NO
//
#define KR_2_2_6 KC_PGDN
#define KR_2_2_7 KC_LEFT
#define KR_2_2_8 KC_DOWN
#define KR_2_2_9 KC_RGHT
#define KR_2_2_10 KC_RCTRL


#define KR_2_3_1 LGUI(KC_Z)
#define KR_2_3_2 LGUI(KC_X)
#define KR_2_3_3 LGUI(KC_C)
#define KR_2_3_4 LGUI(KC_V)
#define KR_2_3_5 KC_NO
//
#define KR_2_3_6 KC_NO
#define KR_2_3_7 LGUI(KC_MINUS)
#define KR_2_3_8 LGUI(KC_EQL)
#define KR_2_3_9 KC_NO
#define KR_2_3_10 KC_NO

#define KR_2_4_1 KC_TAB
#define KR_2_4_2 KC_SPACE
#define KR_2_4_3 KC_NO

#define KR_2_4_4 HYPR_T(KC_ENTER)
#define KR_2_4_5 KC_NO
#define KR_2_4_6 TD(TO_BASE)

// ##### Layer 3 Numpad

#define KR_3_1_1 TD(ESC_FRC)
#define KR_3_1_2 KC_DEL
#define KR_3_1_3 KC_NO
#define KR_3_1_4 KC_PERC
#define KR_3_1_5 KC_NO
//
#define KR_3_1_6 KC_DOT
#define KR_3_1_7 KC_7
#define KR_3_1_8 KC_8
#define KR_3_1_9 KC_9
#define KR_3_1_10 KC_BSPC


#define KR_3_2_1 KC_LCTRL
#define KR_3_2_2 KC_LALT
#define KR_3_2_3 LSFT_T(KC_PMNS)
#define KR_3_2_4 LGUI_T(KC_PPLS)
#define KR_3_2_5 KC_COLN
//
#define KR_3_2_6 KC_COMM
#define KR_3_2_7 KC_4
#define KR_3_2_8 KC_5
#define KR_3_2_9 KC_6
#define KR_3_2_10 KC_RCTRL


#define KR_3_3_1 KC_NO
#define KR_3_3_2 KC_NO
#define KR_3_3_3 KC_NO
#define KR_3_3_4 KC_ASTR
#define KR_3_3_5 KC_PEQL
//
#define KR_3_3_6 KC_0
#define KR_3_3_7 KC_1
#define KR_3_3_8 KC_2
#define KR_3_3_9 KC_3
#define KR_3_3_10 KC_SLSH


#define KR_3_4_1 KC_TAB
#define KR_3_4_2 KC_SPACE
#define KR_3_4_3 KC_NO

#define KR_3_4_4 HYPR_T(KC_ENTER)
#define KR_3_4_5 KC_NO
#define KR_3_4_6 TD(TO_BASE)


// ##### Layer 4 Mouse

#define KR_4_1_1 KC_ESC
#define KR_4_1_2 KC_NO
#define KR_4_1_3 KC_NO
#define KR_4_1_4 KC_MS_BTN2
#define KR_4_1_5 KC_NO
//
#define KR_4_1_6 KC_MS_WH_DOWN
#define KR_4_1_7 KC_MS_WH_RIGHT
#define KR_4_1_8 KC_MS_UP
#define KR_4_1_9 KC_MS_WH_LEFT
#define KR_4_1_10 KC_NO


#define KR_4_2_1 KC_LCTRL
#define KR_4_2_2 KC_LALT
#define KR_4_2_3 KC_LSHIFT
#define KR_4_2_4 KC_LGUI
#define KR_4_2_5 KC_MS_BTN1
//
#define KR_4_2_6 KC_MS_WH_UP
#define KR_4_2_7 KC_MS_LEFT
#define KR_4_2_8 KC_MS_DOWN
#define KR_4_2_9 KC_MS_RIGHT
#define KR_4_2_10 KC_RCTRL


#define KR_4_3_1 KC_NO
#define KR_4_3_2 KC_MS_ACCEL0
#define KR_4_3_3 KC_MS_ACCEL1
#define KR_4_3_4 KC_MS_ACCEL2
#define KR_4_3_5 KC_NO
//
#define KR_4_3_6 KC_NO
#define KR_4_3_7 KC_NO
#define KR_4_3_8 KC_NO
#define KR_4_3_9 KC_NO
#define KR_4_3_10 KC_NO

#define KR_4_4_1 KC_TAB
#define KR_4_4_2 KC_SPACE
#define KR_4_4_3 KC_NO

#define KR_4_4_4 HYPR_T(KC_ENTER)
#define KR_4_4_5 KC_NO
#define KR_4_4_6 TD(TO_BASE)
