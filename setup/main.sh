#!/bin/sh
# sh -c "$(curl -H 'Cache-Control: no-cache' -LsSo- https://raw.githubusercontent.com/IgorAssuncao/system-config/master/setup/main.sh)"

downloadRepo() {
  if [[ ! -d ~/system-config/ ]]; then
    echo "Downloading repo"
    git clone git@github.com:IgorAssuncao/system-config.git ~/system-config
    echo "Finished downloading repo"
  else
    echo "Skipping repo download"
  fi
}

echo "This script automatically installs some tools and creates symlinks for you."
echo "All of these tools will be prompted to install:
    - QTile (A window manager written in python)
    - Oh-my-zsh
    - NeoVim (Newer version of vim)
    - Custom init.vim (nvim config file)
    - Custom Xresources
  "

downloadRepo

./zsh.sh
./asdf.sh
./nvim.sh
./fonts.sh

# if [ -d "~/.i3/config" ]; then
#   echo "Renaming ~/.i3/config to ~/.i3/config.bkp"
#   mv ~/.i3/config ~/.i3/config.bkp
#   echo "Creating ~/.i3/config symlink"
#   ln -s ~/system-config/.i3/config ~/.i3/config
#   echo "Finished creating ~/.i3/config symlink"
# fi
# 
# echo "Creating .i3status.conf symlink"
# if [ -a "~/.i3status.conf" ]; then
#   echo "Renaming ~/.i3status.conf to ~/.i3status.conf.bkp"
#   mv ~/.i3status.conf ~/.i3status.conf.bkp
#   echo "Creating ~/.i3status.conf symlink"
#   ln -s /etc/i3status.conf ~/.i3status.conf
#   echo "Finished symlink creation"
# fi
# 
# 
# echo "Creating qtile symlink"
# if [ -d "~/.config/qtile" ]; then
#   echo "Renaming ~/.config/qtile to ~/.config/qtile.bkp"
#   mv ~/.config/qtile ~/.config/qtile.bkp
# fi
# 
# sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
# echo "Creating ~/.zshrc symlink"
# if [ -a "~/.zshrc" ]; then
#   echo "Renaming ~/.zshrc to ~/.zshrc.bkp"
#   mv ~/.zshrc ~/.zshrc.bkp
# fi
# 
# echo "Renaming ~/.Xresources to ~/.Xresources.bkp"
# mv ~/.Xresources ~/.Xresources.bkp
# echo "Renaming ~/.xinitrc to ~/.xinitrc.bkp"
# mv ~/.xinitrc ~/.xinit.bkp
# echo "Creating symlinks" && \
# ln -s ~/system-config/.config/x/.Xresources ~/.Xresource
# ln -s ~/system-config/.config/x/.xinitrc ~/.xinitrc

# echo "Installing exa (ls replacement written in Rust)"
# sudo pacman -S exa
# 
# echo "Installing bat (cat replacement written in Rust)"
# sudo pacman -S bat
# 
# echo "Installing ripgrep"
# sudo pacman -S ripgrep
