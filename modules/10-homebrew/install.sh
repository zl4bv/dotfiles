#!/bin/bash

if [ "${OS_PLATFORM}" != "mac" ]; then
  exit 0
fi

if [ -e /usr/local/bin/brew ] || [ -e /opt/homebrew/bin/brew ]; then
  exit 0
fi

echo "Installing Homebrew..."
curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install.sh | bash
