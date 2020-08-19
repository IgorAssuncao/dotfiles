#!/bin/sh
nvidia-settings --load-config-only

pkill pulseaudio && \
  dbus-launch &
