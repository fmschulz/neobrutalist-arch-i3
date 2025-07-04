#!/bin/bash

# Find touchpad device
TOUCHPAD=$(xinput list | grep -i touchpad | awk -F'id=' '{print $2}' | awk '{print $1}' | head -1)

if [ -z "$TOUCHPAD" ]; then
    echo "No touchpad found!"
    exit 1
fi

echo "Configuring touchpad (ID: $TOUCHPAD)..."

# Enable two-finger scrolling
xinput set-prop $TOUCHPAD "libinput Scroll Method Enabled" 0 1 0

# Natural scrolling (like ChromeOS)
xinput set-prop $TOUCHPAD "libinput Natural Scrolling Enabled" 1

# Enable tap to click
xinput set-prop $TOUCHPAD "libinput Tapping Enabled" 1

# Enable tap-and-drag
xinput set-prop $TOUCHPAD "libinput Tapping Drag Enabled" 1

# Disable tap-and-drag lock
xinput set-prop $TOUCHPAD "libinput Tapping Drag Lock Enabled" 0

# Set acceleration
xinput set-prop $TOUCHPAD "libinput Accel Speed" 0.4

# Enable horizontal scrolling
xinput set-prop $TOUCHPAD "libinput Horizontal Scroll Enabled" 1

# Disable while typing
xinput set-prop $TOUCHPAD "libinput Disable While Typing Enabled" 1

# Click method (use clickfinger)
xinput set-prop $TOUCHPAD "libinput Click Method Enabled" 0 1

echo "Touchpad configured successfully!"

# Show current settings
echo -e "\nCurrent settings:"
xinput list-props $TOUCHPAD | grep -E "(Scroll|Natural|Tapping|Accel)"
