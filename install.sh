#!/bin/bash

DOTFILESDIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"

# shellcheck disable=SC1090
source "${DOTFILESDIR}/detect-os.sh"

printf '%s' "${DOTFILESDIR}" > "${HOME}/.dotfiles_path"

# Remove legacy symlinks
if [ -n "${ZL4BV_TIDY}" ]; then
  [ -L "${HOME}/.aliases" ] && rm -f "${HOME}/.aliases"
  [ -L "${HOME}/.bash_profile" ] && rm -f "${HOME}/.bash_profile"
  [ -L "${HOME}/.bash_prompt" ] && rm -f "${HOME}/.bash_prompt"
  [ -L "${HOME}/.bashrc" ] && rm -f "${HOME}/.bashrc"
  [ -L "${HOME}/.dockerfunc" ] && rm -f "${HOME}/.dockerfunc"
  [ -L "${HOME}/.exports" ] && rm -f "${HOME}/.exports"
  [ -L "${HOME}/.gitconfig" ] && rm -f "${HOME}/.gitconfig"
  [ -L "${HOME}/.gnupg/gpg-agent.conf" ] && rm -f "${HOME}/.gnupg/gpg-agent.conf"
  [ -L "${HOME}/.gnupg/gpg.conf" ] && rm -f "${HOME}/.gnupg/gpg.conf"
  [ -L "${HOME}/.path" ] && rm -f "${HOME}/.path"
  [ -L "${HOME}/.tmux.conf" ] && rm -f "${HOME}/.tmux.conf"
  [ -L "${HOME}/.config/starship.toml" ] && rm -f "${HOME}/.config/starship.toml"
fi

# configure git
ln -sfn "${DOTFILESDIR}/git/.gitattributes" "${HOME}/.gitattributes"
ln -sfn "${DOTFILESDIR}/git/.gitconfig" "${HOME}/.gitconfig"
touch "${HOME}/.gitconfig.local"

GITUSER="$(git config --get user.name)"
GITEMAIL="$(git config --get user.email)"

if [ -z "${GITUSER}" ]; then
  printf '%s ' 'What is your name (for git)?'
  read -r GITUSER
  git config --file "${HOME}/.gitconfig.local" user.name "${GITUSER}"
fi

if [ -z "${GITEMAIL}" ]; then
  printf '%s ' 'What is your email address (for git)?'
  read -r GITEMAIL
  git config --file "${HOME}/.gitconfig.local" user.email "${GITEMAIL}"
fi

# configure bash
if [ -f /bin/bash ]; then
  ln -sfn "${DOTFILESDIR}/shell/bash/bashrc.sh" "${HOME}/.bashrc"
  ln -sfn "${DOTFILESDIR}/shell/bash/bash_profile.sh" "${HOME}/.bash_profile"
  touch "${HOME}/.bash_extra"
fi

# configure zsh
if [ -f /bin/zsh ]; then
  ln -sfn "${DOTFILESDIR}/shell/zsh/zshrc.zsh" "${HOME}/.zshrc"
  ln -sfn "${DOTFILESDIR}/shell/zsh/zlogin.zsh" "${HOME}/.zlogin"
  touch "${HOME}/.zsh_extra"
fi

if [ "${OS_PLATFORM}" == "mac" ]; then
  # configure iterm2
  mkdir -p "${HOME}/.iterm2"
  ln -sfn "${DOTFILESDIR}/.iterm2/com.googlecode.iterm2.plist" "${HOME}/.iterm2/com.googlecode.iterm2.plist"
fi

# configure starship
mkdir -p "${HOME}/.config"
ln -sfn "${DOTFILESDIR}/starship/starship.toml" "${HOME}/.config/starship.toml"

# configure tmux
ln -sfn "${DOTFILESDIR}/tmux/.tmux.conf" "${HOME}/.tmux.conf"
