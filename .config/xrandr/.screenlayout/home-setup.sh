#!/bin/bash

# Horizontal x Vertical _ RefreshRate
# 2560x1080_73.99
# 1920x1080_143.98

export mode_lg="lg29"
export mode_samsung="samsung24"

createCustomMode1920_144Hz() {
  local mode=$(gtf 1920 1080 143.98 | sed -n 3p | sed -E 's/Modeline//gmi' | sed -E 's/(\"[0-9]+x[0-9]+\_[0-9]+\.[0-9]+\")//gmi')
  xrandr --newmode $mode_samsung $mode
}

createCustomMode2560_75Hz() {
  local mode=$(gtf 2560 1080 74.99 | sed -n 3p | sed -E 's/Modeline//gmi' | sed -E 's/(\"[0-9]+x[0-9]+\_[0-9]+\.[0-9]+\")//gmi')
  xrandr --newmode $mode_lg $mode
}

createCustomModes() {
  createCustomMode1920_144Hz
  createCustomMode2560_75Hz
}

addModesIntoOutputs() {
  xrandr --addmode DP-5 $mode_samsung
  xrandr --addmode HDMI-0 $mode_lg
}

setupMonitor() {
  if [ -z $1 ]; then
    echo """You're supposed to provide either \"v\" for vertical
        or \"h\" for horizontal."""
    return;
  fi

  if [[ $1 =~ "(h|v)" ]]; then
    setupMonitorsLayout $1
  fi
}

setupMonitorsLayout() {
  local hdmiPosition
  local dpPosition
  local hdmiRotation
  local dpRotation

  if [ $1 = "h" ]; then
    hdmiPosition="1920x0"
    hdmiRotation="normal"
    dpPosition="0x0"
    dpRotation="normal"
  fi

  if [ $1 = "v" ]; then
    hdmiPosition="1920x420"
    hdmiRotation="normal"
    dpPosition="0x0"
    dpRotation="right"
  fi

  xrandr \
    --output DP-0 --off \
    --output DP-1 --off \
    --output DP-2 --off \
    --output DP-3 --off \
    --output HDMI-0 --primary --mode 2560x1080 --rate 74.99 --pos $hdmiPosition --rotate $hdmiRotation \
    --output DP-4 --off \
    --output DP-5 --noprimary --mode 1920x1080 --rate 60 --pos $dpPosition --rotate $dpRotation
    # --output DP-5 --mode 1920x1080 --rate 143.98 --pos $dpPosition --rotate $dpRotation
}

adjustBrightness() {
  outputs=$(xrandr -q | grep -E '(\sconnected\s)' | cut -d ' ' -f1)
  for output in $outputs; do
    xrandr --output $output --brightness 1
  done
}

# createCustomModes
# addModesIntoOutputs
# adjustBrightness
# setupXrandr
