#!/usr/bin/env bash

if [[ $(pgrep 'redshift') ]]
then
    pkill "redshift" && \
        notify-send "Redshift" "Disabled"
else
    redshift -c "$HOME/.config/redshift.conf" &
    disown redshift && \
        notify-send "Redshift" "Enabled"
fi
