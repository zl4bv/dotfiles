#!/bin/sh

# Always enable colored `grep` output
alias grep='grep --color=auto '

# Enable aliases to be sudo’ed
alias sudo='sudo '

# OS X has no `md5sum`, so use `md5` as a fallback
command -v md5sum > /dev/null || alias md5sum="md5"

# OS X has no `sha1sum`, so use `shasum` as a fallback
command -v sha1sum > /dev/null || alias sha1sum="shasum"

# Check for package managers
for mgr in apt-get brew; do
  if command -v $mgr >/dev/null 2>&1; then
    # shellcheck disable=SC2139
    alias canihaz="$mgr install";
    break;
  fi
done

# https://github.com/zl4bv/aws-session-credentials
alias amfa='aws-session new --mfa-code '
alias ar='aws-session assume-role --role-alias '

# Atom
alias aa='atom -a '

alias ll='ls -la '
