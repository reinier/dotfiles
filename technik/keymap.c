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
// #include "raw_hid.h"
// 
// static uint8_t	resp = 1;
// 
// layer_state_t layer_state_set_user(layer_state_t state) {
//   switch (get_highest_layer(state)) {
//     case 1:
//         raw_hid_send((uint8_t *)&resp, sizeof(resp));
//         break;
//     case 2:
//         raw_hid_send((uint8_t *)&resp, sizeof(resp));
//         break;
//     case 3:
//         raw_hid_send((uint8_t *)&resp, sizeof(resp));
//         break; 
//     case 4:
//         raw_hid_send((uint8_t *)&resp, sizeof(resp));
//         break;   
//     default:
//         //print("reinier");
//         raw_hid_send((uint8_t *)&resp, sizeof(resp));
//         break;  
//   }
//   return state;
// }

// void rgb_matrix_indicators_advanced_user(uint8_t led_min, uint8_t led_max) {
//     // for (uint8_t i = led_min; i <= led_max; i++) {
//         switch(get_highest_layer(layer_state|default_layer_state)) {
//             case 0:
//                 //rgb_matrix_set_color(i, RGB_BLUE);
//                 rgb_matrix_sethsv(1, 1, 1);
//                 break;
//             case 1:
//             case 2:
//             case 3:
//             case 4:
//                 //rgb_matrix_set_color(i, RGB_YELLOW);
//                 rgb_matrix_sethsv(5, 5, 5);
//                 break;
//             default:
//                 break;
//         }
//     // }
// }

