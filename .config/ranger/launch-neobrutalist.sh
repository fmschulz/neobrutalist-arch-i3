#!/bin/bash
# Launch ranger with neobrutalist theme optimizations

# Set environment variables for better contrast
export TERM=xterm-256color

# Launch alacritty with specific settings for ranger
alacritty \
    --option font.size=20 \
    --option font.normal.family="JetBrains Mono" \
    --option font.normal.style="ExtraBold" \
    --option colors.primary.foreground='#ffffff' \
    --option window.padding.x=20 \
    --option window.padding.y=20 \
    --title "Ranger - Neobrutalist File Manager" \
    -e ranger "$@"