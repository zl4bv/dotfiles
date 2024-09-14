#!/bin/bash

CURDIR="${HOME}/.dotfiles/modules/50-fish"

if ! command -v fish >/dev/null 2>&1; then
  echo "Installing Fish shell..."
  case "${PKG_MGR}" in
  homebrew)
    brew install fish
    ;;
  pacman)
    sudo pacman -S --noconfirm fish
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

mkdir -p "${HOME}/.config/fish"

if [ -e "${HOME}/.config/fish/config.fish" ]; then
  cp "${HOME}/.config/fish/config.fish" "${HOME}/.config/fish/config.fish.bak"
fi

rm -f "${HOME}/.config/fish/config.fish"

ln -sfn "${CURDIR}/config.fish" "${HOME}/.config/fish/config.fish"

if [ "${SHELL}" != "${binpath}" ]; then
  {
    echo "To make fish the default shell for ${USER}, run this command:"
    echo ""
    echo "   chsh -s ${binpath}"
  } >&2
fi
