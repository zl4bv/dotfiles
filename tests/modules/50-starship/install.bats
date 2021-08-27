#!/usr/bin/env bats

load ../../helpers

@test "Starship is installed" {
  run ./modules/50-starship/install.sh

  COMMAND="$(command -v starship)"
  [ -n "${COMMAND}" ]
}

@test "Create symlink to starship.toml" {
  run ./modules/50-starship/install.sh

  LINKNAME="${HOME}/.config/starship.toml"
  [ -L "${LINKNAME}" ]
}
