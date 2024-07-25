#!/usr/bin/env bash

monitor=$(polybar -M | cut -d ':' -f 1)
workspaces_qtt=$(leftwm-state -q -n -s "{{ workspaces | size }}")

# TODO: Try to make polybars work in leftwm workspaces.
# for monitor in $(polybar -M | cut -d ':' -f 1); do
for i in $(seq 0 $(($workspaces_qtt - 1))); do
  # leftwm-state -q -n -s "{% for workspace in workspaces %} {{workspace.w}} {{workspace.x}} {% endfor %}" | sed -r '/^\s*$/d' | read -r width x
  width=$(leftwm-state -q -n -s "{% for workspace in workspaces %} {{workspace.w}} {% endfor %}" | sed -r '/^\s*$/d')
  x=$(leftwm-state -q -n -s "{% for workspace in workspaces %} {{workspace.x}} {% endfor %}" | sed -r '/^\s*$/d')
  y=$(leftwm-state -q -n -s "{% for workspace in workspaces %} {{workspace.y}} {% endfor %}" | sed -r '/^\s*$/d')
  # width=$(expr $width - 200)
  # width=$(($width - 0))
  # x=$(($x + 0))
  MONITOR=$monitor width=$width xoffset=$x yoffset=$y polybar -c $HOME/.config/polybar/polybar.config -r top &
  MONITOR=$monitor width=$width xoffset=$x yoffset=$y polybar -c $HOME/.config/polybar/polybar.config -r bottom &
done
