#!/bin/bash

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
    pacman -S ttf-fira-code
    ;;
  *)
    echo "Warning! Not installing FiraCode font: unknown package manager"
    ;;
esac
