#!/bin/sh
#
# Reset button for Xiaomi MJSXJ02HL

if [ $(cat /sys/class/gpio/gpio0/value) -eq 0 ]; then
    /etc/init.d/S96autonight stop
    /etc/init.d/S00autoled stop
    killall majestic
    /usr/sbin/led_control.sh -o 1 -b 1
    echo "Let's start erasing the rootfs_data (/dev/mtd4) partition"
    flash_eraseall -j /dev/mtd4
    reboot
fi
