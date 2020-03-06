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

for file in /usr/local/bin/{kubeadm,kubectl,kops}; do
  if [[ -x "${file}" ]]; then
    # shellcheck source=/dev/null
    source <(${file} completion "$(basename "${SHELL}")")
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

if [ -f /usr/local/opt/nvm/nvm.sh ]; then
  mkdir -p "${HOME}/.nvm"
  export NVM_DIR="$HOME/.nvm"
  # shellcheck disable=SC1091
  [ -s "/usr/local/opt/nvm/nvm.sh" ] && . "/usr/local/opt/nvm/nvm.sh"  # This loads nvm
  # shellcheck disable=SC1091
  [ -s "/usr/local/opt/nvm/etc/bash_completion" ] && . "/usr/local/opt/nvm/etc/bash_completion"  # This loads nvm bash_completion
fi

getcsp() {
  local url
  local red
  local green
  local reset
  local header
  url=${1}
  red=$(tput setaf 1)
  green=$(tput setaf 2)
  reset=$(tput sgr0)
  if [[ -z "${url}" ]]; then
    echo "Usage: getcsp url" >&2
    return
  fi
  resp=$(curl -sv "${url}" 2>&1)
  header=$(echo "${resp}" | grep content-security-policy | awk '{gsub(/^< /,"")}1')
  if [[ -z "${header}" ]]; then
    echo "CSP header not present. There might be a reason in the following output: " >&2
    echo "${resp}" | grep --color=never "^*\|<\|>"
    return
  fi
  echo "${header}" | grep -oE "content-security-policy(-report-only)?" | awk '{if ($0 == "content-security-policy-report-only") {print "report"} else {print "enforce"}}' | sed -E "s/^[a-z]+/${red}disposition${reset} &/g"
  echo "${header}" | awk '{gsub(/content-security-policy(-report-only)?: ?/,"")}1' | awk '{gsub(/; /,";\n")}1' | sed -E "s/^[a-z-]+/${green}&${reset}/g" | sort
  unset url
  unset red
  unset green
  unset reset
  unset header
}

repeat() {
  cmd=${@}
  repeatinterval=${repeatinterval:-1}
  TIMEFORMAT=%R
  while true; do
    unset t_std t_err
    eval "$( (time sh -c "${cmd}") \
      2> >(t_err=$(cat); typeset -p t_err) \
       > >(t_std=$(cat); typeset -p t_std) )"
    echo "[$(date +"%T %Z")][${t_err}s] ${t_std}"
    sleep "${repeatinterval}"
  done
  unset TIMEFORMAT
}

certsans() {
  target=${1}
  if [[ "${target}" == "" ]]; then
    echo "Usage: certsans host:port" >&2
    return
  fi
  echo "QUIT" | openssl s_client -connect "${target}" 2>&1 | openssl x509 -noout -text | grep "DNS:" | sed "s/DNS://g" | awk '{$1=$1};1'
}

certocspuri() {
  target=${1}
  if [[ "${target}" == "" ]]; then
    echo "Usage: certocspuri host:port" >&2
    return
  fi
  echo "QUIT" | openssl s_client -connect "${target}" 2>&1 | openssl x509 -noout -ocsp_uri
}
