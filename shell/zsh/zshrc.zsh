#!/bin/zsh

DOTFILESDIR=$(cat "${HOME}/.dotfiles_path")

# Load the shell dotfiles, and then some:
for file in $HOME/.zsh_extra ${DOTFILESDIR}/shell/zsh/zshprompt.sh ${DOTFILESDIR}/shell/_common/*.sh; do
  if [[ -r "${file}" ]] && [[ -f "${file}" ]]; then
    # shellcheck source=/dev/null
    source "${file}"
  fi
done
unset file

if [[ -r /usr/local/bin/brew ]]; then
  prefix=$(brew --prefix)
fi

if [[ -f "{prefix}/share/zsh-completions" ]]; then
  FPATH="$(brew --prefix)/share/zsh-completions:${FPATH}"
  autoload -Uz compinit
  compinit
fi

unset prefix

# Configure kubernetes
for file in /usr/local/bin/{kubeadm,kubectl,kops}; do
  if [[ -x "${file}" ]]; then
    # shellcheck source=/dev/null
    source <(${file} completion "$(basename "${SHELL}")")
  fi
done
unset file

# Configure nodejs/nvm
if [ -f /usr/local/opt/nvm/nvm.sh ]; then
  mkdir -p "${HOME}/.nvm"
  export NVM_DIR="$HOME/.nvm"
  # shellcheck disable=SC1091
  [ -s "/usr/local/opt/nvm/nvm.sh" ] && . "/usr/local/opt/nvm/nvm.sh"  # This loads nvm
fi

# Configure rust/cargo
if [ -f "${HOME}/.cargo/env" ]; then
  source "${HOME}/.cargo/env"
fi
