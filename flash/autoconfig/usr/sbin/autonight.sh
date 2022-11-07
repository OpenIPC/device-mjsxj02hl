#!/bin/sh
#
# Majestic settinfs for Xiaomi MJSXJ02HL
#
# nightMode:
#   enabled: true
#   irCutPin1: 70
#   irCutPin2: 68
#   backlightPin: 54

login=$(cat /etc/httpd.conf | grep cgi-bin | cut -d':' -f2)
pass=$(cat /etc/httpd.conf | grep cgi-bin | cut -d':' -f3)
again_high_target=14000
again_low_target=2000
pollingInterval=4
night_state=0
again_night_on=0
again_night_off=0

show_help() {
    echo "Usage: $0 [-H value] [-L value] [-i value] [-h]
    -H value   Again high target (default = ${again_high_target}).
    -L value   Again low target (default = ${again_low_target}).
    -i value   Polling interval (default = ${pollingInterval}).
    -h         Show this help."
    exit 0
}

night_on() {
    curl -u $login:$pass http://localhost/night/on && \
    night_state=1 && \
    echo LIGHT IS ON
}

night_off() {
    curl curl -u $login:$pass http://localhost/night/off && \
    night_state=0 && \
    echo LIGHT IS OFF
}

main() {
    echo "...................."
    echo "Watching at isp_again > ${again_high_target} to enable night mode"
    echo "Watching at isp_again < ${again_low_target} to disable night mode"
    echo "Polling interval: ${pollingInterval} sec"
    echo "...................."

    sleep 10
    led_off

    while true; do

        [ $night_state == 1 ] && \
        again_night_on=$(curl -s http://localhost/metrics | awk '/^isp_again/ {print $2}') && \
        again_night_off=0 || \
        again_night_off=$(curl -s http://localhost/metrics | awk '/^isp_again/ {print $2}')

        echo "again_night_off: "$again_night_off
        echo "again_night_on: "$again_night_on

        if [ $again_night_off -gt $again_high_target ] || [ $again_night_on -gt $again_low_target ];then

            [ $night_state == 0 ] && \
            night_on || \
            echo "Night mode is already enabled. Nothing changed. Continue"

        else

            [ $night_state == 1 ] && \
            night_off || \
            echo "Night mode is already disabled. Nothing changed. Continue"
        fi

        sleep ${pollingInterval}
        echo "...................."
    done
}

# override config values with command line arguments
while getopts H:L:i:h flag; do
    case ${flag} in
        H) again_high_target=${OPTARG} ;;
        L) again_low_target=${OPTARG} ;;
        i) pollingInterval=${OPTARG} ;;
        h | *) show_help ;;
    esac
done

main
