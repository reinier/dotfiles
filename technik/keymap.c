/* Copyright 2020 Boardsource
 *
 * This program is free software: you can redistribute it and/or modify
 * it under the terms of the GNU General Public License as published by
 * the Free Software Foundation, either version 2 of the License, or
 * (at your option) any later version.
 *
 * This program is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 * GNU General Public License for more details.
 *
 * You should have received a copy of the GNU General Public License
 * along with this program.  If not, see <http://www.gnu.org/licenses/>.
 */

#include QMK_KEYBOARD_H

#include "microhacks.c"
#include "threesixbase.c"

const rgblight_segment_t PROGMEM my_sym_layer[] = RGBLIGHT_LAYER_SEGMENTS(
    {17, 4, HSV_RED}
);
const rgblight_segment_t PROGMEM my_num_layer[] = RGBLIGHT_LAYER_SEGMENTS(
    {5, 4, HSV_RED}
);

const rgblight_segment_t PROGMEM my_nav_layer[] = RGBLIGHT_LAYER_SEGMENTS(
    {29, 4, HSV_RED}
);

const rgblight_segment_t PROGMEM my_mouse_layer[] = RGBLIGHT_LAYER_SEGMENTS(
    {41, 4, HSV_RED}
);

// Now define the array of layers. Later layers take precedence
const rgblight_segment_t* const PROGMEM my_rgb_layers[] = RGBLIGHT_LAYERS_LIST(
    my_sym_layer,
    my_num_layer,    // Overrides caps lock layer
    my_nav_layer,    // Overrides other layers
    my_mouse_layer     // Overrides other layers
);

void keyboard_post_init_user(void) {
    // Enable the LED layers
    rgblight_layers = my_rgb_layers;
}

