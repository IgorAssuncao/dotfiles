#!/bin/bash

base_packages=(
  base-devel
  curl
  dbus-elogind
  dbus-elogind-libs
  dbus-elignd-x11
  elogind
  git
  make
  lightdm
  lightdm-gtk3-greeter
  # seatd
  zsh
)

sudo xbps-install -y ${base_packages[@]}

xorg_packages=(
  picom
  xorg
  xinit
  xrandr
  leftwm
  polybar
)

wayland_packages=(
  wayland
  wayfire
)

sudo xbps-install -y ${xorg_packages[@]}

extra_packages=(
  alacritty
  # neovim
  nitrogen
)

sudo xbps-install -y ${extra_packages[@]}
