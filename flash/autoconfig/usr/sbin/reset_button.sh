#!/bin/sh
#
# Reset button for Xiaomi MJSXJ02HL

if [ ! -d /sys/class/gpio/gpio0/ ]; then
    echo 0 > /sys/class/gpio/export
    echo in > /sys/class/gpio/gpio0/direction
fi

if [ $(cat /sys/class/gpio/gpio0/value) -eq 0 ]; then
    # Wipe overlay partition and reboot
    echo "Let's start wipe overlay partition (/dev/mtd4)"
    /usr/sbin/sysupgrade -n -z
fi
