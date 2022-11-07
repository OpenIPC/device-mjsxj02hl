#!/bin/sh
#
# Automatic LED control for Xiaomi MJSXJ02HL

processName="majestic"
pollingInterval=1

show_help() {
    echo "Usage: $0 [-p process] [-i value] [-h]
    -p process   Name of the monitored process (default = ${processName}).
    -i value     Polling interval in seconds (default = ${pollingInterval}).
    -h           Show this help."
    exit 0
}

# override config values with command line arguments
while getopts H:L:i:h flag; do
    case ${flag} in
        p) processName=${OPTARG} ;;
        i) pollingInterval=${OPTARG} ;;
        h | *) show_help ;;
    esac
done

echo "...................."
echo "Name of the monitored process: ${processName}"
echo "Polling interval: ${pollingInterval} sec"
echo "...................."

led_state=0
/usr/sbin/led_control.sh -o 0 -b 0
echo "...................."

while true; do
    if [ $led_state -ne 1 ] && ! killall -q -0 $processName; then
        echo "Process $processName is not running, turn on the orange LED"
        /usr/sbin/led_control.sh -o 1 -b 0
        led_state=1
        echo "...................."
    elif [ $led_state -ne 2 ] && killall -q -0 $processName; then
        echo "Process $processName is running, turn on the blue LED"
        /usr/sbin/led_control.sh -o 0 -b 1
        led_state=2
        echo "...................."
    fi
    sleep $pollingInterval
done
