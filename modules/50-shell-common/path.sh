#!/bin/sh

appendpath() {
  entry="${1}"

  if [ ! -d "${entry}" ]; then
    return
  fi

  case "${PATH}" in
    *$entry*)
      ;;
    *)
      export PATH="${PATH}:${entry}"
      ;;
  esac

  unset entry
}

prependpath() {
  entry="${1}"

  if [ ! -d "${entry}" ]; then
    return
  fi

  case "${PATH}" in
    *$entry*)
      ;;
    *)
      export PATH="${entry}:${PATH}"
      ;;
  esac

  unset entry
}

prependpath "${HOME}/bin"

# dotfiles
prependpath "${HOME}/.dotfiles/bin"

# go path
[ -d "${HOME}/go" ] && export GOPATH="${HOME}/go"
prependpath "${GOPATH}/bin"
prependpath "/usr/local/go/bin"

# cargo path
prependpath "${HOME}/.cargo/bin"

# Kate - macOS
appendpath "/Applications/kate.app/Contents/MacOS"

# VS code - macOS
appendpath "/Applications/Visual Studio Code.app/Contents/Resources/app/bin"
appendpath "/Applications/Visual Studio Code - Insiders.app/Contents/Resources/app/bin"
