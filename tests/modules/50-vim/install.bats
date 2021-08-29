#!/usr/bin/env bats

load ../../helpers

@test "Create symlink to vim" {
  run ./modules/50-vim/install.sh

  LINKNAME="${HOME}/.vim"
  [ -L "${LINKNAME}" ]
}

@test "Install pathogen" {
  run ./modules/50-vim/install.sh

  SCRIPT="${HOME}/.vim/autoload/pathogen.vim"
  [ -e "${SCRIPT}" ]  
}
