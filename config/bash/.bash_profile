#
# ~/.bash_profile
#

checkAndRun() {
  FILE=$1
  [[ -f $FILE ]] && . $FILE
  [[ ! -f $FILE ]] && echo "$FILE not found."
}

checkAndRun $HOME/.asdf/asdf.sh
checkAndRun $HOME/.cargo/env

if command -v nvim &>/dev/null ; then
    export EDITOR="nvim"
else
    export EDITOR="vim"
fi
