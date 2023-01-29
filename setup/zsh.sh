install() {
  sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
}

after() {
  sh -c "$(git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting)"
}

install
after

if [[ ! -e ~/.zshrc ]]; then
  echo "Creating symlink for ~/.zshrc"
  ln -s ~/system-config/config/zsh/.zshrc ~/.zshrc
  echo "Created symlink for ~/.zshrc successfully"
fi

if [[ ! -e ~/.zshrc ]]; then
  echo "Creating symlink for ~/.zshrc_aliases"
  ln -s ~/system-config/config/zsh/.zshrc_aliases ~/.zshrc_aliases
  echo "Created symlink for ~/.zshrc_aliases successfully"
fi

if [[ ! -e ~/.zshrc ]]; then
  echo "Creating symlink for ~/.zshrc_functions"
  ln -s ~/system-config/config/zsh/.zshrc_functions ~/.zshrc_functions
  echo "Created symlink for ~/.zshrc_functions successfully"
fi
