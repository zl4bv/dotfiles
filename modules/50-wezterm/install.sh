#!/bin/bash

CURDIR="${HOME}/.dotfiles/modules/50-wezterm"

if ! command -v wezterm >/dev/null 2>&1; then
  echo "Installing Wezterm..."
  case "${PKG_MGR}" in
  homebrew)
    brew install wezterm
    ;;
esac
fi

# Only continue if WezTerm is already installed
if ! command -v wezterm >/dev/null 2>&1; then
  exit 0
fi


if [ -e "${HOME}/.wezterm.lua" ]; then
  cp "${HOME}/.wezterm.lua" "${HOME}/.wezterm.lua.bak"
fi

rm -f "${HOME}/.wezterm.lua"

ln -sfn "${CURDIR}/.wezterm.lua" "${HOME}/.wezterm.lua"
