# source $HOME/system-config/setup/utils.sh

rofi_exists() {
  return [[ which rofi ]]
}

install_rofi() {
  if [[ rofi_exists ]]; then
    echo """Rofi already exists.
Nothing to do.
    """
  fi

  # distro=$(cat /etc/os-release | grep -e "^ID=" | awk -F '=' '{ print $NF }')
  # if [[ $distro == "ubuntu" ]]; then
  #   apt install -y rofi
  # fi
  # if [[ $distro == "manjaro" || $distro == "arch" ]]; then
  #   pacman -S rofi
  # fi
}

install_rofi
