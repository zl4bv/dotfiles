#!/bin/sh

DOTFILESDIR=$(pwd)

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
fi

# configure git
ln -sfn "${DOTFILESDIR}/git/.gitattributes" "${HOME}/.gitattributes"
ln -sfn "${DOTFILESDIR}/git/.gitconfig" "${HOME}/.gitconfig"
if [ ! -e "${HOME}/.gitconfig.local" ]; then
  cat > "${HOME}/.gitconfig.local" <<-EOF
#[user]
#  name = Ben Vidulich
#  email = ben@vidulich.nz
EOF
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

# shellcheck disable=SC2039
case "${OSTYPE}" in
  darwin*)
    # configure iterm2
    mkdir -p "${HOME}/.iterm2"
    ln -sfn "${DOTFILESDIR}/.iterm2/com.googlecode.iterm2.plist" "${HOME}/.iterm2/com.googlecode.iterm2.plist"
    ;;

  *)
    ;;
esac

