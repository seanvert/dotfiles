#!/bin/bash

SHADER_DIR="$HOME/.config/picom/shaders"
STATE_FILE="/tmp/picom-shader-state"

if [ -f "$STATE_FILE" ]; then
    rm "$STATE_FILE"
    SHADER="$SHADER_DIR/default.glsl"
else
    touch "$STATE_FILE"
    SHADER="$SHADER_DIR/grayscale.glsl"
fi

pkill picom
picom --backend glx --window-shader-fg "$SHADER" &