const uint16_t PROGMEM keymaps[][MATRIX_ROWS][MATRIX_COLS] = {

  [0] = LAYOUT_ortho_4x12(
    KR_0_1_1,  KR_0_1_2,  KR_0_1_3,  KR_0_1_4,  KR_0_1_5,  _______,        _______,   KR_0_1_6,  KR_0_1_7,  KR_0_1_8,  KR_0_1_9,  KR_0_1_10,
    KR_0_2_1,  KR_0_2_2,  KR_0_2_3,  KR_0_2_4,  KR_0_2_5,  _______,        _______,   KR_0_2_6,  KR_0_2_7,  KR_0_2_8,  KR_0_2_9,  KR_0_2_10,
    KR_0_3_1,  KR_0_3_2,  KR_0_3_3,  KR_0_3_4,  KR_0_3_5,  _______,        _______,   KR_0_3_6,  KR_0_3_7,  KR_0_3_8,  KR_0_3_9,  KR_0_3_10,
    RGB_TOG,   _______,   KR_0_4_1,  KR_0_4_2,  KR_0_4_3,  _______,        _______,   KR_0_4_4,  KR_0_4_5,  KR_0_4_6,  _______,   _______
  ),

  [1] = LAYOUT_ortho_4x12(
    KR_1_1_1,  KR_1_1_2,  KR_1_1_3,  KR_1_1_4,  KR_1_1_5,  _______,        _______,   KR_1_1_6,  KR_1_1_7,  KR_1_1_8,  KR_1_1_9,  KR_1_1_10,
    KR_1_2_1,  KR_1_2_2,  KR_1_2_3,  KR_1_2_4,  KR_1_2_5,  _______,        _______,   KR_1_2_6,  KR_1_2_7,  KR_1_2_8,  KR_1_2_9,  KR_1_2_10,
    KR_1_3_1,  KR_1_3_2,  KR_1_3_3,  KR_1_3_4,  KR_1_3_5,  _______,        _______,   KR_1_3_6,  KR_1_3_7,  KR_1_3_8,  KR_1_3_9,  KR_1_3_10,
    RGB_MOD,   RGB_M_P,   KR_1_4_1,  KR_1_4_2,  KR_1_4_3,  _______,        _______,   KR_1_4_4,  KR_1_4_5,  KR_1_4_6,  RGB_VAI,   RGB_HUI
  ),

  [2] = LAYOUT_ortho_4x12(
    KR_2_1_1,  KR_2_1_2,  KR_2_1_3,  KR_2_1_4,  KR_2_1_5,  _______,        _______,   KR_2_1_6,  KR_2_1_7,  KR_2_1_8,  KR_2_1_9,  KR_2_1_10,
    KR_2_2_1,  KR_2_2_2,  KR_2_2_3,  KR_2_2_4,  KR_2_2_5,  _______,        _______,   KR_2_2_6,  KR_2_2_7,  KR_2_2_8,  KR_2_2_9,  KR_2_2_10,
    KR_2_3_1,  KR_2_3_2,  KR_2_3_3,  KR_2_3_4,  KR_2_3_5,  _______,        _______,   KR_2_3_6,  KR_2_3_7,  KR_2_3_8,  KR_2_3_9,  KR_2_3_10,
    _______,   _______,   KR_2_4_1,  KR_2_4_2,  KR_2_4_3,  _______,        _______,   KR_2_4_4,  KR_2_4_5,  KR_2_4_6,  _______,   _______
  ),
  
  [3] = LAYOUT_ortho_4x12(
    KR_3_1_1,  KR_3_1_2,  KR_3_1_3,  KR_3_1_4,  KR_3_1_5,  _______,        _______,   KR_3_1_6,  KR_3_1_7,  KR_3_1_8,  KR_3_1_9,  KR_3_1_10,
    KR_3_2_1,  KR_3_2_2,  KR_3_2_3,  KR_3_2_4,  KR_3_2_5,  _______,        _______,   KR_3_2_6,  KR_3_2_7,  KR_3_2_8,  KR_3_2_9,  KR_3_2_10,
    KR_3_3_1,  KR_3_3_2,  KR_3_3_3,  KR_3_3_4,  KR_3_3_5,  _______,        _______,   KR_3_3_6,  KR_3_3_7,  KR_3_3_8,  KR_3_3_9,  KR_3_3_10,
    _______,   _______,   KR_3_4_1,  KR_3_4_2,  KR_3_4_3,  _______,        _______,   KR_3_4_4,  KR_3_4_5,  KR_3_4_6,  _______,   _______
  ),
  
  [4] = LAYOUT_ortho_4x12(
    KR_4_1_1,  KR_4_1_2,  KR_4_1_3,  KR_4_1_4,  KR_4_1_5,  _______,        _______,   KR_4_1_6,  KR_4_1_7,  KR_4_1_8,  KR_4_1_9,  KR_4_1_10,
    KR_4_2_1,  KR_4_2_2,  KR_4_2_3,  KR_4_2_4,  KR_4_2_5,  _______,        _______,   KR_4_2_6,  KR_4_2_7,  KR_4_2_8,  KR_4_2_9,  KR_4_2_10,
    KR_4_3_1,  KR_4_3_2,  KR_4_3_3,  KR_4_3_4,  KR_4_3_5,  _______,        _______,   KR_4_3_6,  KR_4_3_7,  KR_4_3_8,  KR_4_3_9,  KR_4_3_10,
    _______,   _______,   KR_4_4_1,  KR_4_4_2,  KR_4_4_3,  _______,        _______,   KR_4_4_4,  KR_4_4_5,  KR_4_4_6,  _______,   _______
  ),

//   [_MAIN] = LAYOUT_ortho_4x12(
//     KC_TAB,  KC_Q,    KC_W,    KC_E,    KC_R,    KC_T,    KC_Y,    KC_U,    KC_I,    KC_O,    KC_P,    KC_BSPC,
//     KC_ESC,  KC_A,    KC_S,    KC_D,    KC_F,    KC_G,    KC_H,    KC_J,    KC_K,    KC_L,    KC_SCLN, KC_QUOT,
//     KC_LSFT, KC_Z,    KC_X,    KC_C,    KC_V,    KC_B,    KC_N,    KC_M,    KC_COMM, KC_DOT,  KC_SLSH, KC_ENT ,
//     RGB_TOG, KC_LCTL, KC_LALT, KC_LGUI, LOWER,   KC_SPC,  KC_SPC,  RAISE,   KC_LEFT, KC_DOWN, KC_UP,   KC_RGHT
//   ),
// 
//   [_RAISE] = LAYOUT_ortho_4x12(
//   KC_TILD, KC_EXLM, KC_AT,   KC_HASH, KC_DLR,  KC_PERC, KC_CIRC, KC_AMPR,    KC_ASTR,    KC_LPRN, KC_RPRN, KC_BSPC,
//   KC_DEL,  KC_F1,   KC_F2,   KC_F3,   KC_F4,   KC_F5,   KC_F6,   KC_UNDS,    KC_PLUS,    KC_LCBR, KC_RCBR, KC_PIPE,
//   _______, KC_F7,   KC_F8,   KC_F9,   KC_F10,  KC_F11,  KC_F12,  S(KC_NUHS), S(KC_NUBS), KC_HOME, KC_END,  _______,
//   RESET,   _______, _______, _______, _______, _______, _______, _______,    KC_MNXT,    KC_VOLD, KC_VOLU, KC_MPLY
//   ),
// 
//   [_LOWER] = LAYOUT_ortho_4x12(
//  KC_GRV,  KC_1,    KC_2,    KC_3,    KC_4,    KC_5,    KC_6,    KC_7,    KC_8,    KC_9,    KC_0,    KC_BSPC,
//  KC_DEL,  KC_F1,   KC_F2,   KC_F3,   KC_F4,   KC_F5,   KC_F6,   KC_MINS, KC_EQL,  KC_LBRC, KC_RBRC, KC_BSLS,
//  _______, KC_F7,   KC_F8,   KC_F9,   KC_F10,  KC_F11,  KC_F12,  KC_NUHS, KC_NUBS, KC_PGUP, KC_PGDN, _______,
//  RGB_MOD, _______, _______, _______, _______, _______, _______, _______, KC_MNXT, KC_VOLD, KC_VOLU, KC_MPLY
//   )

};

