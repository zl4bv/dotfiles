#!/bin/bash

CURDIR="${HOME}/.dotfiles/modules/50-mako"

if ! command -v mako >/dev/null 2>&1; then
  exit 0
fi

rm -f "${HOME}/.config/mako/config"

mkdir -p "${HOME}/.config/mako"

ln -sfn "${CURDIR}/config" "${HOME}/.config/mako/config"
