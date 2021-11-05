#!/bin/sh

# Always enable colored `grep` output
alias grep='grep --color=auto'

# Enable aliases to be sudo’ed
alias sudo='sudo '

# OS X has no `md5sum`, so use `md5` as a fallback
command -v md5sum > /dev/null || alias md5sum="md5"

# OS X has no `sha1sum`, so use `shasum` as a fallback
command -v sha1sum > /dev/null || alias sha1sum="shasum"

# Fast install
if command -v apt-get > /dev/null; then
  alias canihaz='apt-get install --yes'
elif command -v brew > /dev/null; then
  alias canihaz='brew install'
elif command -v pacman > /dev/null; then
  alias canihaz='pacman -S'
fi

# Manage AWS credentials
# https://github.com/zl4bv/aws-session-credentials
if command -v aws-session > /dev/null; then
  alias amfa='aws-session new --mfa-code'
  alias ar='aws-session assume-role --role-alias'
fi

# Open in Atom editor
if command -v atom > /dev/null; then
  alias aa='atom -a'
fi

# Long directory listing
if command -v exa > /dev/null; then
  alias ll='exa -la'
else
  alias ll='ls -la'
fi

# Reload waybar
if command -v waybar > /dev/null; then
  alias reloadwaybar='killall -SIGUSR2 waybar'
  alias togglewaybar='killall -SIGUSR1 waybar'
fi
