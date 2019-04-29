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
  if [[ -f $prefix/usr/share/bash-completion/bash_completion ]]; then
    # shellcheck source=/dev/null
    . $prefix/usr/share/bash-completion/bash_completion
  elif [[ -f $prefix/etc/bash_completion ]]; then
    # shellcheck source=/dev/null
    . $prefix/etc/bash_completion
  fi
fi
unset prefix

if [[ -f /Library/Developer/CommandLineTools/usr/share/git-core/git-completion.bash ]]; then
  # shellcheck source=/dev/null
  source /Library/Developer/CommandLineTools/usr/share/git-core/git-completion.bash
fi

# the 'bash-completion' package needs to be installed
if [ -f "$(brew --prefix)/etc/bash_completion" ]; then
  # shellcheck source=/dev/null
  source "$(brew --prefix)/etc/bash_completion"
fi

for file in /usr/local/bin/{kubeadm,kubectl,kops}; do
  if [[ -x "${file}" ]]; then
    # shellcheck source=/dev/null
    source <(${file} completion $(basename "${SHELL}"))
  fi
done
unset file

if command -v gpg >/dev/null 2>&1; then
  # use a tty for gpg
  # solves error: "gpg: signing failed: Inappropriate ioctl for device"
  GPG_TTY="$(tty)"
  export GPG_TTY

  # Start the gpg-agent if not already running
  if ! pgrep -x -u "${USER}" gpg-agent >/dev/null 2>&1; then
    gpg-connect-agent /bye >/dev/null 2>&1
    gpg-connect-agent updatestartuptty /bye >/dev/null
  fi

  # Set SSH to use gpg-agent
  unset SSH_AGENT_PID
  if [ "${gnupg_SSH_AUTH_SOCK_by:-0}" -ne $$ ]; then
    SSH_AUTH_SOCK="$(gpgconf --list-dirs agent-ssh-socket)"
    export SSH_AUTH_SOCK
  fi

  # add alias for ssh to update the tty
  alias ssh="gpg-connect-agent updatestartuptty /bye >/dev/null; ssh"
fi
