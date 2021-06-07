#!/bin/sh
nvidia-settings --load-config-only

pkill pulseaudio && \
  dbus-launch &

source ~/system-config/.config/scripts/startup.sh
source ~/system-config/.config/xrandr/.screenlayout/home-setup.sh
