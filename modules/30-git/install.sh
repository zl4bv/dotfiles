#!/bin/bash

CURDIR="${HOME}/.dotfiles/modules/30-git"

if ! command -v alacritty >/dev/null 2>&1; then
  echo "Installing Git..."
  case "${PKG_MGR}" in
  homebrew)
    brew install git
    ;;
  pacman)
    pacman -S git
esac
fi

for file in gitattributes gitconfig; do
  if [ -e "${HOME}/.${file}" ]; then
    cp "${HOME}/.${file}" "${HOME}/.${file}.bak"
  fi

  rm -f "${HOME}/.${file}"

  ln -sfn "${CURDIR}/${file}" "${HOME}/.${file}"
done

touch "${HOME}/.gitconfig.local"

oldgituser="$(git config --get user.name)"
oldgitemail="$(git config --get user.email)"

if [ -z "${oldgituser}" ] && [ -z "${GIT_USER}" ]; then
  printf '%s ' 'What is your name?'
  read -r GIT_USER
fi

if [ -z "${oldgitemail}" ] && [ -z "${GIT_EMAIL}" ]; then
  printf '%s ' 'What is your email address?'
  read -r GIT_EMAIL
fi

[ -n "${GIT_USER}" ] && [ "${oldgituser}" != "${GIT_USER}" ] && git config --file "${HOME}/.gitconfig.local" user.name "${GIT_USER}"
[ -n "${GIT_EMAIL}" ] && [ "${oldgitemail}" != "${GIT_EMAIL}" ] && git config --file "${HOME}/.gitconfig.local" user.email "${GIT_EMAIL}"
