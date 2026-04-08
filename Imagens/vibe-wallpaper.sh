#!/usr/bin/env bash

# O Variety passa o caminho da imagem original no primeiro argumento ($1)
ORIGINAL_WP="$1"
# Onde vamos salvar a versão "Forest"
CUSTOM_WP="/tmp/current_vibe_wallpaper.jpg"
# Lendo as cores do arquivo
MAP_BLACK=$(sed -n '1p' ~/.cache/theme.hex)
MAP_GREEN=$(sed -n '2p' ~/.cache/theme.hex)
# O COMANDO MÁGICO:
# 1. Converte pra cinza (-colorspace gray)
# 2. Aplica contraste pesado (-sigmoidal-contrast 10,50%)
# 3. Multiplica por verde escuro para dar a saturação (+level-colors '#0a210a','#32cd32')
# magick "$ORIGINAL_WP" \
#     -colorspace gray \
#     -sigmoidal-contrast 10,50% \
#     +level-colors '#051205','#4ade4a' \
#     "$CUSTOM_WP"
magick "$1" -colorspace gray +level-colors "$MAP_BLACK","$MAP_GREEN" "$CUSTOM_WP"
# Define como wallpaper de verdade (Root Window)
feh --bg-fill "$CUSTOM_WP"
