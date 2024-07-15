# $HOME/.profile

# Load profiles from /etc/profile.d
# if test -d /etc/profile.d/; then
# 	for profile in /etc/profile.d/*.sh; do
# 		test -r "$profile" && . "$profile"
# 	done
# 	unset profile
# fi

[[ -e /usr/share/defaults/etc/profile ]] && source /usr/share/defaults/etc/profile

checkAndRun() {
  FILE=$1
  [[ -f $FILE ]] && . $FILE
  [[ ! -f $FILE ]] && echo "$FILE not found."
}

# Set our default path
# export PATH
# export XDG_CONFIG_HOME="$HOME/.config"
# export XDG_CONFIG_DIRS=/usr/etc/xdg:/etc/xdg
# export QT_QPA_PLATFORMTHEME="qt5ct"
# # export GTK2_RC_FILES="$HOME/.gtkrc-2.0"
export BROWSER=/usr/bin/brave

if command -v nvim &>/dev/null ; then
    export EDITOR="nvim"
    export VISUAL="nvim"
else
    export EDITOR="vim"
    export VISUAL="vim"
fi
# export TERMINAL=/usr/bin/kitty

# custom path
if [ -d "$HOME/.local/bin" ]; then
    export PATH=$HOME/.local/bin:$PATH
fi

checkAndRun $HOME/.asdf/asdf.sh
checkAndRun $HOME/.cargo/env

# golang gopath
USER_LOCAL_BIN_PATH="$HOME/.local/bin"
GO_EXT_TOOLS_PATH="$USER_LOCAL_BIN_PATH/go_ext_tools"
GO_PROJECTS_PATH="$HOME/coding/go"
# export GOPATH="$GO_EXT_TOOLS_PATH:$GO_PROJECTS_PATH"
# export PATH="$USER_LOCAL_BIN_PATH/go/bin:$PATH"
unset USER_LOCAL_BIN_PATH
unset GO_EXT_TOOLS_PATH
unset GO_PROJECTS_PATH

# export GOBIN="$(go env | grep GOPATH | awk -F '=' '{print $NF}' | sed -e s/\"//g)/bin"
export GOBIN="$(go env GOPATH)/bin"
export PATH=$PATH:$GOBIN
