#!/bin/sh

DOTFILESDIR=$(cat "${HOME}/.dotfiles_path")

# dotfiles
export PATH="${PATH}:${DOTFILESDIR}/bin"

# go path
export GOPATH="${HOME}/go"

# update path for go binaries
export PATH="${PATH}:${GOPATH}/bin"

# update path for VS code
export PATH="${PATH}:/Applications/Visual Studio Code.app/Contents/Resources/app/bin"
export PATH="${PATH}:/Applications/Visual Studio Code - Insiders.app/Contents/Resources/app/bin"
