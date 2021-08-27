#!/bin/bash

CURDIR="${HOME}/.dotfiles/modules/50-bash"

case "${PKG_MGR}" in
  homebrew)
    brew install bash-completion
    ;;
esac

for file in bash_profile bashrc; do
  if [ -e "${HOME}/.${file}" ]; then
    cp "${HOME}/.${file}" "${HOME}/.${file}.bak"
  fi

  rm -f "${HOME}/.${file}"

  ln -sfn "${CURDIR}/${file}.sh" "${HOME}/.${file}"
done
