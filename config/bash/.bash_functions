git_update_branch() {
  BRANCH=$(git rev-parse --abbrev-ref origin/HEAD | awk -F '/' '{ print $2 }')
  git checkout $BRANCH
  git pull
  git checkout -
  git rebase $BRANCH
}

# --- pi (coding agent) session picker ---------------------------------------
# _pi_list_sessions: emit <name-or-first-msg>\t<timestamp>\t<cwd>\t<jsonl-path>
# Names come from the latest "session_info" entry; fallback to first user msg.
_pi_list_sessions() {
  local sessions_root="${PI_SESSIONS_DIR:-$HOME/.pi/agent/sessions}"
  find "$sessions_root" -type f -name '*.jsonl' 2>/dev/null | while IFS= read -r f; do
    # Skip nested subagent run sessions (*/run-*/session.jsonl)
    case "$f" in *run-*/session.jsonl) continue;; esac
    [ -s "$f" ] || continue
    local meta name cwd ts
    meta=$(head -1 "$f")
    cwd=$(printf '%s' "$meta" | sed -n 's/.*"cwd":"\([^"]*\)".*/\1/p')
    ts=$(printf '%s' "$meta"  | sed -n 's/.*"timestamp":"\([^"]*\)".*/\1/p')
    name=$(grep '"type":"session_info"' "$f" 2>/dev/null | tail -1 | sed -n 's/.*"name":"\([^"]*\)".*/\1/p')
    if [ -z "$name" ]; then
      name=$(grep '"role":"user"' "$f" 2>/dev/null | head -1 | sed -n 's/.*"text":"\([^"]*\)".*/\1/p' | cut -c1-80)
    fi
    [ -z "$name" ] && name='(unnamed)'
    printf '%s\t%s\t%s\t%s\n' "$name" "$ts" "$cwd" "$f"
  done
}

# pi-resume: fzf picker over saved pi sessions; resume/fork/delete from one menu.
pi-resume() {
  if ! command -v fzf >/dev/null 2>&1; then
    echo "pi-resume: fzf is required but not installed." >&2
    return 1
  fi
  local sel fpath uuid
  sel=$(_pi_list_sessions | fzf \
      --with-nth=1,2,3 \
      --delimiter='\t' \
      --preview='printf "name:  %s\nwhen:  %s\nwhere: %s\nfile:  %s\n" {1} {2} {3} {4}; echo; echo "--- first 40 lines of session ---"; head -40 {4} | cut -c1-300' \
      --preview-window=right:60%:wrap \
      --header='Enter=resume  Ctrl-F=fork  Ctrl-D=delete(trash)  Esc=cancel' \
      --bind 'ctrl-d:execute-silent(trash {4} 2>/dev/null || rm -f {4})+reload(_pi_list_sessions)' \
      --bind 'ctrl-f:execute(pi --fork {4} < /dev/tty > /dev/tty 2>&1 &)' \
      --prompt='pi sessions> ')
  [ -z "$sel" ] && return
  fpath=$(printf '%s' "$sel" | cut -f4)
  uuid=$(basename "$fpath" | sed -n 's/.*_\([0-9a-f-]*\)\.jsonl$/\1/p')
  if [ -z "$uuid" ]; then
    echo "pi-resume: could not extract session id from $fpath" >&2
    return 1
  fi
  exec pi --session "$uuid"
}
