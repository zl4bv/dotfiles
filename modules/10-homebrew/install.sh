#!/bin/bash

if [ "${OS_PLATFORM}" != "mac" ]; then
  exit 0
fi

if [ ! -f /usr/local/bin/brew ]; then
  exit 0
fi

curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install.sh | bash
