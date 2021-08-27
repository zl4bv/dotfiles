#!/bin/sh

if command -v neofetch >/dev/null 2>&1; then
  exit 0
fi

case "${PKG_MGR}" in
  apt-get)
    apt-get install --yes neofetch
    ;;

  homebrew)
    brew install neofetch
    ;;

  pacman)
    pacman -S neofetch
    ;;
esac
