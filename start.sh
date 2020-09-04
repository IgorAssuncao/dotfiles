#!/bin/sh
# sh -c "$(curl -H 'Cache-Control: no-cache' -LsSo- https://raw.githubusercontent.com/IgorAssuncao/system-config/master/start.sh)"

echo "This script automatically installs some tools and creates symlinks for you."
echo "All of these tools will be prompted to install:
    - QTile (A window manager written in python)
    - Kitty (A terminal emulator)
    - Kitty custom config
    - Oh-my-zsh
    - NeoVim (Newer version of vim)
    - Custom vimrc (vim config file)
    - Custom init.vim (nvim config file)
    - Custom Xresources
  "
echo "Do you want to continue?"
read -p "Please, answer (y/n): " -n 1 choice && \
  if [ $choice != "y" ]; then
    exit 0
  fi

echo "Downloading repo" && \
  git clone https://github.com/IgorAssuncao/system-config.git ~/system-config && \
  echo "Finished downloading repo"

echo "Install Qtile?"
read -p "Please, answer (y/n): " -n 1 choice && \
  if [ $choice == "y" ]; then
    echo "Installing Qtile" && \
      sudo pacman -S qtile && \
      echo "Finished installed Qtile" && \
      echo "Creating qtile symlink" && \
      if [ -d "~/.config/qtile" ]; then
        echo "Renaming ~/.config/qtile to ~/.config/qtile.bkp"
        mv ~/.config/qtile ~/.config/qtile.bkp
      fi && \
        ln -s ~/system-config/.config/qtile/ ~/.config/qtile && \
        echo "Finished creating qtile symlink"
  fi

echo "Install Kitty?"
read -p "Please, answer (y/n): " -n 1 choice && \
  if [ $choice == "y" ]; then
    echo "Installing kitty" && \
      sudo pacman -S kitty && \
      echo "Finished installing kitty"
      echo "Creating kitty symlink" && \
      if [ -d "~/.config/kitty" ]; then
        echo "Renaming ~/.config/kitty to ~/.config/kitty.bkp"
        mv ~/.config/kitty ~/.config/kitty.bkp
      fi && \
        ln -s ~/system-config/.config/kitty/ ~/.config/kitty && \
        echo "Finished creating kitty symlink"
  fi

echo "Install custom Kitty config?"
read -p "Please, answer (y/n): " -n 1 choice && \
  if [ $choice == "y" ]; then
    echo "Creating kitty symlink" && \
    if [ -d "~/.config/kitty" ]; then
      echo "Renaming ~/.config/kitty to ~/.config/kitty.bkp"
      mv ~/.config/kitty ~/.config/kitty.bkp
    fi && \
      ln -s ~/system-config/.config/kitty/ ~/.config/kitty && \
      echo "Finished creating kitty symlink"
  fi

echo "Install Oh-my-zsh?"
read -p "Please, answer (y/n): " -n 1 choice && \
  if [ $choice == "y" ]; then
    sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" && \
      echo "Creating ~/.zshrc symlink" && \
      if [ -a "~/.zshrc" ]; then
        echo "Renaming ~/.zshrc to ~/.zshrc.bkp"
        mv ~/.zshrc ~/.zshrc.bkp
      fi && \
        ln -s ~/system-config/.config/zsh/.zshrc ~/.zshrc && \
        echo "Finished creating ~/.zshrc symlink"
  fi

echo "Install NeoVim?"
read -p "Please, answer (y/n): " -n 1 choice && \
  if [ $choice == "y" ]; then
    echo "Installing NeoVim" && \
      sudo pacman -S neovim && \
      echo "Finished installing NeoVim"
  fi

echo "Install custom vimrc?"
read -p "Please, answer (y/n): " -n 1 choice && \
  if [ $choice == "y" ]; then
    if [ -a "~/.vimrc" ]; then
      echo "Renaming ~/.vimrc to ~/.vimrc.bkp"
      mv ~/.vimrc ~/.vimrc.bkp
    fi
    echo "Creating ~/.vimrc symlink" && \
      ln -s ~/system-config/.config/vim/vimrc ~/.vimrc
    echo "Creating ~/.vim/coc-settings synlink" && \
      ln -s ~/system-config/.config/vim/coc-settings.json ~/.vim/coc-settings.json
  fi

echo "Install custom init.vim (nvim config file)?"
read -p "Please, answer (y/n): " -n 1 choice && \
  if [ $choice == "y" ]; then
    if [ -d "~/.config/nvim" ]; then
      echo "Renaming ~/.config/nvim to ~/.config/nvim.bkp"
      mv ~/.config/nvim ~/.config/nvim.bkp
    fi
    echo "Creating ~/.config/nvim symlink" && \
      ln -s ~/system-config/.config/nvim ~/.config/nvim
  fi

echo "Install custom Xresources?"
read -p "Please, answer (y/n): " -n 1 choice && \
  if [ $choice == "y" ]; then
    echo "Renaming ~/.Xresources to ~/.Xresources.bkp"
    mv ~/.Xresources ~/.Xresources.bkp
    echo "Renaming ~/.xinitrc to ~/.xinitrc.bkp"
    mv ~/.xinitrc ~/.xinit.bkp
    echo "Creating symlinks" && \
      ln -s ~/system-config/.config/x/.Xresources ~/.Xresources && \
      ln -s ~/system-config/.config/x/.xinitrc ~/.xinitrc
  fi
