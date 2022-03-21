#!/bin/bash

CURDIR="${HOME}/.dotfiles/modules/50-tmux"

if ! command -v tmux >/dev/null 2>&1; then
  echo "Installing Tmux..."
  case "${PKG_MGR}" in
    apt-get)
      sudo apt-get install --yes tmux
      ;;
    homebrew)
      brew install tmux
      ;;
    pacman)
      sudo pacman -S tmux
      ;;
  esac
fi

if [ -e "${HOME}/.tmux.conf" ]; then
  cp "${HOME}/.tmux.conf" "${HOME}/.tmux.conf.bak"
fi

rm -f "${HOME}/.tmux.conf"

ln -sfn "${CURDIR}/tmux.conf" "${HOME}/.tmux.conf"

mkdir -p "${HOME}/.tmux/plugins"

if [ ! -d "${HOME}/.tmux/plugins/tpm" ]; then
  git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
  "${HOME}"/.tmux/plugins/tpm/bin/install_plugins
fi
