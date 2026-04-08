#!/bin/bash

SHADER_DIR="$HOME/.config/picom/shaders"
THEME_CACHE="$HOME/.cache/theme.hex"

# Mapeamento: ["Nome"]="/caminho/do/shader.glsl|Cor_Fundo|Cor_Topo"
declare -A THEMES=(
    ["normal"]="normal.glsl|#000000|#ffffff"
    ["grayscale — foco, menos estímulo"]="grayscale.glsl|#1a1a1a|#e0e0e0"
    ["alto contraste — alerta"]="alto-contraste.glsl|#000000|#ffffff"
    ["sepia — tons quentes, menos azul"]="sepia.glsl|#2b1d0e|#ffecb3"
    ["invert — leitura noturna"]="invert.glsl|#ffffff|#000000"
    ["dim — escurece 40%"]="dim.glsl|#000000|#999999"
    ["red night — preserva melatonina"]="red-night.glsl|#200000|#ff4444"
    ["deep work — foco azul, lógica"]="deep-work.glsl|#001122|#44ccff"
    ["relax — verde sálvia, anti-estresse"]="relax.glsl|#1e261e|#a8c0a8"
    ["equilibrium — foco equilibrado"]="equilibrium.glsl|#1f1f1f|#cccccc"
    ["indigo — introspecção e calma"]="indigo.glsl|#0d0b1a|#8a8aff"
    ["forest — estabilidade e aprendizado"]="forest.glsl|#051205|#4ade4a"
    ["golden — criatividade e bem-estar"]="golden.glsl|#1a1505|#ffcc33"
    ["magenta — quebra de padrão e insights"]="magenta.glsl|#1a0515|#ff33cc"
    ["solarized — conforto visual extremo"]="solarized.glsl|#002b36|#839496"
)

# Seletor Rofi
choice=$(printf '%s\n' "${!THEMES[@]}" | sort | rofi -dmenu -i -p "vibe")

[ -z "$choice" ] && exit 0

# Extração dos dados (usando IFS para separar os campos do pipe |)
IFS='|' read -r shader color_bg color_fg <<< "${THEMES[$choice]}"

# 1. Salva as cores no cache para o ImageMagick/Variety
echo -e "$color_bg\n$color_fg" > "$THEME_CACHE"

# 2. Reinicia o Picom com o novo Shader
pkill picom
sleep 0.2
picom --backend glx --window-shader-fg "$SHADER_DIR/$shader" &

# 3. Força o Variety a "repintar" o wallpaper atual com a nova cor
# variety --current chama o script set_wallpaper de novo
variety --current
