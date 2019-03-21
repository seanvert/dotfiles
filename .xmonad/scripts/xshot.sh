#!/usr/bin/env bash

PIC="${HOME}/pictures/screenshots/$(date +%Y-%m-%d_%H-%M-%S).png"

maim --format=png --hidecursor --quality 8 "${PIC}" && \
    notify-send "xshot" "Screenshot captured to ${PIC}"
