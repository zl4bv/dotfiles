#!/usr/bin/env bats

load ../../helpers

export GIT_USER="example"
export GIT_EMAIL="example@example.com"

@test "Create symlink to gitattributes" {
  run ./modules/30-git/install.sh

  LINKNAME="${HOME}/.gitattributes"
  [ -L "${LINKNAME}" ]
}

@test "Create symlink to gitconfig" {
  run ./modules/30-git/install.sh

  LINKNAME="${HOME}/.gitconfig"
  [ -L "${LINKNAME}" ]
}

@test "Create local gitconfig" {
  run ./modules/30-git/install.sh

  LINKNAME="${HOME}/.gitconfig.local"
  [ -e "${LINKNAME}" ]
}

@test "Set git user name" {
  run ./modules/30-git/install.sh

  grep -q "name = ${GIT_USER}" "${HOME}/.gitconfig.local"
}

@test "Set git user email" {
  run ./modules/30-git/install.sh

  grep -q "email = ${GIT_EMAIL}" "${HOME}/.gitconfig.local"
}
