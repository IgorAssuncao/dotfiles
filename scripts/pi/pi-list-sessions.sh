#!/bin/sh
# List all pi sessions for fzf: <name-or-first-message>\t<timestamp>\t<cwd>\t<jsonl-path>
# Names come from the latest "session_info" entry; fallback to first user message.
sessions_root="${PI_SESSIONS_DIR:-$HOME/.pi/agent/sessions}"

find "$sessions_root" -type f -name "*.jsonl" 2>/dev/null | while IFS= read -r f; do
  # Skip subagent run session.jsonl files (nested under .../<run-id>/session.jsonl)
  case "$f" in */*/run-*/session.jsonl|*/*/run-*/session.jsonl) continue;; esac
  [ -s "$f" ] || continue

  # Extract cwd + timestamp from the first "session" entry
  meta=$(head -1 "$f")
  cwd=$(printf '%s' "$meta" | sed -n 's/.*"cwd":"\([^"]*\)".*/\1/p')
  ts=$(printf '%s' "$meta"  | sed -n 's/.*"timestamp":"\([^"]*\)".*/\1/p')

  # Latest session_info "name" field (if any)
  name=$(grep '"type":"session_info"' "$f" 2>/dev/null | tail -1 | sed -n 's/.*"name":"\([^"]*\)".*/\1/p')

  # Fallback: first user message text
  if [ -z "$name" ]; then
    name=$(grep '"role":"user"' "$f" 2>/dev/null | head -1 | sed -n 's/.*"text":"\([^"]*\)".*/\1/p' | cut -c1-80)
  fi
  [ -z "$name" ] && name="(unnamed)"

  printf '%s\t%s\t%s\t%s\n' "$name" "$ts" "$cwd" "$f"
done
