/* Copyright 2020 ZSA Technology Labs, Inc <@zsa>
 * Copyright 2020 Jack Humbert <jack.humb@gmail.com>
 * Copyright 2020 Christopher Courtney, aka Drashna Jael're  (@drashna) <drashna@live.com>
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
#include "version.h"

#include "microhacks.c"
#include "threefourbase.c"
#include "moonlanderextras.c"

const uint16_t PROGMEM keymaps[][MATRIX_ROWS][MATRIX_COLS] = {
[0] = LAYOUT_moonlander(
        RGB_M_B, KR_0_1_1,  KR_0_1_2,  KR_0_1_3,  KR_0_1_4,  KR_0_1_5,  _______,    KC_RBRC,  KR_0_1_6,  KR_0_1_7,  KR_0_1_8, KR_0_1_9,  KR_0_1_10,  KR_0_1_11,
        RGB_MOD, KR_0_2_1,  KR_0_2_2,  KR_0_2_3,  KR_0_2_4,  KR_0_2_5,  _______,    KC_LBRC,  KR_0_2_6,  KR_0_2_7,  KR_0_2_8, KR_0_2_9,  KR_0_2_10,  KR_0_2_11,
        RGB_RMOD, KR_0_3_1,  KR_0_3_2,  KR_0_3_3,  KR_0_3_4,  KR_0_3_5,  _______,   _______,  KR_0_3_6,  KR_0_3_7, KR_0_3_8, KR_0_3_9,  KR_0_3_10,  KR_0_3_11,
        RGB_TOG,   RGB_HUI, RGB_HUD,   _______,  KR_0_4_2,  KR_0_4_3,                        KR_0_4_4,  KR_0_4_5, KC_LEFT,  KC_DOWN,   KC_UP,      KC_RIGHT, 
        _______, _______,   _______,   _______,   _______,   _______,                      _______,   _______,   _______,   _______,   _______,    _______,
                                                  THUMB1, THUMB2, THUMB3,     THUMB3, THUMB2, THUMB1
    ),

    [1] = LAYOUT_moonlander(
        RGB_SAI, KR_1_1_1,  KR_1_1_2,  KR_1_1_3,  KR_1_1_4,  KR_1_1_5,  _______,    _______,  KR_1_1_6,  KR_1_1_7,  KR_1_1_8,  KR_1_1_9,  KR_1_1_10,  _______,
        RGB_SAD, KR_1_2_1,  KR_1_2_2,  KR_1_2_3,  KR_1_2_4,  KR_1_2_5,  _______,    _______,  KR_1_2_6,  KR_1_2_7,  KR_1_2_8,  KR_1_2_9,  KR_1_2_10,  _______,
        RGB_VAI, KR_1_3_1,  KR_1_3_2,  KR_1_3_3,  KR_1_3_4,  KR_1_3_5,  _______,    _______,  KR_1_3_6,  KR_1_3_7,  KR_1_3_8,  KR_1_3_9,  KR_1_3_10,  _______,
        RGB_VAD, _______,   _______,   _______,  KR_1_4_2,  KR_1_4_3,                         KR_1_4_4,  KR_1_4_5,  _______,   _______,    _______,    _______,
        _______, _______,   _______,   _______,   _______,   _______,                         _______,   _______,   _______,   _______,   _______,    _______,
                                                  KC_TRNS, KC_TRNS, KC_TRNS,    KC_TRNS, KC_TRNS, KC_TRNS
    ),

    [2] = LAYOUT_moonlander(
        _______, KR_2_1_1,  KR_2_1_2,  KR_2_1_3,  KR_2_1_4,  KR_2_1_5,  _______,    _______,  KR_2_1_6,  KR_2_1_7,  KR_2_1_8,  KR_2_1_9,  KR_2_1_10,  _______,
        _______, KR_2_2_1,  KR_2_2_2,  KR_2_2_3,  KR_2_2_4,  KR_2_2_5,  _______,    _______,  KR_2_2_6,  KR_2_2_7,  KR_2_2_8,  KR_2_2_9,  KR_2_2_10,  _______,
        _______, KR_2_3_1,  KR_2_3_2,  KR_2_3_3,  KR_2_3_4,  KR_2_3_5,  _______,    _______,  KR_2_3_6,  KR_2_3_7,  KR_2_3_8,  KR_2_3_9,  KR_2_3_10,  _______,
        _______, _______,   _______,   _______,  KR_2_4_2,  KR_2_4_3,                         KR_2_4_4,  KR_2_4_5,  _______,   _______,    _______,    _______,
        _______, _______,   _______,   _______,   _______,   _______,                         _______,   _______,   _______,   _______,   _______,    _______,
                                                  KC_TRNS, KC_TRNS, KC_TRNS,    KC_TRNS, KC_TRNS, KC_TRNS
    ),
    
    [3] = LAYOUT_moonlander(
        _______, KR_3_1_1,  KR_3_1_2,  KR_3_1_3,  KR_3_1_4,  KR_3_1_5,  _______,    _______,  KR_3_1_6,  KR_3_1_7,  KR_3_1_8,  KR_3_1_9,  KR_3_1_10,  _______,
        _______, KR_3_2_1,  KR_3_2_2,  KR_3_2_3,  KR_3_2_4,  KR_3_2_5,  _______,    _______,  KR_3_2_6,  KR_3_2_7,  KR_3_2_8,  KR_3_2_9,  KR_3_2_10,  _______,
        _______, KR_3_3_1,  KR_3_3_2,  KR_3_3_3,  KR_3_3_4,  KR_3_3_5,  _______,    _______,  KR_3_3_6,  KR_3_3_7,  KR_3_3_8,  KR_3_3_9,  KR_3_3_10,  KR_3_3_11,
        _______, _______,   _______,   _______,  KR_3_4_2,  KR_3_4_3,                         KR_3_4_4,  KR_3_4_5,  _______,   _______,    _______,    _______,
        _______, _______,   _______,   _______,   _______,   _______,                         _______,   _______,   _______,   _______,   _______,    _______,
                                                  KC_TRNS, KC_TRNS, KC_TRNS,    KC_TRNS, KC_TRNS, KC_TRNS
    ),
        
    [4] = LAYOUT_moonlander(
        _______, KR_4_1_1,  KR_4_1_2,  KR_4_1_3,  KR_4_1_4,  KR_4_1_5,  _______,    _______,  KR_4_1_6,  KR_4_1_7,  KR_4_1_8,  KR_4_1_9,  KR_4_1_10,  _______,
        _______, KR_4_2_1,  KR_4_2_2,  KR_4_2_3,  KR_4_2_4,  KR_4_2_5,  _______,    _______,  KR_4_2_6,  KR_4_2_7,  KR_4_2_8,  KR_4_2_9,  KR_4_2_10,  _______,
        _______, KR_4_3_1,  KR_4_3_2,  KR_4_3_3,  KR_4_3_4,  KR_4_3_5,  _______,    _______,  KR_4_3_6,  KR_4_3_7,  KR_4_3_8,  KR_4_3_9,  KR_4_3_10,  KR_4_3_11,
        _______, _______,   _______,   _______,  KR_4_4_2,  KR_4_4_3,                         KR_4_4_4,  KR_4_4_5,  _______,   _______,    _______,    _______,
        _______, _______,   _______,   _______,   _______,   _______,                         _______,   _______,   _______,   _______,   _______,    _______,
                                                  KC_TRNS, KC_TRNS, KC_TRNS,    KC_TRNS, KC_TRNS, KC_TRNS
    )
};