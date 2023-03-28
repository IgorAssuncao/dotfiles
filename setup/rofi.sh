#!/bin/bash
# source $HOME/system-config/setup/utils.sh

rofi_exists() {
  which rofi
  which_rofi_status=$?
  echo $which_rofi_status
  return $which_rofi_status
}

install_rofi() {
  distro=$(cat /etc/os-release | grep -e "^ID=" | awk -F '=' '{ print $NF }')
  if [[ $distro == "ubuntu" ]]; then
    sudo apt install -y rofi
  fi
  if [[ $distro == "manjaro" || $distro == "arch" ]]; then
    sudo pacman -S rofi
  fi
  if [[ $disto == "void" ]]; then
    sudo xbps-install rofi
  fi
}

if [[ rofi_exists -eq 0 ]]; then
  echo """Rofi already exists.
Nothing to do."""
  exit 1
fi

install_rofi
