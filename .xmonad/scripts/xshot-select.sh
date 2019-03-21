#!/usr/bin/env bash

PIC="${HOME}/pictures/screenshots/$(date +%Y-%m-%d_%H-%M-%S).png"

maim --format=png --hidecursor --quality 8 --select "${PIC}" && \
    notify-send "xhost" "Screenshot captures to ${PIC}"
