#
# ~/.bash_profile
#

# .bash_profile -*- mode: sh -*-

# Load login settings and environment variables
if [[ -f ~/dotfiles/config/user-settings/.profile ]]; then
  source ~/dotfiles/config/user-settings/.profile
fi

# Load interactive settings
# if [[ -f ~/dotfiles/config/bash/.bashrc ]]; then
#   source ~/dotfiles/config/bash/.bashrc
# fi