const uint16_t PROGMEM keymaps[][MATRIX_ROWS][MATRIX_COLS] = {

  [0] = LAYOUT_ortho_4x12(
    KR_0_1_1,  KR_0_1_2,  KR_0_1_3,  KR_0_1_4,  KR_0_1_5,  RGB_M_P,        _______,   KR_0_1_6,  KR_0_1_7,  KR_0_1_8,  KR_0_1_9,  KR_0_1_10,
    KR_0_2_1,  KR_0_2_2,  KR_0_2_3,  KR_0_2_4,  KR_0_2_5,  _______,        _______,   KR_0_2_6,  KR_0_2_7,  KR_0_2_8,  KR_0_2_9,  KR_0_2_10,
    KR_0_3_1,  KR_0_3_2,  KR_0_3_3,  KR_0_3_4,  KR_0_3_5,  _______,        _______,   KR_0_3_6,  KR_0_3_7,  KR_0_3_8,  KR_0_3_9,  KR_0_3_10,
    RGB_TOG,   RGB_MOD,   _______,   KR_0_4_1,  KR_0_4_2,  KR_0_4_2,       KR_0_4_3,  KR_0_4_3,  KR_0_4_4,  _______,   RGB_VAI,   RGB_HUI
  ),

  [1] = LAYOUT_ortho_4x12(
    KR_1_1_1,  KR_1_1_2,  KR_1_1_3,  KR_1_1_4,  KR_1_1_5,  _______,        _______,   KR_1_1_6,  KR_1_1_7,  KR_1_1_8,  KR_1_1_9,  KR_1_1_10,
    KR_1_2_1,  KR_1_2_2,  KR_1_2_3,  KR_1_2_4,  KR_1_2_5,  _______,        _______,   KR_1_2_6,  KR_1_2_7,  KR_1_2_8,  KR_1_2_9,  KR_1_2_10,
    KR_1_3_1,  KR_1_3_2,  KR_1_3_3,  KR_1_3_4,  KR_1_3_5,  _______,        _______,   KR_1_3_6,  KR_1_3_7,  KR_1_3_8,  KR_1_3_9,  KR_1_3_10,
    _______,   _______,   _______,   KR_1_4_1,  KR_1_4_2,  KR_1_4_2,       KR_1_4_3,  KR_1_4_3,  KR_1_4_4,  _______,   _______,   _______
  ),

  [2] = LAYOUT_ortho_4x12(
    KR_2_1_1,  KR_2_1_2,  KR_2_1_3,  KR_2_1_4,  KR_2_1_5,  _______,        _______,   KR_2_1_6,  KR_2_1_7,  KR_2_1_8,  KR_2_1_9,  KR_2_1_10,
    KR_2_2_1,  KR_2_2_2,  KR_2_2_3,  KR_2_2_4,  KR_2_2_5,  _______,        _______,   KR_2_2_6,  KR_2_2_7,  KR_2_2_8,  KR_2_2_9,  KR_2_2_10,
    KR_2_3_1,  KR_2_3_2,  KR_2_3_3,  KR_2_3_4,  KR_2_3_5,  _______,        _______,   KR_2_3_6,  KR_2_3_7,  KR_2_3_8,  KR_2_3_9,  KR_2_3_10,
    _______,   _______,   _______,   KR_2_4_1,  KR_2_4_2,  KR_2_4_2,       KR_2_4_3,  KR_2_4_3,  KR_2_4_4,  _______,   _______,   _______
  ),
  
  [3] = LAYOUT_ortho_4x12(
    KR_3_1_1,  KR_3_1_2,  KR_3_1_3,  KR_3_1_4,  KR_3_1_5,  _______,        _______,   KR_3_1_6,  KR_3_1_7,  KR_3_1_8,  KR_3_1_9,  KR_3_1_10,
    KR_3_2_1,  KR_3_2_2,  KR_3_2_3,  KR_3_2_4,  KR_3_2_5,  _______,        _______,   KR_3_2_6,  KR_3_2_7,  KR_3_2_8,  KR_3_2_9,  KR_3_2_10,
    KR_3_3_1,  KR_3_3_2,  KR_3_3_3,  KR_3_3_4,  KR_3_3_5,  _______,        _______,   KR_3_3_6,  KR_3_3_7,  KR_3_3_8,  KR_3_3_9,  KR_3_3_10,
    _______,   _______,   _______,   KR_3_4_1,  KR_3_4_2,  KR_3_4_2,       KR_3_4_3,  KR_3_4_3,  KR_3_4_4,  _______,   _______,   _______
  ),
  
  [4] = LAYOUT_ortho_4x12(
    KR_4_1_1,  KR_4_1_2,  KR_4_1_3,  KR_4_1_4,  KR_4_1_5,  _______,        _______,   KR_4_1_6,  KR_4_1_7,  KR_4_1_8,  KR_4_1_9,  KR_4_1_10,
    KR_4_2_1,  KR_4_2_2,  KR_4_2_3,  KR_4_2_4,  KR_4_2_5,  _______,        _______,   KR_4_2_6,  KR_4_2_7,  KR_4_2_8,  KR_4_2_9,  KR_4_2_10,
    KR_4_3_1,  KR_4_3_2,  KR_4_3_3,  KR_4_3_4,  KR_4_3_5,  _______,        _______,   KR_4_3_6,  KR_4_3_7,  KR_4_3_8,  KR_4_3_9,  KR_4_3_10,
    _______,   _______,   _______,   KR_4_4_1,  KR_4_4_2,  KR_4_4_2,       KR_4_4_3,  KR_4_4_3,  KR_4_4_4,  _______,   _______,   _______
  )
};

// This function creates packets of exactly RAW_EPSIZE to be broken down and sent via raw_hid_send()
// This is because raw_hid_send will do nothing if length != RAW_EPSIZE
// INFO: As far as I can tell, a packet starting with 0 will not transmit that first byte
// Somehow someway, by the time the packet gets to my linux python scripts, the first zero of the packet is missing...
// void raw_hid_send_pad(uint8_t *data, uint8_t length) {
//   // if the length is already correct, just send it quick and don't bother with the slower packet conversion
//   if (length == RAW_EPSIZE) {
//     raw_hid_send(data, RAW_EPSIZE);
//     return;
//   }
// 
//   uint8_t packet[RAW_EPSIZE];
//   uint8_t n = 0;
//   
//   while (n < length) {
//     for (uint8_t i = 0; i < RAW_EPSIZE; i++) {
//       packet[i] = i < length ? data[n] : 0;
//       n++;
//     }
//     raw_hid_send(packet, RAW_EPSIZE);
//   }
// }
