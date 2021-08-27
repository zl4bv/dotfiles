#!/usr/bin/env bats

load ../../helpers

@test "Create symlink to tmux.conf" {
  run ./modules/50-tmux/install.sh

  LINKNAME="${HOME}/.tmux.conf"
  [ -L "${LINKNAME}" ]
}
