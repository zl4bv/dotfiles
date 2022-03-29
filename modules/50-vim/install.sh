#!/bin/bash

CURDIR="${HOME}/.dotfiles/modules/50-vim"

vimpath=$(command -v vim 2>/dev/null)
if [ -z "${vimpath}" ]; then
  echo "Installing Vim..."
  case "${PKG_MGR}" in
    apt-get)
      sudo apt-get install --yes vim
      ;;
    homebrew)
      brew install vim
      ;;
    pacman)
      sudo pacman -S vim
      ;;
  esac
elif [ "${vimpath}" = "/usr/bin/vim" ] && [ "${OS_PLATFORM}" = "mac" ] && [ "${PKG_MGR}" = "homebrew" ]; then
  echo "Substituting built-in Vim with Homebrew Vim..."
  brew install vim
fi

if [ -e "${HOME}/.vimrc" ]; then
  cp "${HOME}/.vimrc" "${HOME}/.vimrc.bak"
fi

rm -f "${HOME}/.vimrc"

ln -sfn "${CURDIR}/vimrc" "${HOME}/.vimrc"

mkdir -p "${HOME}/.vim/bundle"

if [ ! -d "${HOME}/.vim/bundle/Vundle.vim" ]; then
  git clone https://github.com/VundleVim/Vundle.vim.git "${HOME}/.vim/bundle/Vundle.vim"
  vim +PluginInstall +qall &>/dev/null
fi
