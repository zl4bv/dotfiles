#!/bin/bash

DOTFILESDIR=$(cat "${HOME}/.dotfiles_path")

if [[ "${OSTYPE}" == "darwin"* ]] && [[ -r "${HOME}/.bashrc" ]]; then
  # shellcheck source=/dev/null
  . "${HOME}/.bashrc"
fi

# Load the shell dotfiles, and then some:
for file in $HOME/.bash_extra "${DOTFILESDIR}"/shell/bash/bash_prompt.sh "${DOTFILESDIR}"/shell/_common/*.sh; do
  if [[ -r "${file}" ]] && [[ -f "${file}" ]]; then
    # shellcheck source=/dev/null
    source "${file}"
  fi
done
unset file

# Append to the Bash history file, rather than overwriting it
shopt -s histappend

# Add tab completion for SSH hostnames based on ~/.ssh/config
# ignoring wildcards
[[ -e "${HOME}/.ssh/config" ]] && complete -o "default" \
  -o "nospace" \
  -W "$(grep "^Host" ~/.ssh/config | \
  grep -v "[?*]" | cut -d " " -f2 | \
  tr ' ' '\n')" scp sftp ssh
