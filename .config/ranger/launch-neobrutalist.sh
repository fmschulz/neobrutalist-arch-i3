#!/bin/bash
# Launch ranger with neobrutalist theme optimizations

# Set environment variables for better contrast
export TERM=xterm-256color

# Launch alacritty with specific settings for ranger
alacritty \
    --option font.size=14 \
    --option font.normal.style=Bold \
    --option colors.primary.background='#000000' \
    --option colors.primary.foreground='#ffffff' \
    --option window.padding.x=15 \
    --option window.padding.y=15 \
    --title "Ranger - Neobrutalist File Manager" \
    -e ranger "$@"