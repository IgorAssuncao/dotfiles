#!/bin/bash

cd "$(dirname "$(readlink -f "$0")")"

source $HOME/system-config/setup/utils.sh

install() {
    sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
}

after() {
    sh -c "$(git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions)"
    sh -c "$(git clone https://github.com/zsh-users/zsh-completions ${ZSH_CUSTOM:=~/.oh-my-zsh/custom}/plugins/zsh-completions)"
    sh -c "$(git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting)"

    backupOldConfig .zfunc
    ln -s ~/system-config/config/zsh/.zfunc ~/.config/.zfunc
}

install
after

if [[ ! -e ~/.zshrc ]]; then
    echo "Creating symlink for ~/.zshrc"
    ln -s ~/system-config/config/zsh/.zshrc ~/.zshrc
    echo "Created symlink for ~/.zshrc successfully"
fi
