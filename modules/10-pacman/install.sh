#!/bin/bash

if [ "${PKG_MGR}" != "pacman" ]; then
  exit 0
fi

if command -v pacman-mirrors >/dev/null 2>&1; then
  sudo pacman-mirrors --geoip
fi
