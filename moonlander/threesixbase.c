/*

# Everything for a base 36 keyboard keymap like the Microdox

*/




enum combos {
  DF_CBO,
  JK_CBO,
  COMBO_LENGTH
};

uint16_t COMBO_LEN = COMBO_LENGTH;

const uint16_t PROGMEM df_combo[]   = {LALT_T(KC_D), MEH_T(KC_F), COMBO_END};
const uint16_t PROGMEM jk_combo[]   = {MEH_T(KC_J), RALT_T(KC_K), COMBO_END};

combo_t key_combos[] = {
    // D+F = TAB
    [DF_CBO] = COMBO(df_combo, KC_TAB),
    // J+K = ENTER
    [JK_CBO] = COMBO(jk_combo, KC_ENT),
};

/*

Hook for when switching layers. Now used to 'silently' sent Hammerspoon signals about the keyboard layer. It uses shift and alt to prevent the Mac from beeping when Hammerspoon is running and the keyboard is returning from the OSL to the base layer. `layer_state_set_user` is run multiple times, even in between key down and key up of a key in the OSL. This collides with the F key which then gets the modifier of the One Shot key. I prevent this by adding modifiers to the F keys.

*/

// layer_state_t layer_state_set_user(layer_state_t state) {
//   switch (get_highest_layer(state)) {
//     case 1:
//         tap_code(KC_MS_BTN5); 
//         break;
//     case 2:
//         tap_code(KC_MS_BTN6);
//         break;
//     case 3:
//         tap_code(KC_MS_BTN7); 
//         break;    
//     default:
//         //print("reinier");
//         tap_code(KC_MS_BTN4); 
//         break;  
//   }
//   return state;
// }

// Tap Dance declarations
enum {
    TD_COMM_QUOT,
    TD_DOT_SCOLN,
    TD_SLASH_DASH,
};

// - - -

// Define a type containing as many tapdance states as you need
typedef enum {
    TD_NONE,
    TD_UNKNOWN,
    TD_SINGLE_TAP,
    TD_SINGLE_HOLD,
    TD_DOUBLE_SINGLE_TAP
} td_state_t;

// Create a global instance of the tapdance state type
static td_state_t td_state;

// Declare your tapdance functions:

// Function to determine the current tapdance state
td_state_t cur_dance(qk_tap_dance_state_t *state);

// `finished` and `reset` functions for each tapdance keycode
void commquot_finished(qk_tap_dance_state_t *state, void *user_data);
void commquot_reset(qk_tap_dance_state_t *state, void *user_data);

void dotscoln_finished(qk_tap_dance_state_t *state, void *user_data);
void dotscoln_reset(qk_tap_dance_state_t *state, void *user_data);

void slashdash_finished(qk_tap_dance_state_t *state, void *user_data);
void slashdash_reset(qk_tap_dance_state_t *state, void *user_data);

// Determine the tapdance state to return
td_state_t cur_dance(qk_tap_dance_state_t *state) {
    if (state->count == 1) {
        if (state->interrupted || !state->pressed) return TD_SINGLE_TAP;
        else return TD_SINGLE_HOLD;
    }

    if (state->count == 2) return TD_DOUBLE_SINGLE_TAP;
    else return TD_UNKNOWN; // Any number higher than the maximum state value you return above
}

// Handle the possible states for each tapdance keycode you define:

void commquot_finished(qk_tap_dance_state_t *state, void *user_data) {
    td_state = cur_dance(state);
    switch (td_state) {
        case TD_SINGLE_TAP:
            register_code16(KC_COMM);
            break;
        case TD_SINGLE_HOLD:
            tap_code16(KC_QUOT);
            break;
        case TD_DOUBLE_SINGLE_TAP:
            tap_code16(KC_COMM);
            register_code16(KC_COMM);
        case TD_NONE:
        case TD_UNKNOWN:
            break;
    }
}

void commquot_reset(qk_tap_dance_state_t *state, void *user_data) {
    switch (td_state) {
        case TD_SINGLE_TAP:
            unregister_code16(KC_COMM);
            break;
        case TD_SINGLE_HOLD:
            break;
        case TD_DOUBLE_SINGLE_TAP:
            unregister_code16(KC_COMM);
            break;
        case TD_NONE:
        case TD_UNKNOWN:
            break;
    }
}

void dotscoln_finished(qk_tap_dance_state_t *state, void *user_data) {
  td_state = cur_dance(state);
  switch (td_state) {
      case TD_SINGLE_TAP:
          register_code16(KC_DOT);
          break;
      case TD_SINGLE_HOLD:
          tap_code16(LSFT(KC_SCLN));
          break;
      case TD_DOUBLE_SINGLE_TAP:
          tap_code16(KC_DOT);
          register_code16(KC_DOT);
      case TD_NONE:
      case TD_UNKNOWN:
          break;
  }
}

