#!/bin/bash

if [[ "$OSTYPE" == "darwin"* ]]; then
  # accept xcode license to enable git usage
  sudo xcodebuild -license accept

  # install homebrew
  if ! command -v gpg >/dev/null 2>&1; then
    /usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
  fi

  brew install bash-completion
fi