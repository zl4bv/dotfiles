#!/usr/bin/env bats

load ../../helpers

@test "Create symlink to zlogin" {
  run ./modules/50-zsh/install.sh

  LINKNAME="${HOME}/.zlogin"
  [ -L "${LINKNAME}" ]
}

@test "Check symlink to zlogin is not broken" {
  run ./modules/05-dotfiles/install.sh
  run ./modules/50-zsh/install.sh

  LINKNAME="${HOME}/.zlogin"
  [ -e "${LINKNAME}" ]
}

@test "Create symlink to zshrc" {
  run ./modules/50-zsh/install.sh

  LINKNAME="${HOME}/.zshrc"
  [ -L "${LINKNAME}" ]
}

@test "Check symlink to zshrc is not broken" {
  run ./modules/05-dotfiles/install.sh
  run ./modules/50-zsh/install.sh

  LINKNAME="${HOME}/.zshrc"
  [ -e "${LINKNAME}" ]
}
