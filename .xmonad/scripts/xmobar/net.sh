#!/usr/bin/env bash

dev_wireless=wlp3s0 
dev_eth=enp0s25 

eth="$(ip -o address | grep -i "$dev_eth *inet ")"
if [ -n "$eth" ]
then
    speed="$(cat /sys/class/net/$dev_eth/speed)"
    case $speed in
        10)
            speed="10Base-T"
            ;;
        100)
            speed="100Base-T"
            ;;
        1000)speed="Gigabit"
            ;;
        *)
            speed="UNKNOWN $speed"
            ;;
    esac
    eth_status=" <fn=1></fn>$speed"
fi

ssid="$(iw dev $dev_wireless link | grep -i SSID)"
if [ -n "$ssid" ]
then
    signal="$(iw dev wlp3s0 station dump | grep -E '[^ ]signal avg')"
    signal="${signal#*-}"
    signal="${signal%% *}"
    signal="$((2*(100-signal)))"
        
    if   ((signal < 20))
    then
        sigicon=""
    elif ((signal < 40))
    then
        sigicon=""
    elif ((signal < 60))
    then
        sigicon=""
    elif ((signal < 80))
    then
        sigicon=""
    else
        sigicon=""
    fi
    signal=$((signal/5*5))
    ((signal > 100)) && signal=100
    wireless_status="<fn=1>${sigicon}</fn>${ssid##*SSID: }"
fi

echo "$wireless_status$eth_status"
