#!/bin/bash

if [[ $COLORTERM = gnome-* && $TERM = xterm ]] && infocmp gnome-256color >/dev/null 2>&1; then
  export TERM='gnome-256color';
elif infocmp xterm-256color >/dev/null 2>&1; then
  export TERM='xterm-256color';
elif [[ "$OSTYPE" == "darwin"* ]]; then
  export TERM='xterm-256color'
fi;

if [ -f "${HOME}/.cargo/bin/starship" ]; then
  eval "$("${HOME}"/.cargo/bin/starship init bash)"
  return
elif command -v starship >/dev/null 2>&1; then
  eval "$(starship init bash)"
  return
fi

_git_ps1() {
  local s='';
  local branchName='';

  # Check if the current directory is in a Git repository.
  if [ "$(git rev-parse --is-inside-work-tree &>/dev/null; echo "${?}")" == '0' ]; then

    # check if the current directory is in .git before running git checks
    if [ "$(git rev-parse --is-inside-git-dir 2> /dev/null)" == 'false' ]; then

      # Ensure the index is up to date.
      git update-index --really-refresh -q &>/dev/null;

      # Check for uncommitted changes in the index.
      if ! git diff --quiet --ignore-submodules --cached; then
        s+='+';
      fi;

      # Check for unstaged changes.
      if ! git diff-files --quiet --ignore-submodules --; then
        s+='*';
      fi;

      # Check for untracked files.
      if [ -n "$(git ls-files --others --exclude-standard)" ]; then
        s+='%';
      fi;

      # Check for stashed files.
      if git rev-parse --verify refs/stash &>/dev/null; then
        s+='$';
      fi;

    fi;

    # Get the short symbolic ref.
    # If HEAD isn’t a symbolic ref, get the short SHA for the latest commit
    # Otherwise, just give up.
    branchName="$(git symbolic-ref --quiet --short HEAD 2> /dev/null || \
      git rev-parse --short HEAD 2> /dev/null || \
      echo '(unknown)')";

    [ -n "${s}" ] && s=" ${s}";

    printf -- "%s" "${branchName}${s}";
  else
    return;
  fi;
}

fg_color1="5"
fg_color2="4"
fg_color3="2"

seq_fg_color1="\\[$(tput setaf ${fg_color1})\\]"
seq_fg_color2="\\[$(tput setaf ${fg_color2})\\]"
seq_fg_color3="\\[$(tput setaf ${fg_color3})\\]"
seq_reset="\\[$(tput sgr0)\\]"

# shellcheck disable=SC2154
seq_debian_chroot="${debian_chroot:+($debian_chroot)}"
seq_user="\\u"
seq_host="\\h"
seq_workdir="\\w"
seq_vcs=" %s"

PS1="${seq_reset}${seq_fg_color1}${seq_debian_chroot}${seq_user}@${seq_host}:${seq_fg_color3}${seq_workdir} ${seq_fg_color2}\$(_git_ps1 \"${seq_vcs}\")${seq_fg_color1}\\n\$${seq_reset} "
