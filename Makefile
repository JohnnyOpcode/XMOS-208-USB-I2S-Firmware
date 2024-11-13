# The TARGET variable determines what target system the application is
# compiled for. It either refers to an XN file in the source directories
# or a valid argument for the --target option when compiling.

TARGET = CAPSTONE_XU208.xn

# The APP_NAME variable determines the name of the final .xe file. It should
# not include the .xe postfix. If left blank the name will default to
# the project name

APP_NAME = Capstone_USB_Plus_Audio

# The flags passed to xcc when building the application
# The EXTRA_BUILD_FLAGS variable can be used on the xmake command line to add options

BUILD_FLAGS =   -DFLASH_MAX_UPGRADE_SIZE=64*1024 \
                -fcomment-asm \
                -Xmapper \
                --map \
                -Xmapper MAPFILE \
                -Wall \
                -O3 \
                -report \
                -lquadflash \
                -fsubword-select \
                -save-temps \
                -g \
                -fxscope \
                -DXSCOPE \
                -DSDA_HIGH=2 \
                -DSCL_HIGH=1 \
                -DXUD_SERIES_SUPPORT=4 \
                -march=xs2a \
                -DUSB_TILE=tile[0] \
                -DADAT_TX_USE_SHARED_BUFF=1 \
                -DU208_ONLY

# The USED_MODULES variable lists other module used by the application. These
# modules will extend the SOURCE_DIRS, INCLUDE_DIRS and LIB_DIRS variables.
# Modules are expected to be in the directory above the BASE_DIR directory.

USED_MODULES =  module_adat_rx \
                module_adat_tx \
                module_dfu \
                module_i2c_shared \
                module_i2c_single_port \
                module_spdif_rx \
                module_spdif_tx \
                module_usb_audio \
                module_usb_device \
                module_usb_midi \
                module_usb_shared \
                module_xud

# Build config naming scheme:

# Audio Class:  1 or 2
# Sync Mode             A(sync), S(ync) or (a)D(aptive)
# I2S                   M(aster), S(lave) or X (I2S disabled)
# Input                 enabled: i (channelcount)
# Output                enabled: o (channelcount)
# MIDI                  enabled: m, disabled: x
# S/PDIF in             enabled: s, disabled: x
# S/PDIF out            enabled: s, disabled: x
# ADAT in               enabled: a, disabled: x
# ADAT out              enabled: a, disabled: x
# DSD out               enabled: d, disabled: x
#
# e.g. 2AMi10o10xsxxx: Audio class 2.0, Asynchronous, I2S Master,input and output enabled (10 channels each), no MIDI, S/PDIF output, no S/PDIF input, no ADAT

# Test build configs (Note these make use of the defaults in customdefines.h)
XCC_FLAGS = $(BUILD_FLAGS)  -DI2S_CHANS_DAC=2 \
                            -DI2S_CHANS_ADC=0 \
                            -DNUM_USB_CHAN_OUT=2 \
                            -DNUM_USB_CHAN_IN=0 \
                            -DMIDI=0 \
                            -DSPDIF_TX=1 \
                            -DSPDIF_RX=0 \
                            -DADAT_TX=0 \
                            -DADAT_RX=0 \
                            -DDSD_CHANS_DAC=2 \
                            -DMAX_FREQ=192000

ifeq ($(TEST_CONFIGS),1)
XCC_FLAGS_upgrade1 = $(BUILD_FLAGS) -DBCD_DEVICE_J=0x99 -DBCD_DEVICE_M=0x0 -DBCD_DEVICE_N=0x1
XCC_FLAGS_upgrade2 = $(BUILD_FLAGS) -DBCD_DEVICE_J=0x99 -DBCD_DEVICE_M=0x0 -DBCD_DEVICE_N=0x2
endif

MODULE_LIBRARIES = xud_x200

#=============================================================================
#=============================================================================
# The following part of the Makefile includes the common build infrastructure
# for compiling XMOS applications. You should not need to edit below here.
XMOS_MAKE_PATH ?= ../..
ifneq ($(wildcard $(XMOS_MAKE_PATH)/xcommon/module_xcommon/build/Makefile.common),)
include $(XMOS_MAKE_PATH)/xcommon/module_xcommon/build/Makefile.common
else
include ../module_xcommon/build/Makefile.common
end