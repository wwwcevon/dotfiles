#!/bin/bash

xset m 1 5
xset r rate 200 50

if [[ -n "$(command -v xinput)" ]]; then
    DEVICE_ID=$(xinput --list | grep 'Logitech USB Receiver' | grep -o 'id=[0-9]\+' | head -n 1 | sed 's;.*=;;g')
    if [[ -n $DEVICE_ID ]]; then
	xinput set-button-map $DEVICE_ID 1 2 3 4 5 6 7 8 9 10 11 12 3
    fi
fi
