#!/bin/bash
# ~/.bashrc: executed by bash(1) for non-login shells.s

# If not running interactively, don't do anything
case $- in
  *i*) ;;
  *) return;;
esac

# Suppress "The default interactive shell is now zsh" in macOS
# https://apple.stackexchange.com/a/371998
export BASH_SILENCE_DEPRECATION_WARNING=1

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

# Append to the Bash history file, rather than overwriting it
shopt -s histappend

# set variable identifying the chroot you work in (used in the prompt below)
if [ -z "${debian_chroot:-}" ] && [ -r /etc/debian_chroot ]; then
  debian_chroot=$(cat /etc/debian_chroot)
fi

# If this is an xterm set the title to user@host:dir
case "$TERM" in
  xterm*|rxvt*)
    PS1="\\[\\e]0;${debian_chroot:+($debian_chroot)}\\u@\\h: \\w\\a\\]$PS1"
    ;;
  *)
    ;;
esac

# enable color support of ls and also add handy aliases
if [ -x /usr/bin/dircolors ]; then
  # shellcheck disable=SC2015
  test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
  alias ls='ls --color=auto'
  alias dir='dir --color=auto'
  alias vdir='vdir --color=auto'

  alias grep='grep --color=auto'
  alias fgrep='fgrep --color=auto'
  alias egrep='egrep --color=auto'
fi

# enable programmable completion features (you don't need to enable
# this, if it's already enabled in /etc/bash.bashrc and /etc/profile
# sources /etc/bash.bashrc).
if [[ -r /opt/homebrew/bin/brew ]]; then
  # M1
  export HOMEBREW_PREFIX="/opt/homebrew";
  export HOMEBREW_CELLAR="/opt/homebrew/Cellar";
  export HOMEBREW_REPOSITORY="/opt/homebrew";
  export PATH="/opt/homebrew/bin:/opt/homebrew/sbin${PATH+:$PATH}";
  export MANPATH="/opt/homebrew/share/man${MANPATH+:$MANPATH}:";
  export INFOPATH="/opt/homebrew/share/info:${INFOPATH:-}";
elif [[ -r /usr/local/bin/brew ]]; then
  # Intel
  export HOMEBREW_PREFIX="/usr/local";
  export HOMEBREW_CELLAR="/usr/local/Cellar";
  export HOMEBREW_REPOSITORY="/usr/local/Homebrew";
  export PATH="/usr/local/bin:/usr/local/sbin${PATH+:$PATH}";
  export MANPATH="/usr/local/share/man${MANPATH+:$MANPATH}:";
  export INFOPATH="/usr/local/share/info:${INFOPATH:-}";
fi

if ! shopt -oq posix; then
  if [[ -n "${HOMEBREW_PREFIX}" ]]; then
    # shellcheck source=/dev/null
    [[ -f "${HOMEBREW_PREFIX}/etc/profile.d/bash_completion.sh" ]] && source "${HOMEBREW_PREFIX}/etc/profile.d/bash_completion.sh"
    # shellcheck source=/dev/null
    [[ -f "${HOMEBREW_PREFIX}/usr/share/bash-completion/bash_completion" ]] && source "${HOMEBREW_PREFIX}/usr/share/bash-completion/bash_completion"
  fi

  # shellcheck source=/dev/null
  [[ -f "/etc/profile.d/bash_completion.sh" ]] && source "/etc/profile.d/bash_completion.sh"

  # shellcheck source=/dev/null
  [[ -f "/usr/share/bash-completion/bash_completion" ]] && source "/usr/share/bash-completion/bash_completion"
fi

# Add tab completion for SSH hostnames based on ~/.ssh/config
# ignoring wildcards
[[ -e "${HOME}/.ssh/config" ]] && complete -o "default" \
  -o "nospace" \
  -W "$(grep "^Host" ~/.ssh/config | \
  grep -v "[?*]" | cut -d " " -f2 | \
  tr ' ' '\n')" scp sftp ssh

# Configure kubernetes
for tool in kubeadm kubectl kops; do
  if command -v ${tool} >/dev/null 2>&1; then
    # shellcheck source=/dev/null
    source <(${tool} completion "$(basename "${SHELL}")")
  fi
done
unset file

# Configure nodejs/nvm
if [ -d "${HOMEBREW_PREFIX}/opt/nvm" ]; then
  NVM_DIR="${HOMEBREW_PREFIX}/opt/nvm"
elif [ -d "${HOME}/.nvm" ]; then
  NVM_DIR="${HOME}/.nvm"
fi
export NVM_DIR

lazynvm() {
  unset -f nvm node npm npx pnpm yarn
  # shellcheck source=/dev/null
  [ -s "${NVM_DIR}/nvm.sh" ] && . "${NVM_DIR}/nvm.sh"  # This loads nvm
  # shellcheck source=/dev/null
  [ -s "${NVM_DIR}/bash_completion" ] && . "${NVM_DIR}/bash_completion"  # This loads nvm bash_completion
}

if [ -n "${NVM_DIR}" ] && [ -d "${NVM_DIR}" ]; then
  nvm() {
    lazynvm
    nvm "$@"
  }
  node() {
    lazynvm
    node "$@"
  }
  npm() {
    lazynvm
    npm "$@"
  }
  npx() {
    lazynvm
    npx "$@"
  }
  pnpm() {
    lazynvm
    pnpm "$@"
  }
  yarn() {
    lazynvm
    yarn "$@"
  }
fi

# Configure rust/cargo
if [ -f "${HOME}/.cargo/env" ]; then
  # shellcheck source=/dev/null
  source "${HOME}/.cargo/env"
fi

# Load the shell dotfiles, and then some:
for file in "${HOME}"/.bash_extra "${HOME}"/.dotfiles/modules/50-bash/bash_prompt.sh "${HOME}"/.dotfiles/modules/50-shell-common/*.sh; do
  if [[ -r "${file}" ]] && [[ -f "${file}" ]]; then
    # shellcheck source=/dev/null
    source "${file}"
  fi
done
unset file

export PATH="$HOME/.yarn/bin:$HOME/.config/yarn/global/node_modules/.bin:$PATH"

if ! type -P docker >/dev/null 2>&1; then
  if command -v colima >/dev/null 2>&1; then
    alias docker="colima nerdctl --"
  elif command -v lima >/dev/null 2>&1; then
    alias docker="lima nerdctl"
    # shellcheck source=/dev/null
    source <(limactl completion bash)
  fi
fi

if command -v colima >/dev/null 2>&1 && [ -S "${HOME}/.colima/default/docker.sock" ]; then
  export DOCKER_HOST="unix://${HOME}/.colima/default/docker.sock"
fi

# Hide any failures above from prompts that check exit code
[[ -f /bin/true ]] && /bin/true
