#!/bin/bash

if [ "${HW_MODEL}" != "XPS 13 9310" ]; then
  exit 0
fi

case "${PKG_MGR}" in
  pacman)
    sudo pacman -R xf86-video-intel
    ;;
esac
