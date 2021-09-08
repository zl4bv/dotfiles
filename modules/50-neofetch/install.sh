#!/bin/sh

if command -v neofetch >/dev/null 2>&1; then
  exit 0
fi

case "${PKG_MGR}" in
  apt-get)
    sudo apt-get install --yes neofetch
    ;;

  homebrew)
    brew install neofetch
    ;;

  pacman)
    sudo pacman -S neofetch
    ;;
esac
