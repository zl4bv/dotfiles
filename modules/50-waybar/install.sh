#!/bin/bash

CURDIR="${HOME}/.dotfiles/modules/50-waybar"

if ! command -v waybar >/dev/null 2>&1; then
  exit 0
fi

# Audio controls
if ! command -v pavucontrol >/dev/null 2>&1; then
  case "${PKG_MGR}" in
    pacman)
      sudo pacman -S pavucontrol
      ;;
  esac
fi

# Bluetooth
if ! command -v blueberry >/dev/null 2>&1; then
  case "${PKG_MGR}" in
    pacman)
      sudo pacman -S blueberry
      ;;
  esac
fi

# Need Font Awesome for icons
if [ ! -f "/usr/share/fonts/OTF/Font Awesome 5 Free-Regular-400.otf" ]; then
  case "${PKG_MGR}" in
    pacman)
      sudo pacman -S otf-font-awesome
      ;;
  esac
fi

rm -f "${HOME}/.config/waybar/config"
rm -f "${HOME}/.config/waybar/custom"
rm -f "${HOME}/.config/waybar/mediaplayer.sh"
rm -f "${HOME}/.config/waybar/style.css"

mkdir -p "${HOME}/.config/waybar"

ln -sfn "${CURDIR}/config" "${HOME}/.config/waybar/config"
ln -sfn "${CURDIR}/custom" "${HOME}/.config/waybar/custom"
ln -sfn "${CURDIR}/mediaplayer.sh" "${HOME}/.config/waybar/mediaplayer.sh"
ln -sfn "${CURDIR}/style.css" "${HOME}/.config/waybar/style.css"
