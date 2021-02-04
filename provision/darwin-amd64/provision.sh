#!/bin/sh

if [ ! -d /Library/Developer/CommandLineTools ]; then
  # Install XCode Command Line Tools
  sudo xcode-select --install
  sudo xcodebuild -license accept
fi

if [ ! -f /usr/local/bin/brew ]; then
  # Install Homebrew
  curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install.sh | bash
fi

if [ -f /usr/local/bin/brew ]; then
  # Install various packages
  brew install \
    bash-completion \
    font-fira-code \
    screenfetch \
    starship \
    zsh-completion
fi
