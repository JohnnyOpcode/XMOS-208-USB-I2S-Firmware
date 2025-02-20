// Copyright (c) 2016, XMOS Ltd, All rights reserved
#ifndef _CUSTOMDEFINES_H_
#define _CUSTOMDEFINES_H_
// #include "user_main.h"
/*
 * Device configuration option defines to override default defines found devicedefines.h
 *
 * Build can be customised but changing and adding defines here
 *
 * Note, we check if they are already defined in Makefile
 */
/* Tile defines */
#define AUDIO_IO_TILE 0
#define XUD_TILE 0
#define SPDIF_TX_TILE 0
#define MIDI_TILE 0
/* Mixer core enabled by default */
#ifndef MIXER
#define MIXER 1
#endif
/* Mixing disabled by default */
#ifndef MAX_MIX_COUNT
#define MAX_MIX_COUNT 2
#endif
/* Board is self-powered i.e. not USB bus-powered */
#define SELF_POWERED 1
/* Enable/Disable MIDI - Default is MIDI off */
#ifndef MIDI
#define MIDI 0
#endif
/* Enable/Disable SPDIF output - Default is S/PDIF on */
#ifndef SPDIF_TX
#define SPDIF_TX 1
#endif
/* Defines relating to channel count and channel arrangement (Set to 0 for disable) */
//: audio_defs
/* Number of USB streaming channels - Default is 4 in 4 out */
#ifndef NUM_USB_CHAN_IN
#define NUM_USB_CHAN_IN (0) /* Device to Host */
#endif
#ifndef NUM_USB_CHAN_OUT
#define NUM_USB_CHAN_OUT (2) /* Host to Device */
#endif
/* Number of IS2 chans to DAC..*/
#ifndef I2S_CHANS_DAC
#define I2S_CHANS_DAC (2)
#endif
/* Number of I2S chans from ADC */
#ifndef I2S_CHANS_ADC
#define I2S_CHANS_ADC (0)
#endif
/* Number of DSD chans to DAC..*/
#ifndef DSD_CHANS_DAC
#define DSD_CHANS_DAC (2)
#endif
/* Channel index of SPDIF Rx channels (duplicated DAC channels 1/2 when index is 0) */
#define SPDIF_TX_INDEX (0)
/* Channel index of SPDIF Rx channels */
#define SPDIF_RX_INDEX (0)
/* Channel index of ADAT Tx channels */
#if defined(SPDIF_TX) && (SPDIF_TX == 1)
#define ADAT_TX_INDEX (SPDIF_TX_INDEX + 2)
#else
#define ADAT_TX_INDEX (I2S_CHANS_DAC)
#endif
/* Channel index of ADAT Rx channels */
#if defined(SPDIF_RX) && (SPDIF_RX == 1)
#define ADAT_RX_INDEX (SPDIF_RX_INDEX + 2)
#else
#define ADAT_RX_INDEX (I2S_CHANS_ADC)
#endif
/* Master clock defines (in Hz) */
#define MCLK_441 (512 * 44100) /* 44.1, 88.2 etc */
#define MCLK_48 (512 * 48000)  /* 48, 96 etc */
/* Maximum frequency device runs at */
#ifndef MAX_FREQ
#define MAX_FREQ (192000)
#endif
//:
/***** Defines relating to USB descriptors etc *****/
//: usb_defs
#define VENDOR_ID (0x20B1)   /* XMOS VID */
#define PID_AUDIO_2 (0x0008) /* SKC_SU1 USB Audio Reference Design PID */
#define PID_AUDIO_1 (0x0009) /* SKC_SU1 Audio Reference Design PID */
//:
/* Enable/Disable example HID code */
#ifndef HID_CONTROLS
#define HID_CONTROLS 1
#endif
#endif