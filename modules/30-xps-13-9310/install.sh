#!/bin/bash

CURDIR="${HOME}/.dotfiles/modules/30-xps-13-9310"

if [ "${HW_MODEL}" != "XPS 13 9310" ]; then
  exit 0
fi

case "${PKG_MGR}" in
  pacman)
    sudo pacman -R xf86-video-intel
    ;;
esac

RELOAD_REQUIRED=false
if [ -f "/etc/systemd/system/keyboard-brightness.service" ]; then
  old_hash=$(shasum -a 256 "/etc/systemd/system/keyboard-brightness.service" | awk '{print $1}')
  new_hash=$(shasum -a 256 "${CURDIR}/keyboard-brightness.service" | awk '{print $1}')

  if [ "${old_hash}" != "${new_hash}" ]; then
    sudo cp "${CURDIR}/keyboard-brightness.service" "/etc/systemd/system/keyboard-brightness.service"
    RELOAD_REQUIRED=true
  fi
else
  sudo cp "${CURDIR}/keyboard-brightness.service" "/etc/systemd/system/keyboard-brightness.service"
  RELOAD_REQUIRED=true
fi

if [ "${RELOAD_REQUIRED}" = "true" ]; then
  sudo systemctl daemon-reload
  sudo systemctl enable keyboard-brightness.service
  sudo systemctl restart keyboard-brightness.service
fi
