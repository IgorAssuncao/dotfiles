#!/bin/sh
xrandr \
  --output DP-0 --off \
  --output DP-1 --off \
  --output DP-2 --off \
  --output DP-3 --off \
  --output HDMI-0 --mode 2560x1080 --rate 74.99 --pos 0x0 --rotate normal \
  --output DP-4 --primary --mode 1920x1080 --rate 143.98 --pos 2560x0 --rotate normal \
  --output DP-5 --off
