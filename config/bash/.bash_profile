#
# ~/.bash_profile
#

# .bash_profile -*- mode: sh -*-

# Load login settings and environment variables
if [[ -f ~/.profile ]]; then
  source ~/.profile
fi

# Load interactive settings
if [[ -f ~/dotfiles/config/bash/.bashrc ]]; then
  source ~/dotfiles/config/bash/.bashrc
fi

