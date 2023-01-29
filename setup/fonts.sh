#/bin/sh

github_nerd_fonts_url="https://raw.githubusercontent.com/ryanoasis/nerd-fonts/master/patched-fonts"

fonts_dir="${HOME}/.local/share/fonts"

fonts_list=(
  "Hack Bold Nerd Font Complete"
  "Hack Bold Italic Nerd Font Complete"
  "Hack Italic Nerd Font Complete"
  "Hack Regular Nerd Font Complete"
)

ensure_curl() {
  if [[ ! "$(which curl)" ]]; then
    echo "You need to install curl."
    exit 1
  fi
}

if [[ ! -d $fonts_dir ]]; then
  echo $fonts_dir
  mkdir -p $fonts_dir
fi

cd $fonts_dir

download_font() {
  font=$1
  font_name="$(echo ${font} | cut -d ' ' -f1)"
  font_style="$(echo ${font} | cut -d ' ' -f2)"
  if [[ $(echo ${font} | cut -d ' ' -f3) == "Italic" ]]; then
    font_style="${font_style}Italic"
  fi
  formatted_font="$(echo ${font} | sed -e 's/ /%20/g')"
  download_url="${github_nerd_fonts_url}/${font_name}/${font_style}/complete/${formatted_font}.ttf"
  curl -sfLo "${font}.ttf" $download_url
}

install_fonts() {
  for font in "${fonts_list[@]}"; do
    download_font "$font"
  done
}

install_fonts

cd -
