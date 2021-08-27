#!/bin/bash

CURDIR="${HOME}/.dotfiles/modules/50-zsh"

case "${PKG_MGR}" in
  homebrew)
    brew install zsh-completion
    ;;
esac

for file in zlogin zshrc; do
  if [ -e "${HOME}/.${file}" ]; then
    cp "${HOME}/.${file}" "${HOME}/.${file}.bak"
  fi

  rm -f "${HOME}/.${file}"

  ln -sfn "${CURDIR}/${file}.zsh" "${HOME}/.${file}"
done
