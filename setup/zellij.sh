#!/bin/bash

ZELLIJ_VERSION="v0.35.2"
ZELLIJ_ZIP_FILENAME="zellij.tar.gz"

download() {
  echo "Downloading zellij"
  curl -LS https://github.com/zellij-org/zellij/releases/download/$ZELLIJ_VERSION/zellij-x86_64-unknown-linux-musl.tar.gz -o $ZELLIJ_ZIP_FILENAME
}

install() {
  echo "Extracting zellij"
  tar -xzf $ZELLIJ_ZIP_FILENAME
  chmod +x zellij
  echo "Moving zellij to ~/.local/bin"
  mv zellij ~/.local/bin/
}

clean_up() {
  echo "Cleaning up"
  rm -rf $ZELLIJ_ZIP_FILENAME
}

download
install
clean_up

echo "Zellij done"
