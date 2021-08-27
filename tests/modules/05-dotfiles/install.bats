#!/usr/bin/env bats

load ../../helpers

@test "Create symlink to dotfiles dir" {
  run ./modules/05-dotfiles/install.sh

  LINKNAME="${HOME}/.dotfiles"
  [ -L "${LINKNAME}" ]
}

@test "Update symlink to dotfiles dir" {
  LINKNAME="${HOME}/.dotfiles"
  ELSEWHERE="$(mktemp -d)"
  ln -sn "${ELSEWHERE}" "${LINKNAME}"

  run ./modules/05-dotfiles/install.sh

  realdir="$(cd "${LINKNAME}" && pwd -P)"
  [ "${realdir}" = "${DOTFILESDIR}" ]

  rm -rf "${ELSEWHERE}"
}
