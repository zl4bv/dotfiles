#!/bin/bash

if command -v fc-list >/dev/null 2>&1; then
  fclistout=$(fc-list | grep FiraCode)
  [ -n "${fclistout}" ] && exit 0
fi

echo "Installing Font Fira Code..."
case "${PKG_MGR}" in
  apt-get)
    sudo apt-get install --yes fonts-firacode
    ;;
  homebrew)
    brew tap homebrew/cask-fonts
    brew install --cask font-fira-code
    ;;
  pacman)
    sudo pacman -S --noconfirm ttf-fira-code
    ;;
  *)
    echo "Warning! Not installing FiraCode font: unknown package manager"
    ;;
esac
