#!/bin/bash
source $HOME/dotfiles/setup/utils.sh

rofi_exists() {
  which rofi
  which_rofi_status=$?
  return $which_rofi_status
}

install_rofi() {
  distro=$(cat /etc/os-release | grep -e "^ID=" | awk -F '=' '{ print $NF }')
  install_pkg rofi
}

if [[ rofi_exists -eq 0 ]]; then
  echo """Rofi already exists.
Nothing to do."""
  exit 1
fi

install_rofi
