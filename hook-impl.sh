#!/bin/bash

notify() {
  if which -s osascript
  then
    osascript -e 'display notification "'"$2"'" with title "'"$1"'"'
  elif which -s notify-send
  then
    notify-send "$1" "$2"
  fi
}

notify-failure() {
  notify "Eslint failure: $(basename $(pwd))" "Eslint check failed for $(basename $(pwd)). Run npm run eslint for details."
}

notify-success() {
  notify "Eslint success: $(basename $(pwd))" "Eslint was completed without issues for $(basename $(pwd))"
}

PIDFILE=/tmp/eslint-$(pwd | (which -s md5sum && md5sum || md5)) 2>/dev/null
if [ -e $PIDFILE ]
then
  if test $(find $PIDFILE -mtime -30s)
  then
    pkill -g $(cat $PIDFILE)
  fi
fi

if which -s osascript || which -s notify-send
then
  (
    npm run-script eslint --silent &>/dev/null && notify-success || notify-failure
    rm $PIDFILE 2>/dev/null
  ) &>/dev/null &
else
  # fallback
  npm run-script eslint || exit 1
  exit
fi

PID=$!
GROUPID=$(ps -opgid -p $PID | tail -n1)
echo $GROUPID > $PIDFILE

