#!/usr/bin/env bash

status="$(fcitx-remote)"
set out

if   [[ "$status" = 0 ]]
then
    out="Off"
elif [[ "$status" = 1 ]]
then
    out="Disabled"
else 
    out="Enabled"
fi

echo -e "$out"
