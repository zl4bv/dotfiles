#!/bin/bash

CURDIR=$(pwd)

# configure git
#ln -fn ${CURDIR}/.gitignore ${HOME}/.gitignore;
git update-index --skip-worktree "${CURDIR}/.gitconfig;"

# install homebrew
if [ "$(uname -s)" != "Darwin" ]; then
  /usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
fi

# add aliases for dotfiles
for file in $(shell find "${CURDIR}" -name ".*" -not -name ".gitignore" -not -name ".travis.yml" -not -name ".git" -not -name ".*.swp" -not -name ".gnupg"); do
  f=$(basename "${file}")
  ln -sfn "${file}" "${HOME}/${f}"
done

# configure gnupg
if command -v gpg >/dev/null 2>&1; then
  gpg --list-keys || true
  mkdir -p "${CURDIR}/.gnupg"
  ln -sfn "${CURDIR}/.gnupg/gpg.conf" "${HOME}/.gnupg/gpg.conf"
  ln -sfn "${CURDIR}/.gnupg/gpg-agent.conf" "${HOME}/.gnupg/gpg-agent.conf"
fi
