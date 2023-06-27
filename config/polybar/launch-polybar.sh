#!/usr/bin/env bash

for monitor in $(polybar -M | cut -d ':' -f 1); do
  # leftwm-state -q -n -s "{% for workspace in workspaces %} {{workspace.w}} {{workspace.x}} {% endfor %}" | sed -r '/^\s*$/d' | read -r width x
  width=$(leftwm-state -q -n -s "{% for workspace in workspaces %} {{workspace.w}} {% endfor %}" | sed -r '/^\s*$/d')
  x=$(leftwm-state -q -n -s "{% for workspace in workspaces %} {{workspace.x}} {% endfor %}" | sed -r '/^\s*$/d')
  # width=$(expr $width - 200)
  width=$(($width - 0))
  x=$(($x + 0))
  MONITOR=$monitor width=$width xoffset=$x polybar -r top &
  MONITOR=$monitor width=$width xoffset=$x polybar -r bottom &
done

