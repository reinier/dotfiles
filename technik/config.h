#pragma once

// number of taps for TT Tap-Toggle keys to toggle
#ifdef TAPPING_TOGGLE
#undef TAPPING_TOGGLE
#endif
#define TAPPING_TOGGLE 1

#define TAPPING_TERM 200

#define PERMISSIVE_HOLD

#define IGNORE_MOD_TAP_INTERRUPT

#define MK_KINETIC_SPEED 
#define MOUSEKEY_DELAY 8
#define MOUSEKEY_INTERVAL 8
#define MOUSEKEY_MOVE_DELTA 2
#define MOUSEKEY_INITIAL_SPEED 2
#define MOUSEKEY_DECELERATED_SPEED 100
#define MOUSEKEY_MAX_SPEED 14

#define USB_MAX_POWER_CONSUMPTION 500

#ifdef RGB_MATRIX_MAXIMUM_BRIGHTNESS
#undef RGB_MATRIX_MAXIMUM_BRIGHTNESS
#endif
#define RGB_MATRIX_MAXIMUM_BRIGHTNESS 30