void dotscoln_reset(qk_tap_dance_state_t *state, void *user_data) {
  switch (td_state) {
      case TD_SINGLE_TAP:
          unregister_code16(KC_DOT);
          break;
      case TD_SINGLE_HOLD:
          break;
      case TD_DOUBLE_SINGLE_TAP:
          unregister_code16(KC_DOT);
          break;
      case TD_NONE:
      case TD_UNKNOWN:
          break;
  }
}

void slashdash_finished(qk_tap_dance_state_t *state, void *user_data) {
  td_state = cur_dance(state);
  switch (td_state) {
      case TD_SINGLE_TAP:
          register_code16(KC_SLASH);
          break;
      case TD_SINGLE_HOLD:
          tap_code16(KC_MINUS);
          break;
      case TD_DOUBLE_SINGLE_TAP:
          tap_code16(KC_SLASH);
          register_code16(KC_SLASH);
      case TD_NONE:
      case TD_UNKNOWN:
          break;
  }
}

void slashdash_reset(qk_tap_dance_state_t *state, void *user_data) {
  switch (td_state) {
      case TD_SINGLE_TAP:
          unregister_code16(KC_SLASH);
          break;
      case TD_SINGLE_HOLD:
          break;
      case TD_DOUBLE_SINGLE_TAP:
          unregister_code16(KC_SLASH);
          break;
      case TD_NONE:
      case TD_UNKNOWN:
          break;
  }
}

