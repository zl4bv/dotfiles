#!/bin/bash

CURDIR="${HOME}/.dotfiles/modules/50-vim"

case "${PKG_MGR}" in
  apt-get)
    apt-get install --yes vim
    ;;
  homebrew)
    brew install vim
    ;;
  pacman)
    pacman -S vim
    ;;
esac

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
