#!/bin/bash

CURDIR="${HOME}/.dotfiles/modules/50-tmux"

case "${PKG_MGR}" in
  apt-get)
    apt-get install --yes tmux
    ;;
  homebrew)
    brew install tmux
    ;;
  pacman)
    pacman -S tmux
    ;;
esac

if [ -e "${HOME}/.tmux.conf" ]; then
  cp "${HOME}/.tmux.conf" "${HOME}/.tmux.conf.bak"
fi

rm -f "${HOME}/.tmux.conf"

ln -sfn "${CURDIR}/tmux.conf" "${HOME}/.tmux.conf"
