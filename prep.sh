#!/bin/sh

# shellcheck disable=SC2039
case "${OSTYPE}" in
  darwin*)
    # accept xcode license to enable git usage
    sudo xcodebuild -license accept

    # install homebrew
    if ! command -v gpg >/dev/null 2>&1; then
      /usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
    fi

    # install completion packages
    brew install bash-completion
    brew install zsh-completion

    # install starship
    brew install starship
    ;;

  linux*)
    # install starship
    curl -fsSL https://starship.rs/install.sh | bash
    ;;

  *)
    ;;
esac