// - - - Tap Dance definitions
qk_tap_dance_action_t tap_dance_actions[] = {
    // [TD_COMM_QUOT] = ACTION_TAP_DANCE_DOUBLE(KC_COMM, KC_QUOT),
    [TD_COMM_QUOT] = ACTION_TAP_DANCE_FN_ADVANCED(NULL, commquot_finished, commquot_reset),
    [TD_DOT_SCOLN] = ACTION_TAP_DANCE_FN_ADVANCED(NULL, dotscoln_finished, dotscoln_reset),
    [TD_SLASH_DASH] = ACTION_TAP_DANCE_FN_ADVANCED(NULL, slashdash_finished, slashdash_reset),
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

#define KR_0_2_1 KC_A
#define KR_0_2_2 LCTL_T(KC_S)
#define KR_0_2_3 LALT_T(KC_D)
#define KR_0_2_4 MEH_T(KC_F)
#define KR_0_2_5 KC_G
//
#define KR_0_2_6 KC_H
#define KR_0_2_7 MEH_T(KC_J)
#define KR_0_2_8 RALT_T(KC_K)
#define KR_0_2_9 RCTL_T(KC_L)
#define KR_0_2_10 KC_P

// Bottom row

#define KR_0_3_1 KC_Z
#define KR_0_3_2 KC_X
#define KR_0_3_3 KC_C
#define KR_0_3_4 KC_V
#define KR_0_3_5 KC_B
//
#define KR_0_3_6 KC_N
#define KR_0_3_7 KC_M
#define KR_0_3_8 TD(TD_COMM_QUOT)
#define KR_0_3_9 TD(TD_DOT_SCOLN)
#define KR_0_3_10 TD(TD_SLASH_DASH)

// Thumb cluster

#define KR_0_4_1 KC_NO
#define KR_0_4_2 OSM(MOD_LSFT)
#define KR_0_4_3 KC_SPACE

#define KR_0_4_4 TO(1)
#define KR_0_4_5 OSM(MOD_LGUI)
#define KR_0_4_6 KC_NO


// ###### Layer 1 Symbols and arrow keys

#define KR_1_1_1 KC_ESC
#define KR_1_1_2 KC_TILD
#define KR_1_1_3 LSFT(KC_LBRC)
#define KR_1_1_4 LSFT(KC_RBRC)
#define KR_1_1_5 KC_ASTR
// LOPT(KC_SCLN) // …
#define KR_1_1_6 LSFT(KC_6) // ^
#define KR_1_1_7 KC_HASH
#define KR_1_1_8 KC_UP
#define KR_1_1_9 KC_AMPR
#define KR_1_1_10 KC_BSPC

// Mid row

#define KR_1_2_1 KC_TAB
#define KR_1_2_2 LCTL_T(KC_GRV)
#define KR_1_2_3 LALT_T(KC_LBRC)
#define KR_1_2_4 MEH_T(KC_RBRC)
#define KR_1_2_5 KC_PPLS
//
#define KR_1_2_6 KC_EXLM
#define KR_1_2_7 KC_LEFT
#define KR_1_2_8 KC_DOWN
#define KR_1_2_9 KC_RGHT
#define KR_1_2_10 KC_ENTER

// Lower row

#define KR_1_3_1 LSFT(KC_BSLASH) // |
#define KR_1_3_2 KC_BSLASH
#define KR_1_3_3 KC_LPRN
#define KR_1_3_4 KC_RPRN
#define KR_1_3_5 KC_PEQL
//
#define KR_1_3_6 LSFT(KC_MINUS) // _
#define KR_1_3_7 LSFT(KC_2) // @
#define KR_1_3_8 LSFT(KC_QUOT)
#define KR_1_3_9 KC_SCLN
#define KR_1_3_10 TO(3)


#define KR_1_4_1 KC_TRNS
#define KR_1_4_2 KC_TRNS
#define KR_1_4_3 TO(0)

#define KR_1_4_4 TO(2)
#define KR_1_4_5 KC_TRNS
#define KR_1_4_6 KC_TRNS

// ##### Layer 2 Numbers

#define KR_2_1_1 KC_ESC
#define KR_2_1_2 LSFT(KC_4) // $
#define KR_2_1_3 LALT(KC_2) // €
#define KR_2_1_4 KC_PERC
#define KR_2_1_5 KC_ASTR
//
#define KR_2_1_6 KC_COMM
#define KR_2_1_7 KC_7
#define KR_2_1_8 KC_8
#define KR_2_1_9 KC_9
#define KR_2_1_10 KC_BSPC

#define KR_2_2_1 KC_TAB
#define KR_2_2_2 LCTL_T(KC_SPACE)
#define KR_2_2_3 LALT_T(KC_DOT)
#define KR_2_2_4 MEH_T(KC_MINUS)
#define KR_2_2_5 KC_PPLS
//
#define KR_2_2_6 KC_COLN
#define KR_2_2_7 KC_4
#define KR_2_2_8 KC_5
#define KR_2_2_9 KC_6
#define KR_2_2_10 KC_ENTER

#define KR_2_3_1 KC_NO
#define KR_2_3_2 KC_NO
#define KR_2_3_3 KC_NO
#define KR_2_3_4 KC_SLSH
#define KR_2_3_5 KC_PEQL
//
#define KR_2_3_6 KC_0
#define KR_2_3_7 KC_1
#define KR_2_3_8 KC_2
#define KR_2_3_9 KC_3
#define KR_2_3_10 TO(3)

#define KR_2_4_1 KC_TRNS
#define KR_2_4_2 KC_TRNS
#define KR_2_4_3 TO(0)

#define KR_2_4_4 TO(1)
#define KR_2_4_5 KC_TRNS
#define KR_2_4_6 KC_TRNS

// ##### Layer 3 Navigation

#define KR_3_1_1 KC_ESC
#define KR_3_1_2 KC_MS_ACCEL1
#define KR_3_1_3 KC_MS_ACCEL2
#define KR_3_1_4 LSG(KC_4) // Screenshot button `cmd shift 4`
#define KR_3_1_5 KC_NO
//
#define KR_3_1_6 KC_MS_WH_DOWN
#define KR_3_1_7 KC_MS_WH_RIGHT
#define KR_3_1_8 KC_MS_UP
#define KR_3_1_9 KC_MS_WH_LEFT
#define KR_3_1_10 KC_BSPC


#define KR_3_2_1 KC_TAB
#define KR_3_2_2 KC_SPACE
#define KR_3_2_3 KC_MS_ACCEL0
#define KR_3_2_4 KC_MS_BTN1
#define KR_3_2_5 KC_MS_BTN2
//
#define KR_3_2_6 KC_MS_WH_UP
#define KR_3_2_7 KC_MS_LEFT
#define KR_3_2_8 KC_MS_DOWN
#define KR_3_2_9 KC_MS_RIGHT
#define KR_3_2_10 KC_ENTER


#define KR_3_3_1 KC_CAPS
#define KR_3_3_2 KC_LCTRL
#define KR_3_3_3 KC_LALT
#define KR_3_3_4 KC_MEH
#define KR_3_3_5 KC_NO

#define KR_3_3_6 KC_NO
#define KR_3_3_7 KC_NO
#define KR_3_3_8 KC_NO
#define KR_3_3_9 KC_NO
#define KR_3_3_10 KC_NO

#define KR_3_4_1 KC_TRNS
#define KR_3_4_2 KC_TRNS
#define KR_3_4_3 TO(0)

#define KR_3_4_4 TO(1)
#define KR_3_4_5 KC_TRNS
#define KR_3_4_6 KC_TRNS