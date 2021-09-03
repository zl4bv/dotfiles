#!/bin/bash

CURDIR="${HOME}/.dotfiles/modules/50-vim"

if ! command -v vim >/dev/null 2>&1; then
  case "${PKG_MGR}" in
    apt-get)
      sudo apt-get install --yes vim
      ;;
    homebrew)
      sudo brew install vim
      ;;
    pacman)
      sudo pacman -S vim
      ;;
  esac
fi

if [ -e "${HOME}/.vimrc" ]; then
  cp "${HOME}/.vimrc" "${HOME}/.vimrc.bak"
fi

rm -f "${HOME}/.vimrc"

ln -sfn "${CURDIR}/vimrc" "${HOME}/.vimrc"

mkdir -p "${HOME}/.vim/bundle"

if [ ! -d "${HOME}/.vim/bundle/Vundle.vim" ]; then
  git clone https://github.com/VundleVim/Vundle.vim.git "${HOME}/.vim/bundle/Vundle.vim"
  vim +PluginInstall +qall
fi
