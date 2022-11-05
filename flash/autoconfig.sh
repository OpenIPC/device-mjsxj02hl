#!/bin/sh
#
# Cleaning of the settings partition
#
flash_eraseall -j /dev/mtd4
reboot
