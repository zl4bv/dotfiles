#!/bin/bash

CURDIR="${HOME}/.dotfiles/modules/50-sway"

if ! command -v sway >/dev/null 2>&1; then
  exit 0
fi

# Control display brightness
if ! command -v brightnessctl >/dev/null 2>&1; then
  case "${PKG_MGR}" in
    pacman)
      sudo pacman -S brightnessctl
      ;;
  esac
fi

# Screenshot all outputs
if ! command -v grim >/dev/null 2>&1; then
  case "${PKG_MGR}" in
    pacman)
      sudo pacman -S grim
      ;;
  esac
fi

# Screenshot regions
if ! command -v slurp >/dev/null 2>&1; then
  case "${PKG_MGR}" in
    pacman)
      sudo pacman -S slurp
      ;;
  esac
fi

rm -f "${HOME}/.config/sway/config"
rm -f "${HOME}/.config/sway/scripts"

mkdir -p "${HOME}/.config/sway"

ln -sfn "${CURDIR}/config" "${HOME}/.config/sway/config"
ln -sfn "${CURDIR}/scripts" "${HOME}/.config/sway/scripts"
