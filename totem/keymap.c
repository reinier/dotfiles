#include QMK_KEYBOARD_H
#include <stdio.h>
#include "totem.h"

/* Repeat key as described in: https://getreuer.info/posts/keyboards/repeat-key/ */
#include "features/repeat_key.h"
#include "microhacks.c"
#include "qweighteen.c"

#define KR_0_EXTRAL KC_TAB
#define KR_0_EXTRAR KC_ENTER 

const uint16_t PROGMEM keymaps[][MATRIX_ROWS][MATRIX_COLS] = {

   [0] = LAYOUT(
               KR_0_1_1,  KR_0_1_2,  KR_0_1_3,  KR_0_1_4,  KR_0_1_5,       KR_0_1_6,  KR_0_1_7,  KR_0_1_8,  KR_0_1_9,  KR_0_1_10,
               KR_0_2_1,  KR_0_2_2,  KR_0_2_3,  KR_0_2_4,  KR_0_2_5,       KR_0_2_6,  KR_0_2_7,  KR_0_2_8,  KR_0_2_9,  KR_0_2_10,
 KR_0_EXTRAL,  KR_0_3_1,  KR_0_3_2,  KR_0_3_3,  KR_0_3_4,  KR_0_3_5,       KR_0_3_6,  KR_0_3_7,  KR_0_3_8,  KR_0_3_9,  KR_0_3_10, KR_0_EXTRAR,
                                     KR_0_4_1,  KR_0_4_2, KR_0_4_3,        KR_0_4_4,  KR_0_4_5,  KR_0_4_6

     ),


   [1] = LAYOUT(
                KR_1_1_1,  KR_1_1_2,  KR_1_1_3,  KR_1_1_4,  KR_1_1_5,       KR_1_1_6,  KR_1_1_7,  KR_1_1_8,  KR_1_1_9,  KR_1_1_10,
                KR_1_2_1,  KR_1_2_2,  KR_1_2_3,  KR_1_2_4,  KR_1_2_5,       KR_1_2_6,  KR_1_2_7,  KR_1_2_8,  KR_1_2_9,  KR_1_2_10,
  KC_TRNS,  KR_1_3_1,  KR_1_3_2,  KR_1_3_3,  KR_1_3_4,  KR_1_3_5,       KR_1_3_6,  KR_1_3_7,  KR_1_3_8,  KR_1_3_9,  KR_1_3_10, KC_TRNS,
                                      KR_1_4_1,  KR_1_4_2, KR_1_4_3,        KR_1_4_4,  KR_1_4_5,  KR_1_4_6

      ),

   [2] = LAYOUT(
                 KR_2_1_1,  KR_2_1_2,  KR_2_1_3,  KR_2_1_4,  KR_2_1_5,       KR_2_1_6,  KR_2_1_7,  KR_2_1_8,  KR_2_1_9,  KR_2_1_10,
                 KR_2_2_1,  KR_2_2_2,  KR_2_2_3,  KR_2_2_4,  KR_2_2_5,       KR_2_2_6,  KR_2_2_7,  KR_2_2_8,  KR_2_2_9,  KR_2_2_10,
   KC_TRNS,  KR_2_3_1,  KR_2_3_2,  KR_2_3_3,  KR_2_3_4,  KR_2_3_5,       KR_2_3_6,  KR_2_3_7,  KR_2_3_8,  KR_2_3_9,  KR_2_3_10, KC_TRNS,
                                       KR_2_4_1,  KR_2_4_2, KR_2_4_3,        KR_2_4_4,  KR_2_4_5,  KR_2_4_6

       ),

   [3] = LAYOUT(
                  KR_3_1_1,  KR_3_1_2,  KR_3_1_3,  KR_3_1_4,  KR_3_1_5,       KR_3_1_6,  KR_3_1_7,  KR_3_1_8,  KR_3_1_9,  KR_3_1_10,
                  KR_3_2_1,  KR_3_2_2,  KR_3_2_3,  KR_3_2_4,  KR_3_2_5,       KR_3_2_6,  KR_3_2_7,  KR_3_2_8,  KR_3_2_9,  KR_3_2_10,
    KC_TRNS,  KR_3_3_1,  KR_3_3_2,  KR_3_3_3,  KR_3_3_4,  KR_3_3_5,       KR_3_3_6,  KR_3_3_7,  KR_3_3_8,  KR_3_3_9,  KR_3_3_10, KC_TRNS,
                                        KR_3_4_1,  KR_3_4_2, KR_3_4_3,        KR_3_4_4,  KR_3_4_5,  KR_3_4_6

        ),
    [4] = LAYOUT(
                KR_4_1_1,  KR_4_1_2,  KR_4_1_3,  KR_4_1_4,  KR_4_1_5,       KR_4_1_6,  KR_4_1_7,  KR_4_1_8,  KR_4_1_9,  KR_4_1_10,
                KR_4_2_1,  KR_4_2_2,  KR_4_2_3,  KR_4_2_4,  KR_4_2_5,       KR_4_2_6,  KR_4_2_7,  KR_4_2_8,  KR_4_2_9,  KR_4_2_10,
        KC_TRNS,  KR_4_3_1,  KR_4_3_2,  KR_4_3_3,  KR_4_3_4,  KR_4_3_5,       KR_4_3_6,  KR_4_3_7,  KR_4_3_8,  KR_4_3_9,  KR_4_3_10, KC_TRNS,
                          KR_4_4_1,  KR_4_4_2, KR_4_4_3,        KR_4_4_4,  KR_4_4_5,  KR_4_4_6
        
          )
};
