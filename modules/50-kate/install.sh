#!/bin/bash

CURDIR="${HOME}/.dotfiles/modules/50-kate"

if ! command -v kate >/dev/null 2>&1; then
  echo "Installing Kate..."
  case "${PKG_MGR}" in
  pacman)
    pacman -S kate
    ;;
esac
fi

# Only continue if Kate is already installed
if ! command -v kate >/dev/null 2>&1; then
  exit 0
fi
