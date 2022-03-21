#!/bin/bash

if ! command -v hexyl >/dev/null 2>&1; then
  echo "Installing Hexyl..."
  case "${PKG_MGR}" in
    apt-get)
      sudo apt-get install --yes hexyl
      ;;

    pacman)
      sudo pacman -S hexyl
  esac
fi
