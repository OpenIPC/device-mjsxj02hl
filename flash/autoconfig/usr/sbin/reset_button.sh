#!/bin/sh
#
# Reset button for Xiaomi MJSXJ02HL

if [ $(cat /sys/class/gpio/gpio0/value) -eq 0 ]; then
    # Wipe overlay partition and reboot
    echo "Let's start wipe overlay partition (/dev/mtd4)"
    /usr/sbin/sysupgrade -n -z
fi
