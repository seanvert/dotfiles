#!/usr/bin/env bash

if [[ $(pgrep 'compton') ]]
then
    pkill "compton" && \
        notify-send "Compton" "Disabled"
else
    compton -b --config "$HOME/.config/compton.conf" && \
        notify-send "Compton" "Enabled"
fi
