#!/usr/bin/env bats

load ../../helpers

@test "Create symlink to bashrc" {
  run ./modules/50-bash/install.sh

  LINKNAME="${HOME}/.bashrc"
  [ -L "${LINKNAME}" ]
}

@test "Check symlink to bashrc is not broken" {
  run ./modules/05-dotfiles/install.sh
  run ./modules/50-bash/install.sh

  LINKNAME="${HOME}/.bashrc"
  [ -e "${LINKNAME}" ]
}

@test "Create symlink to bash_profile" {
  run ./modules/50-bash/install.sh

  LINKNAME="${HOME}/.bash_profile"
  [ -L "${LINKNAME}" ]
}

@test "Check symlink to bash_profile is not broken" {
  run ./modules/05-dotfiles/install.sh
  run ./modules/50-bash/install.sh

  LINKNAME="${HOME}/.bash_profile"
  [ -e "${LINKNAME}" ]
}
