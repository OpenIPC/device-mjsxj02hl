#!/bin/sh
#
# First boot
#

# Set osmem (mmz memory = 64 - osmem)
fw_setenv osmem 35M

# Enable white LED
$(dirname $0)/autoconfig/usr/sbin/led_control.sh -o 1 -b 1

# Cleaning of the settings partition
flash_eraseall -j /dev/mtd4

# Reboot
reboot
