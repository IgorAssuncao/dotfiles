# $HOME/.profile

# Load profiles from /etc/profile.d
if test -d /etc/profile.d/; then
    for profile in /etc/profile.d/*.sh; do
        test -r "$profile" && . "$profile"
    done
    unset profile
fi

[[ -e /usr/share/defaults/etc/profile ]] && source /usr/share/defaults/etc/profile

checkAndSource() {
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
if command -v nvim &>/dev/null; then
    export EDITOR="nvim"
    export VISUAL="nvim"
    export MANPAGER="nvim +Man!"
else
    export EDITOR="vim"
    export VISUAL="vim"
fi

if command -v alacritty &>/dev/null; then
    export TERMINAL=alacritty
elif command -v kitty &>/dev/null; then
    export TERMINAL=kitty
fi

if command -v brave &>/dev/null; then
    export BROWSER=/usr/bin/brave
elif command -v google-chrome-stable &>/dev/null; then
    export BROWSER=/usr/bin/google-chrome-stable
elif command -v firefox &>/dev/null; then
    export BROWSER=/usr/bin/firefox
fi

# custom path
if [ -d "$HOME/.local/bin" ]; then
    export PATH=$HOME/.local/bin:$PATH
fi

# Start Hyprland
[[ $(command -v Hyprland) && "$(tty)" = "/dev/tty1" ]] && exec dbus-run-session Hyprland

# golang gopath
# USER_LOCAL_BIN_PATH="$HOME/.local/bin"
# GO_EXT_TOOLS_PATH="$USER_LOCAL_BIN_PATH/go_ext_tools"
# GO_PROJECTS_PATH="$HOME/coding/go"
# export GOPATH="$GO_EXT_TOOLS_PATH:$GO_PROJECTS_PATH"
# export PATH="$USER_LOCAL_BIN_PATH/go/bin:$PATH"
# unset USER_LOCAL_BIN_PATH
# unset GO_EXT_TOOLS_PATH
# unset GO_PROJECTS_PATH

# export GOBIN="$(go env | grep GOPATH | awk -F '=' '{print $NF}' | sed -e s/\"//g)/bin"
export GOBIN="$(go env GOPATH)/bin"
export PATH=$PATH:$GOBIN

checkAndSource $HOME/.asdf/asdf.sh
checkAndSource $HOME/.cargo/env
