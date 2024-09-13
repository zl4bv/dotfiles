#!/bin/bash

CURDIR="${HOME}/.dotfiles/modules/50-fish"

if ! command -v fish >/dev/null 2>&1; then
  echo "Installing Fish shell..."
  case "${PKG_MGR}" in
  homebrew)
    brew install fish
    ;;
esac
fi

# Only continue if Fish is already installed
if ! command -v fish >/dev/null 2>&1; then
  exit 0
fi

binpath=$(command -v fish)
if ! grep -q "${binpath}" /etc/shells; then
  echo "${binpath}" | sudo tee -a /etc/shells
fi

if [ -e "${HOME}/.config/fish/config.fish" ]; then
  cp "${HOME}/.config/fish/config.fish" "${HOME}/.config/fish/config.fish.bak"
fi

rm -f "${HOME}/.config/fish/config.fish"

ln -sfn "${CURDIR}/config.fish" "${HOME}/.config/fish/config.fish"
