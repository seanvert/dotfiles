#!/usr/bin/env bash

if [[ $(tmux list-sessions | grep "scratchpad") ]]
then
    tmux attach-session -t "scratchpad"
else
    tmux new-session -s "scratchpad" -n "scratchpad" -c "$HOME"
fi
