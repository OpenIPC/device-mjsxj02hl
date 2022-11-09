#!/bin/sh
#
# Reset button for Xiaomi MJSXJ02HL

duration=3
msleep=100

show_help() {
    echo "Usage: $0 [-d value] [-i value] [-h]
    -d value   Duration of pressing the button in seconds (default = ${duration}).
    -i value   Polling interval in milliseconds (default = ${msleep}).
    -h         Show this help."
    exit 0
}

while getopts d:h flag; do
    case ${flag} in
        d) duration=${OPTARG} ;;
        i) msleep=${OPTARG} ;;
        h | *) show_help ;;
    esac
done

if [ ! -d /sys/class/gpio/gpio0/ ]; then
    echo 0 > /sys/class/gpio/export
    echo in > /sys/class/gpio/gpio0/direction
fi

pressed=0
while true; do
    if [ $(cat /sys/class/gpio/gpio0/value) -eq 0 ]; then
        if [ $pressed -eq 0 ]; then
            echo "Reset button pressed"
        fi
        if [ $pressed -ge $((duration*1000)) ]; then
            echo "Let's start erasing the rootfs_data (/dev/mtd4) partition"
            /etc/init.d/S96autonight stop
            /etc/init.d/S00autoled stop
            killall majestic
            /usr/sbin/led_control.sh -o 1 -b 1
            flash_eraseall -j /dev/mtd4
            reboot
            exit 0
        fi
        pressed=$((pressed+msleep))
    elif [ $pressed -gt 0 ]; then
        echo "Reset button released"
        pressed=0
    fi
    usleep $((msleep*1000))
done
