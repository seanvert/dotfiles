#!/usr/bin/env bash

if [[ $(/usr/bin/mpc | grep playing) ]]
then
    mpc --no-status pause
else
    mpc --no-status play
fi
