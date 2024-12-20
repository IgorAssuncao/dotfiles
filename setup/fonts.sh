#!/bin/bash

github_nerd_fonts_url="https://raw.githubusercontent.com/ryanoasis/nerd-fonts/master/patched-fonts"

fonts_dir="${HOME}/.local/share/fonts"

fonts_list=(
  "Hack Bold Nerd Font"
  "Hack Bold Italic Nerd Font"
  "Hack Italic Nerd Font"
  "Hack Regular Nerd Font"
)

ensure_curl() {
  if [[ ! "$(which curl)" ]]; then
    echo "You need to install curl."
    exit 1
  fi
}

if [[ ! -d $fonts_dir ]]; then
  mkdir -p $fonts_dir
fi

# if [[ ! -d $HOME/.fonts ]]; then
#   ln -s $fonts_dir $HOME/.fonts
# fi

cd $fonts_dir

download_font() {
  font=$1
  font_name="$(echo ${font} | cut -d ' ' -f1)"
  font_style="$(echo ${font} | cut -d ' ' -f2)"
  if [[ $(echo ${font} | cut -d ' ' -f3) == "Italic" ]]; then
    font_style="${font_style}Italic"
  fi
  formatted_font="$(echo ${font} | sed -e 's/ //g')"
  download_url="${github_nerd_fonts_url}/${font_name}/${font_style}/${formatted_font}.ttf"
  # original:
  # https://raw.githubusercontent.com/ryanoasis/nerd-fonts/master/patched-fonts/Hack/BoldItalic/HackNerdFont-BoldItalic.ttf
  # mine:
  # https://raw.githubusercontent.com/ryanoasis/nerd-fonts/master/patched-fonts/Hack/BoldItalic/complete/HackBoldItalicNerdFontComplete.ttf
  echo $download_url
  curl -sfLo "${font}.ttf" $download_url
}

install_fonts() {
  for font in "${fonts_list[@]}"; do
    download_font "$font"
  done
}

ensure_curl
# install_fonts

cd -

macos_brew() {
    [[ ! $(command -v brew) ]] && "Brew not found...\nExiting..." && exit 1
    # The fonts list can be found here: https://gist.github.com/davidteren/898f2dcccd42d9f8680ec69a3a5d350e
    fonts_list=(
        font-hack-nerd-font
        font-hurmit-nerd-font
        font-jetbrains-mono-nerd-font
    )

    brew tap homebrew/cask-fonts

    for font in "${fonts_list[@]}"; do
      brew install --cask "$font"
    done
    exit
}

$1
