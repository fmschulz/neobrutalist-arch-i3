#!/bin/bash

# Find touchpad
TOUCHPAD=$(xinput list | grep "04F3:30C5 Mouse" | awk -F'id=' '{print $2}' | awk '{print $1}')

if [ -n "$TOUCHPAD" ]; then
    # Basic settings that should work
    xinput set-prop $TOUCHPAD "libinput Accel Speed" -0.5 2>/dev/null
    
    # Try to enable click methods
    xinput set-prop $TOUCHPAD "libinput Click Method Enabled" 1 1 2>/dev/null
    
    # Button mapping
    xinput set-button-map $TOUCHPAD 1 2 3 2>/dev/null
    
    echo "Applied touchpad fixes to device $TOUCHPAD"
else
    echo "Touchpad not found"
fi
