#!/bin/bash

CURDIR=$(pwd)

# configure git
#ln -fn ${CURDIR}/.gitignore ${HOME}/.gitignore;
git update-index --skip-worktree "${CURDIR}/.gitconfig"

# add aliases for dotfiles
# shellcheck disable=SC2044
for file in $(find "${CURDIR}" -name ".*" -not -name ".gitignore" -not -name ".travis.yml" -not -name ".git" -not -name ".*.swp" -not -name ".gnupg" -not -name ".iterm2"); do
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

# configure iterm2
if [[ "${OSTYPE}" == "darwin"* ]]; then
  mkdir -p "${HOME}/.iterm2"
  ln -sfn "${CURDIR}/.iterm2/com.googlecode.iterm2.plist" "${HOME}/.iterm2/com.googlecode.iterm2.plist"
fi
