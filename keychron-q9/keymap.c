/* Copyright 2021 @ Keychron (https://www.keychron.com)
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

combo_t key_combos[] = {};
uint16_t COMBO_LEN = 0;

enum custom_keycodes {
  REPEAT = SAFE_RANGE,
  // Other custom keys...
};

enum layers{
    MAC_BASE,
    WIN_BASE,
    _FN1,
    _FN2,
    _FN3
};

#define KC_TASK LGUI(KC_TAB)
#define KC_FLXP LGUI(KC_E)

/* Repeat key as described in: https://getreuer.info/posts/keyboards/repeat-key/ */
#include "features/repeat_key.h"

bool process_record_user(uint16_t keycode, keyrecord_t* record) {
  if (!process_repeat_key(keycode, record, REPEAT)) { return false; }
  return true;
}

/* Signal a layer switch with Programmable Keys */
/* #include "features/layer_signal.c" */

const uint16_t PROGMEM keymaps[][MATRIX_ROWS][MATRIX_COLS] = {
    [MAC_BASE] = LAYOUT_ansi_52(
        HYPR_T(KC_TAB),  KC_Q,     KC_W,     KC_E,    KC_R,    KC_T,    KC_Y,    KC_U,    KC_I,    KC_O,    KC_P,     KC_LBRC,  KC_RBRC,  KC_BSPC,          KC_MUTE,
        MEH_T(KC_ESC), KC_A,     KC_S,     KC_D,    KC_F,    KC_G,    KC_H,    KC_J,    KC_K,    KC_L,    KC_SCLN,  KC_QUOT,            KC_ENT,             REPEAT,
        SC_LSPO,           KC_Z,     KC_X,    KC_C,    KC_V,    KC_B,    KC_N,    KC_M,    KC_COMM, KC_DOT,   KC_SLSH,            SC_RSPC, KC_UP,
        OSM(MOD_LCTL), OSM(MOD_LALT),  OSM(MOD_LGUI),              LT(_FN3,KC_SPC),                      OSM(MOD_RGUI),  MO(_FN3), MO(_FN1), KC_LEFT, KC_DOWN, KC_RGHT),

    [_FN1] = LAYOUT_ansi_52(
        KC_GRV,  KC_BRID,  KC_BRIU,  KC_NO,   KC_NO,   RGB_VAD, RGB_VAI, KC_MPRV, KC_MPLY, KC_MNXT, KC_MUTE,  KC_VOLD,  KC_VOLU,  KC_DEL,           _______,
        RGB_TOG, RGB_MOD,  RGB_VAI,  RGB_HUI, RGB_SAI, RGB_SPI, _______, _______, _______, _______, _______,  _______,            _______,          _______,
        _______,           RGB_RMOD, RGB_VAD, RGB_HUD, RGB_SAD, RGB_SPD, NK_TOGG, _______, _______, _______,  _______,            _______, _______,
        _______, _______,  _______,                             _______,                            _______,  _______,  _______,  _______, _______, _______),

    [_FN3] = LAYOUT_ansi_52(
        KC_TILD,  KC_1,     KC_2,     KC_3,    KC_4,    KC_5,    KC_6,    KC_7,    KC_8,    KC_9,    KC_0,     KC_MINS,  KC_EQL,          KC_BSLS,          _______,
        KC_CAPS, KC_F1,    KC_F2,    KC_F3,   KC_F4,   KC_F5,   KC_F6,      _______,  _______, _______, _______, _______, _______,          _______,
        _______, KC_F7,   KC_F8,   KC_F9,   KC_F10,   KC_F11,   KC_F12, _______, _______, _______,  _______,            _______, _______,
        _______, _______,  _______,                             _______,                            _______,  _______,  _______,  _______, _______, _______),

    [WIN_BASE] = LAYOUT_ansi_52(
        KC_TAB,  KC_Q,     KC_W,     KC_E,    KC_R,    KC_T,    KC_Y,    KC_U,    KC_I,    KC_O,    KC_P,     KC_LBRC,  KC_RBRC,  KC_BSLS,          KC_MUTE,
        KC_CAPS, KC_A,     KC_S,     KC_D,    KC_F,    KC_G,    KC_H,    KC_J,    KC_K,    KC_L,    KC_SCLN,  KC_QUOT,            KC_ENT,           KC_HOME,
        KC_LSFT,           KC_Z,     KC_X,    KC_C,    KC_V,    KC_B,    KC_N,    KC_M,    KC_COMM, KC_DOT,   KC_SLSH,            KC_RSFT, KC_UP,
        KC_LCTL, KC_LWIN,  KC_LALT,                             KC_SPC,                             KC_RALT,  MO(_FN2), MO(_FN3), KC_LEFT, KC_DOWN, KC_RGHT),

    [_FN2] = LAYOUT_ansi_52(
        KC_GRV,  KC_BRID,  KC_BRIU,  KC_TASK, KC_FLXP, RGB_VAD, RGB_VAI, KC_MPRV, KC_MPLY, KC_MNXT, KC_MUTE,  KC_VOLD,  KC_VOLU,  _______,          _______,
        RGB_TOG, RGB_MOD,  RGB_VAI,  RGB_HUI, RGB_SAI, RGB_SPI, _______, _______, _______, _______, _______,  _______,            _______,          _______,
        _______,           RGB_RMOD, RGB_VAD, RGB_HUD, RGB_SAD, RGB_SPD, NK_TOGG, _______, _______, _______,  _______,            _______, _______,
        _______, _______,  _______,                             _______,                            _______,  _______,  _______,  _______, _______, _______)


};

#if defined(ENCODER_MAP_ENABLE)
const uint16_t PROGMEM encoder_map[][NUM_ENCODERS][2] = {
    [MAC_BASE] = {ENCODER_CCW_CW(KC_VOLD, KC_VOLU)},
    [WIN_BASE] = {ENCODER_CCW_CW(KC_VOLD, KC_VOLU)},
    [_FN1]   = {ENCODER_CCW_CW(RGB_VAD, RGB_VAI)},
    [_FN2]   = {ENCODER_CCW_CW(RGB_VAD, RGB_VAI)},
    [_FN3]   = {ENCODER_CCW_CW(A(C(S(KC_LBRC))), A(C(S(KC_RBRC))))}
};
#endif // ENCODER_MAP_ENABLE
