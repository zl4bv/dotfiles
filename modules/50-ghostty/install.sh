#!/bin/bash

CURDIR="${HOME}/.dotfiles/modules/50-ghostty"

if ! command -v ghostty >/dev/null 2>&1; then
  echo "Installing Ghostty 👻..."
  case "${PKG_MGR}" in
  homebrew)
    brew install ghostty
    ;;
esac
fi

# Only continue if Ghostty is already installed
if ! command -v ghostty >/dev/null 2>&1; then
  exit 0
fi

if [ -e "${HOME}/.config/ghostty/config" ]; then
  cp "${HOME}/.config/ghostty/config" "${HOME}/.config/ghostty/config.bak"
fi

rm -f "${HOME}/.config/ghostty/config"

ln -sfn "${CURDIR}/config" "${HOME}/.config/ghostty/config"

if [ -d "${HOME}/.config/ghostty/themes" ]; then
  cp "${HOME}/.config/ghostty/themes" "${HOME}/.config/ghostty/themes.bak"
fi

ln -sfn "${CURDIR}/themes" "${HOME}/.config/ghostty/themes"
