backupOldConfig() {
    echo "Backing up old config in ~/.config"
    target=$1
    if [[ ! -e $target ]]; then
        mv ~/.config/$target ~/.config/${target}.bkp
    fi
}

createSymlink() {
    software=$1
    target=$2
    if [[ $2 == "" ]]; then
        target=$software
    fi
    echo "Creating symlink for $software"
    ln -s ~/system-config/config/$software ~/.config/$target
    echo "Created symlink for $t successfully"
}

install_pkg() {
  pkg=$1
  if [[ $distro == "ubuntu" ]]; then
    sudo apt install -y $pkg
  fi
  if [[ $distro == "manjaro" || $distro == "arch" ]]; then
    sudo pacman -S $pkg
  fi
  if [[ $distro == "void" ]]; then
    sudo xbps-install $pkg
  fi
}
