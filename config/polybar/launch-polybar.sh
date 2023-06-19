#!/usr/bin/env bash

for monitor in $(polybar -M | cut -d ':' -f 1); do
  MONITOR=$monitor polybar -r top &
  MONITOR=$monitor polybar -r bottom &
done

