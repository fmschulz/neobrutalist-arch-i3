#!/bin/bash

# Find trackpad device
DEVICE=$(xinput list | grep -i touchpad | head -n1 | awk -F'id=' '{print $2}' | awk '{print $1}')

if [ -n "$DEVICE" ]; then
    # Enable two-finger scrolling
    xinput set-prop $DEVICE "libinput Scroll Method Enabled" 0 1 0
    
    # Natural scrolling (like ChromeOS)
    xinput set-prop $DEVICE "libinput Natural Scrolling Enabled" 1
    
    # Enable tapping
    xinput set-prop $DEVICE "libinput Tapping Enabled" 1
    
    # Set pointer speed
    xinput set-prop $DEVICE "libinput Accel Speed" 0.4
    
    echo "Trackpad configured!"
else
    echo "No trackpad found!"
fi
