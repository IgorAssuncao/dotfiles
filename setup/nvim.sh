source ./utils.sh

dependencies=(
  "ripgrep"
)

ensure_dependencies() {
  dependencies=($@)
  
  for dep in "${dependencies[@]}"; do
    if [[ ! "$(which $dep)" ]]; then
      echo "Please install $dep"
      exit 1
    fi
  done
}

setupNvim() {
  ensure_dependencies "${dependencies[@]}"
  backupOldConfig "nvim"
  createSymlink "nvim"
}
