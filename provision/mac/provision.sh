#!/bin/bash

if [ ! -d /Library/Developer/CommandLineTools ]; then
  # Install XCode Command Line Tools
  sudo xcode-select --install
  sudo xcodebuild -license accept
fi

if [ ! -f /usr/local/bin/brew ]; then
  # Install Homebrew
  curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install.sh | bash
fi

# install completion packages
brew install bash-completion
brew install zsh-completion

# install fonts
brew install font-fira-code

# install starship
brew install starship
