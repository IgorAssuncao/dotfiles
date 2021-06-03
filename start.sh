#!/bin/sh
# sh -c "$(curl -H 'Cache-Control: no-cache' -LsSo- https://raw.githubusercontent.com/IgorAssuncao/system-config/master/start.sh)"

checkInput() {
  read -p "Please, answer (y/n): " -n 1 choice
  if [ $choice != "y" ]; then
    exit 0
  fi
}

downloadRepo() {
  checkInput
  echo "Downloading repo"
  git clone git@github.com:IgorAssuncao/system-config.git
  echo "Finished downloading repo"
}

echo "This script automatically installs some tools and creates symlinks for you."
echo "All of these tools will be prompted to install:
    - QTile (A window manager written in python)
    - Kitty (A terminal emulator)
    - Kitty custom config
    - Oh-my-zsh
    - NeoVim (Newer version of vim)
    - Custom init.vim (nvim config file)
    - Custom Xresources
  "


echo "Install custom i3 config?"
checkInput
if [ -d "~/.i3/config" ]; then
  echo "Renaming ~/.i3/config to ~/.i3/config.bkp"
  mv ~/.i3/config ~/.i3/config.bkp
  echo "Creating ~/.i3/config symlink"
  ln -s ~/system-config/.i3/config ~/.i3/config
  echo "Finished creating ~/.i3/config symlink"
fi

echo "Creating .i3status.conf symlink"
checkInput
if [ -a "~/.i3status.conf" ]; then
  echo "Renaming ~/.i3status.conf to ~/.i3status.conf.bkp"
  mv ~/.i3status.conf ~/.i3status.conf.bkp
  echo "Creating ~/.i3status.conf symlink"
  ln -s /etc/i3status.conf ~/.i3status.conf
  echo "Finished symlink creation"
fi


echo "Install Qtile?"
checkInput
echo "Installing Qtile"
sudo pacman -S qtile
echo "Finished installed Qtile"
echo "Creating qtile symlink"
if [ -d "~/.config/qtile" ]; then
  echo "Renaming ~/.config/qtile to ~/.config/qtile.bkp"
  mv ~/.config/qtile ~/.config/qtile.bkp
fi
ln -s ~/system-config/.config/qtile/ ~/.config/qtile
echo "Finished creating qtile symlink"

echo "Install Kitty?"
checkInput
echo "Installing kitty"
sudo pacman -S kitty
echo "Finished installing kitty"
echo "Creating kitty symlink"

echo "Install custom Kitty config?"
checkInput
echo "Creating kitty symlink"
if [ -d "~/.config/kitty" ]; then
  echo "Renaming ~/.config/kitty to ~/.config/kitty.bkp"
  mv ~/.config/kitty ~/.config/kitty.bkp
fi
ln -s ~/system-config/.config/kitty ~/.config

echo "Install Oh-my-zsh?"
checkInput
sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
echo "Creating ~/.zshrc symlink"
if [ -a "~/.zshrc" ]; then
  echo "Renaming ~/.zshrc to ~/.zshrc.bkp"
  mv ~/.zshrc ~/.zshrc.bkp
fi
ln -s ~/system-config/.config/zsh/.zshrc ~/.zshrc
echo "Finished creating ~/.zshrc symlink"

echo "Install NeoVim?"
read -p "Please, answer (y/n): " -n 1 choice
if [ $choice == "y" ]; then
  echo "Installing NeoVim"
  sudo pacman -S neovim
  echo "Finished installing NeoVim"
fi

echo "Install custom init.vim (nvim config file)?"
checkInput
if [ -d "~/.config/nvim" ]; then
  echo "Renaming ~/.config/nvim to ~/.config/nvim.bkp"
  mv ~/.config/nvim ~/.config/nvim.bkp
fi
echo "Creating ~/.config/nvim symlink"
ln -s ~/system-config/.config/nvim ~/.config/nvim

echo "Install custom Xresources?"
checkInput
echo "Renaming ~/.Xresources to ~/.Xresources.bkp"
mv ~/.Xresources ~/.Xresources.bkp
echo "Renaming ~/.xinitrc to ~/.xinitrc.bkp"
mv ~/.xinitrc ~/.xinit.bkp
echo "Creating symlinks" && \
ln -s ~/system-config/.config/x/.Xresources ~/.Xresource
ln -s ~/system-config/.config/x/.xinitrc ~/.xinitrc

echo "Install custom profile?
  (custom user settings like default editor and browser)"
checkInput
ln -s ~/system-config/.config/user-settings/.profile ~/.profile

echo "Create git custom config?"
checkInput
ln -s ~/system-config/.config/git/.gitconfig ~/.gitconfig
ln -s ~/system-config/.config/git/.gitignore ~/.gitignore
