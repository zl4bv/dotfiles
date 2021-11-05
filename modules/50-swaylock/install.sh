#!/bin/bash

CURDIR="${HOME}/.dotfiles/modules/50-swaylock"

if ! command -v swaylock >/dev/null 2>&1; then
  exit 0
fi

rm -f "${HOME}/.config/swaylock/config"

mkdir -p "${HOME}/.config/swaylock"

ln -sfn "${CURDIR}/config" "${HOME}/.config/swaylock/config"
