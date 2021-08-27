#!/usr/bin/env bats

load ../../helpers

@test "Neofetch is installed" {
  run ./modules/50-neofetch/install.sh

  COMMAND="$(command -v neofetch)"
  [ -n "${COMMAND}" ]
}
