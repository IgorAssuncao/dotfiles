#!/bin/sh

body="## What's Changed
  * [PF-832] Notify release on slack. by @IgorAssuncao in https://github.com/lootmarket/rivalry/pull/9012
  * Adding sentry logging of user data for SEON requests by @ryantology in https://github.com/lootmarket/rivalry/pull/9013
"

echo "$body" | tr '\n' ';' | sed -e 's/;/\\n/g'
