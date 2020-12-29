#!/bin/bash
# ~/.bashrc: executed by bash(1) for non-login shells.

# If not running interactively, don't do anything
case $- in
  *i*) ;;
  *) return;;
esac

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

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
if [[ -r /usr/local/bin/brew ]]; then
  prefix=$(brew --prefix)
fi

if ! shopt -oq posix; then
  if [[ -f "${prefix}/usr/share/bash-completion/bash_completion" ]]; then
    # shellcheck source=/dev/null
    source "${prefix}/usr/share/bash-completion/bash_completion"
  elif [[ -f ${prefix}/etc/bash_completion ]]; then
    # shellcheck source=/dev/null
    source "${prefix}/etc/bash_completion"
  elif [[ -f "/usr/local/etc/profile.d/bash_completion.sh" ]]; then
    # shellcheck source=/dev/null
    source "/usr/local/etc/profile.d/bash_completion.sh"
  fi
fi

# This path will only exist if Xcode Command Line Tools are installed. To
# install the tools, run:
#
#   xcode-select --install
#
if [[ -f "/Library/Developer/CommandLineTools/usr/share/git-core/git-completion.bash" ]]; then
  # shellcheck source=/dev/null
  source "/Library/Developer/CommandLineTools/usr/share/git-core/git-completion.bash"
elif [[ -f "{prefix}/etc/bash_completion.d/git-completion.bash" ]]; then
  # shellcheck source=/dev/null
  source "{prefix}/etc/bash_completion.d/git-completion.bash"
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
  # shellcheck disable=SC1091
  [ -s "/usr/local/opt/nvm/etc/bash_completion" ] && . "/usr/local/opt/nvm/etc/bash_completion"  # This loads nvm bash_completion
fi

# Configure rust/cargo
if [ -f "${HOME}/.cargo/env" ]; then
  # shellcheck source=/dev/null
  source "${HOME}/.cargo/env"
fi
