#!/bin/bash

CURDIR="${HOME}/.dotfiles/modules/50-bash"

if [ -n "$(declare -F __git_complete)" ]; then
  echo "Installing bash-completion..."
  case "${PKG_MGR}" in
    homebrew)
      brew install bash-completion
      ;;
  esac
fi

for file in bash_profile bashrc; do
  if [ -e "${HOME}/.${file}" ]; then
    cp "${HOME}/.${file}" "${HOME}/.${file}.bak"
  fi

  rm -f "${HOME}/.${file}"

  ln -sfn "${CURDIR}/${file}.sh" "${HOME}/.${file}"
done
