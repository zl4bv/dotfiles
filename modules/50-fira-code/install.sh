#!/bin/bash

case "${PKG_MGR}" in
  homebrew)
    brew install font-fira-code
    ;;
  pacman)
    pacman -S ttf-fira-code
    ;;
esac
