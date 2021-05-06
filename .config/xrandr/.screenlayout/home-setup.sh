#!/bin/sh

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
  xrandr --addmode DP-4 $mode_samsung
  xrandr --addmode HDMI-0 $mode_lg
}

setupXrandr() {
  xrandr \
    --output DP-0 --off \
    --output DP-1 --off \
    --output DP-2 --off \
    --output DP-3 --off \
    --output HDMI-0 --mode 2560x1080 --rate 74.99 --pos 0x420 --rotate normal \
    --output DP-4 --primary --mode 1920x1080 --rate 143.98 --pos 2560x0 --rotate right \
    --output DP-5 --off
}

adjustBrightness() {
  outputs=$(xrandr -q | grep -E '(\sconnected\s)' | cut -d ' ' -f1)
  for output in $outputs; do
    echo $output
    xrandr --output $output --brightness 0.5
  done
}

# createCustomModes
# addModesIntoOutputs
setupXrandr
adjustBrightness
