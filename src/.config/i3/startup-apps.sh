#!/bin/bash
# ~/.config/i3/startup-apps.sh

# Wait for i3 to fully start
sleep 2

# Workspace 1: Two terminals side by side
i3-msg "workspace 1"
alacritty &
sleep 0.5
alacritty &
sleep 0.5
# Split the terminals horizontally
i3-msg "focus left"
i3-msg "split h"

# Workspace 2: Firefox
i3-msg "workspace 2"
firefox &

# Workspace 3: VS Code
i3-msg "workspace 3"
code &

# Return to workspace 1
sleep 1
i3-msg "workspace 1"
