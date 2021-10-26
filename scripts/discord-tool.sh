#!/usr/bin/env sh

DISCORD_VERSION=0.0.16
DISCORD_ADDRESS=https://dl.discordapp.net/apps/linux/$DISCORD_VERSION/discord-$DISCORD_VERSION.tar.gz

download() {
  echo "Downloading latest Discord."
  curl -o /tmp/discord.tar.gz $DISCORD_ADDRESS
  echo "Finished downloading."
}

extract() {
  tar -xzf /tmp/discord.tar.gz -C $HOME --overwrite
}

createSymlink() {
  DISCORD_BINARY_PATH="$HOME/Discord/Discord"
  DISCORD_SYMLINK_PATH="$HOME/.local/bin/Discord"
  
  if [ ! -h $DISCORD_SYMLINK_PATH ]; then
    ln -s $DISCORD_BINARY_PATH $DISCORD_SYMLINK_PATH
  fi
}

createDesktopSymlink() {
  DISCORD_DESKTOP_FILE_PATH="$HOME/Discord/discord.desktop"
  DISCORD_DESKTOP_FILE_SYMLINK_PATH="$HOME/.local/share/applications/Discord.desktop"

  if [ ! -f $DISCORD_DESKTOP_FILE ]; then
    ln -s $DISCORD_DESKTOP_FILE_PATH $DISCORD_DESKTOP_FILE_SYMLINK_PATH
  fi
}

COMMAND=$1

case $COMMAND in
  "install" | "upgrade") download; extract; createSymlink; createDesktopSymlink;;
  *) echo "ERROR!"; echo "You need to pass either 'install' or 'upgrade' as argument."; exit 1;;
esac
