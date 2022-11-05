#!/bin/sh
#
# Cleaning of the settings partition
#
flash_eraseall -j /dev/mtd4
#
#
# Signaling that the device requires action on the SD card
#
for PIN in 52; do
    echo ${PIN} > /sys/class/gpio/export
    echo out > /sys/class/gpio/gpio${PIN}/direction
    echo 0 > /sys/class/gpio/gpio${PIN}/value
done
#
while true ; do echo 1 > /sys/class/gpio/gpio${PIN}/value; sleep 1; echo 0 > /sys/class/gpio/gpio${PIN}/value; sleep 1; done &
#
#
