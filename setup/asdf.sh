source ./utils.sh

plugins_list=(
  "awscli"
  "neovim"
  "nodejs"
  "terraform")

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
  return [[ -d ~/.asdf ]]
}

download() {
  echo "Downloading asdf"
  git clone https://github.com/asdf-vm/asdf.git ~/.asdf --branch v0.10.2
}

configure_shell() {
  if [[ $SHELL == "/bin/zsh" ]]; then
    source_cmd=". \$HOME/.asdf/asdf.sh"
    zsh_config_file=~/.zshrc
    if [[ ! $(grep "$source_cmd" $zsh_config_file) ]]; then
      echo "$source_cmd" >> $zsh_config_file
    fi
  else
    echo "$SHELL currently not supported"
    echo "You need to configure manually"
    echo "Check asdf documentation for more information"
    return 1
  fi
}

setup_plugins() {
  plugins=($@)

  for plugin in "${plugins[@]}"; do
    asdf plugin add $plugin
  done

  if [[ ! -e ~/.tool-versions ]]; then
    createSymlink asdf/.tool_versions .tool_versions
  fi
  asdf install
}

install() {
  echo "Checking asdf dependencies."
  ensure_dependencies git curl

  if [[ ! asdf_exists ]]; then
    download
  else
    echo "Skipping asdf download since its already installed."
  fi

  echo "Configuring asdf to $SHELL"
  configure_shell

  if [[ ! $SHELL == "/bin/zsh" ]]; then
    exit 1
  fi

  # . ~/.zshrc
  setup_plugins "${plugins_list[@]}"
}

install
