#!/bin/sh
#
# First boot
#

# Set environments (mmz memory = 64 - osmem)
fw_setenv bootargs 'mem=${osmem} console=ttyAMA0,115200 panic=20 rootfstype=squashfs root=/dev/mtdblock3 init=/init mtdparts=${mtdparts} mmz_allocator=hisi'
fw_setenv osmem 35M

# Enable white LED
$(dirname $0)/autoconfig/usr/sbin/led_control.sh -o 1 -b 1

# Cleaning of the settings partition
flash_eraseall -j /dev/mtd4

# Reboot
reboot
