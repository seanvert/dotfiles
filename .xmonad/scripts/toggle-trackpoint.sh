#!/usr/bin/env bash

ID=$(xinput list | grep -Eo 'TrackPoint\s*id\=[0-9]{1,2}' | grep -Eo '[0-9]{1,2}')
STATE=$(xinput list-props "$ID" | grep 'Device Enabled' | awk '{print $4}')

if [ "$STATE" -eq 1 ]
then
    xinput disable "$ID" && \
        notify-send "TrackPoint" "Disabled"
else
    xinput enable "$ID" && \
        notify-send "TrackPoint" "Enabled"
fi
