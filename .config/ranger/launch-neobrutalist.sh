#!/bin/bash
# Launch ranger with neobrutalist theme optimizations

# Set environment variables for better contrast
export TERM=xterm-256color

# Launch alacritty with dedicated ranger config
alacritty \
    --config-file ~/.config/alacritty/ranger.yml \
    -e ranger "$@"