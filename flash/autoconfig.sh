#!/bin/sh
#
# Cleaning of the settings partition
#
$(dirname $0)/autoconfig/usr/sbin/led_control.sh -o 1 -b 1
flash_eraseall -j /dev/mtd4
reboot
