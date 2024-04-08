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
