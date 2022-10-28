# $HOME/.profile

# Load profiles from /etc/profile.d
# if test -d /etc/profile.d/; then
# 	for profile in /etc/profile.d/*.sh; do
# 		test -r "$profile" && . "$profile"
# 	done
# 	unset profile
# fi

source /usr/share/defaults/etc/profile

# Set our default path
# export PATH
# export XDG_CONFIG_HOME="$HOME/.config"
# export XDG_CONFIG_DIRS=/usr/etc/xdg:/etc/xdg
# export QT_QPA_PLATFORMTHEME="qt5ct"
# export GTK2_RC_FILES="$HOME/.gtkrc-2.0"
export BROWSER=/usr/bin/brave
export EDITOR=/usr/bin/nvim
export VISUAL=/usr/bin/nvim
export TERMINAL=/usr/bin/kitty

# custom path
# if [ -d "$HOME/.local/bin" ]; then
#     export PATH=$HOME/.local/bin:$PATH
# fi


# golang gopath
USER_LOCAL_BIN_PATH="$HOME/.local/bin"
GO_EXT_TOOLS_PATH="$USER_LOCAL_BIN_PATH/go_ext_tools"
GO_PROJECTS_PATH="$HOME/coding/go"
export GOPATH="$GO_EXT_TOOLS_PATH:$GO_PROJECTS_PATH"
export PATH="$USER_LOCAL_BIN_PATH/go/bin:$PATH"
unset USER_LOCAL_BIN_PATH
unset GO_EXT_TOOLS_PATH
unset GO_PROJECTS_PATH
