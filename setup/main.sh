#!/bin/sh
# sh -c "$(curl -H 'Cache-Control: no-cache' -LsSo- https://raw.githubusercontent.com/IgorAssuncao/dotfiles/master/setup/main.sh)"

ASDF_VERSION="v0.10.2"
ZELLIJ_VERSION="v0.35.2"

downloadRepo() {
  if [[ ! -d ~/dotfiles/ ]]; then
    echo "Downloading repo"
    git clone git@github.com:IgorAssuncao/dotfiles.git ~/dotfiles
    echo "Finished downloading repo"
  else
    echo "Skipping repo download"
  fi
}

echo "This script automatically installs some tools and creates symlinks for you."
echo "All of these tools will be prompted to install:
    - Oh-my-zsh
    - NeoVim (Newer version of vim)
    - Custom init.lua (nvim config file)
  "

downloadRepo

./zsh.sh
./asdf.sh $ASDF_VERSION
./nvim.sh
./rofi.sh
./zellij.sh $ZELLIJ_VERSION
./fonts.sh

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
# ln -s ~/dotfiles/.config/x/.Xresources ~/.Xresource
# ln -s ~/dotfiles/.config/x/.xinitrc ~/.xinitrc

# echo "Installing exa (ls replacement written in Rust)"
# sudo pacman -S exa
# 
# echo "Installing bat (cat replacement written in Rust)"
# sudo pacman -S bat
# 
# echo "Installing ripgrep"
# sudo pacman -S ripgrep
