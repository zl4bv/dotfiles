#!/bin/bash

if ! command -v exa >/dev/null 2>&1; then
  case "${PKG_MGR}" in
    apt-get)
      sudo apt-get install --yes exa
      ;;

    homebrew)
      brew install exa
      ;;

    pacman)
      sudo pacman -S exa
      ;;

  esac
fi
