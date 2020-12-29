#!/bin/sh

DOTFILESDIR=$(cat "${HOME}/.dotfiles_path")

# dotfiles
export PATH="${PATH}:${DOTFILESDIR}/bin"

# go path
[ -d "${HOME}/go" ] && export GOPATH="${HOME}/go"
[ -d "${HOME}/go/bin" ] && export PATH="${PATH}:${GOPATH}/bin"

# cargo path
[ -d "${HOME}/.cargo/bin" ] && export PATH="${PATH}:${HOME}/.cargo/bin"

# update path for VS code
[ -d "/Applications/Visual Studio Code.app" ] && export PATH="${PATH}:/Applications/Visual Studio Code.app/Contents/Resources/app/bin"
[ -d "/Applications/Visual Studio Code - Insiders.app" ] && export PATH="${PATH}:/Applications/Visual Studio Code - Insiders.app/Contents/Resources/app/bin"
