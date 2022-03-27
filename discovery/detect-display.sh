#!/bin/bash

if command -v loginctl >/dev/null 2>&1; then
  sessiontype=$(loginctl show-session "$(awk '/tty/ {print $1}' <(loginctl))" -p Type | awk -F= '{print $2}')
  if [ "${sessiontype}" = "wayland" ]; then
    export IS_WAYLAND=true
  fi
  unset sessiontype
fi
