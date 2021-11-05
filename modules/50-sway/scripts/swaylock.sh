#!/bin/sh

swayidle \
  timeout 10 'swaymsg "output * dpms off"' \
  resume 'swaymsg "output * dpms on"' &
swaylock

# Kill last background task to unblock idle timer
kill %%
