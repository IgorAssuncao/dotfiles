# $HOME/.profile

# # Load profiles from /etc/profile.d
# if test -d /etc/profile.d/; then
#     for profile in /etc/profile.d/*.sh; do
#         test -r "$profile" && . "$profile"
#     done
#     unset profile
# fi

# [[ -f /usr/share/defaults/etc/profile ]] && source /usr/share/defaults/etc/profile

checkAndSource() {
    FILE=$1
    [[ -e $FILE ]] && . $FILE
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
    export PAGER="nvim"
    export MANPAGER="nvim +Man!"
# else
#     export EDITOR="vim"
#     export VISUAL="vim"
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
    export PATH="$HOME/.local/bin:$PATH"
fi

# checkAndSource $HOME/.asdf/asdf.sh

# golang 
# export GOBIN="$(go env | grep GOPATH | awk -F '=' '{print $NF}' | sed -e s/\"//g)/bin"
# export GOBIN="$(go env GOPATH)/bin"
[[ -z $(go env GOBIN) ]] && go env -w GOBIN="$(go env GOPATH)/bin"
export PATH="$(go env GOBIN):$PATH"

# rust and cargo
. $HOME/.cargo/env

# bun
export BUN_INSTALL="$HOME/.bun"
export PATH="$BUN_INSTALL/bin:$PATH"

# pipx and uv
# NOTE: custom path section above already covers this
# export PATH="$HOME/.local/bin:$PATH"

# Ensure the user runtime directory is set
if [ -z "$XDG_RUNTIME_DIR" ]; then
    export XDG_RUNTIME_DIR="/run/user/$(id -u)"
fi

# Only execute this block when logging into the primary text console (TTY1)
# Using standard POSIX syntax instead of Bash-specific variables
if [ -z "$DISPLAY" ] && [ $(command -v sway) ] && [ "$(tty)" = "/dev/tty1" ]; then
    
    # Safely clear out any previous dead processes or lock files
    pkill -9 -u "$USER" -f "pipewire|wireplumber|xdg-desktop-portal" 2>/dev/null
    rm -f "$XDG_RUNTIME_DIR/pulse/native"

    # Export variables required by portals before the compositor initializes
    export XDG_CURRENT_DESKTOP=sway
    export XDG_SESSION_TYPE=wayland

    # Launch Audio Daemons sequentially in the background
    pipewire &
    sleep 0.5
    pipewire-pulse &
    sleep 0.5
    wireplumber &
    sleep 0.5

    # Initialize a clean DBus session bus environment
    # This generates the tracking variables so background portals can find Sway
    # making screensharing work
    eval $(dbus-launch --sh-syntax)
    dbus-update-activation-environment --systemd WAYLAND_DISPLAY XDG_CURRENT_DESKTOP XDG_SESSION_TYPE

    # Launch Portals safely now that the session environment is ready
    /usr/libexec/xdg-desktop-portal-wlr &
    sleep 0.5
    /usr/libexec/xdg-desktop-portal &

    # Launch Sway inside the universal DBus wrapper
    exec dbus-run-session sway
    # If it's not enough then
    # AND force DBus to update its environment so OBS/Chrome can find the portals
    # exec dbus-run-session sh -c '
    #     dbus-update-activation-environment --systemd WAYLAND_DISPLAY XDG_CURRENT_DESKTOP XDG_SESSION_TYPE
    #     exec sway
    # '
fi

# Start Sway
# if [[ $(command -v sway) && "$(tty)" = "/dev/tty1" ]]; then
#     export XDG_CURRENT_DESKTOP=sway
#     export XDG_SESSION_TYPE=wayland
#     exec dbus-run-session sway
# fi
# Start Hyprland
if [[ $(command -v Hyprland) && "$(tty)" = "/dev/tty7" ]]; then
    export XDG_CURRENT_DESKTOP=Hypr
    export XDG_SESSION_TYPE=wayland
    exec dbus-run-session Hyprland
fi
