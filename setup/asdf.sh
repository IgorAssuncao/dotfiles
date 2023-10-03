#!/bin/bash

cd "$(dirname "$(readlink -f "$0")")"

source $HOME/system-config/setup/utils.sh

ASDF_VERSION=$1

plugins_list=(
  "awscli"
  "bat"
  "exa"
  "fzf"
  "github-cli"
  "golang"
  "helm"
  "jq"
  "k9s"
  "kind"
  "kubectl"
  "lazygit"
  "neovim"
  "nodejs"
  "ripgrep"
  "rust"
  "terraform"
  "yq"
)

dependencies=(
  "git"
  "curl"
)

source_cmd=". \$HOME/.asdf/asdf.sh"
zsh_config_file=~/.zshrc

ensure_dependencies() {
  dependencies=($@)
  
  for dep in "${dependencies[@]}"; do
    if [[ ! "$(which $dep)" ]]; then
      echo "Please install $dep"
      exit 1
    fi
  done
}

asdf_exists() {
  if [[ -d ~/.asdf ]]; then
    return 0
  else
    return 1
  fi

  return [[ -d ~/.asdf ]]
}

download() {
  echo "Downloading asdf"
  git clone https://github.com/asdf-vm/asdf.git ~/.asdf --branch $ASDF_VERSION
}

configure_shell() {
  if [[ ! $SHELL == "/bin/zsh" ]]; then
    echo "$SHELL currently not supported"
    echo "You need to configure manually"
    echo "Check asdf documentation for more information"
    return 1
  fi

  echo "$source_cmd" >> $zsh_config_file
}

setup_plugins() {
  plugins=($@)

  for plugin in "${plugins[@]}"; do
    asdf plugin add $plugin
  done

  asdf install
}

install() {
  echo "Checking asdf dependencies."
  ensure_dependencies "${dependencies[@]}"

  if [[ ! -d ~/.asdf ]]; then
    download
  else
    echo "Skipping asdf download since its already installed."
  fi

  if [[ ! $(grep "$source_cmd" $zsh_config_file) ]]; then
    echo "Configuring asdf to $SHELL"
    configure_shell
  fi

  if [[ ! $SHELL == "/bin/zsh" ]]; then
    exit 1
  fi

  # . ~/.zshrc

  if [[ ! -e ~/.tool-versions ]]; then
    createSymlink asdf/.tool-versions .tool-versions
  fi

  setup_plugins "${plugins_list[@]}"
}

install

echo "ASDF done"
