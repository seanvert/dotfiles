#!/bin/bash

SHADER_DIR="$HOME/.config/picom/shaders"

declare -A SHADERS=(
    ["normal"]="normal.glsl"
    ["grayscale — foco, menos estímulo"]="grayscale.glsl"
    ["alto contraste — alerta"]="alto-contraste.glsl"
    ["sepia — tons quentes, menos azul"]="sepia.glsl"
    ["invert — leitura noturna"]="invert.glsl"
    ["dim — escurece 40%"]="dim.glsl"
    ["red night — preserva melatonina"]="red-night.glsl"
    ["deep work — foco azul, lógica"]="deep-work.glsl"
    ["relax — verde sálvia, anti-estresse"]="relax.glsl"
    ["equilibrium — foco equilibrado"]="equilibrium.glsl"
    ["indigo — introspecção e calma"]="indigo.glsl"
    ["forest — estabilidade e aprendizado"]="forest.glsl"
    ["golden — criatividade e bem-estar"]="golden.glsl"
    ["magenta — quebra de padrão e insights"]="magenta.glsl"
    ["solarized — conforto visual extremo"]="solarized.glsl"
)

choice=$(printf '%s\n' "${!SHADERS[@]}" | sort | rofi -dmenu -p "shader")

[ -z "$choice" ] && exit 0

pkill picom
sleep 0.2
picom --backend glx --window-shader-fg "$SHADER_DIR/${SHADERS[$choice]}" &
