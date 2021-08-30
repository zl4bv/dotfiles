#!/bin/bash

CURDIR="${HOME}/.dotfiles/modules/50-alacritty"

if ! command -v alacritty >/dev/null 2>&1; then
  exit 0
fi

if [ -e "${HOME}/.config/alacritty.yml" ]; then
  cp "${HOME}/.config/alacritty.yml" "${HOME}/.config/alacritty.yml.bak"
fi

rm -f "${HOME}/.config/alacritty.yml"

ln -sfn "${CURDIR}/alacritty.yml" "${HOME}/.config/alacritty.yml"
