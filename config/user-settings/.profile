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
#export XDG_CONFIG_HOME="$HOME/.config"
#export XDG_CONFIG_DIRS=/usr/etc/xdg:/etc/xdg
#export GTK2_RC_FILES="$HOME/.gtkrc-2.0"
#export QT_QPA_PLATFORMTHEME="qt5ct"
#export GTK2_RC_FILES="$HOME/.gtkrc-2.0"
export BROWSER=/usr/bin/brave
export EDITOR=/usr/bin/nvim
export VISUAL=/usr/bin/nvim
export TERMINAL=/usr/bin/alacritty

# custom path
if [ -d "$HOME/.local/bin" ]; then
    export PATH=$HOME/.local/bin:$PATH
fi


# golang gopath
export GOPATH="$HOME/coding/go"
export PATH="$HOME/.local/go/bin:$PATH"
