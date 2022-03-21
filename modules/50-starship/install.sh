#!/bin/bash

CURDIR="${HOME}/.dotfiles/modules/50-starship"

if ! command -v starship >/dev/null 2>&1; then
  echo "Installing Starship..."
  case "${PKG_MGR}" in
    homebrew)
      brew install starship
      ;;

    *)
      curl -fsSL https://starship.rs/install.sh | bash
      ;;
  esac
fi

if [ -e "${HOME}/.config/starship.toml" ]; then
  cp "${HOME}/.config/starship.toml" "${HOME}/.config/starship.toml.bak"
fi

mkdir -p "${HOME}/.config"
rm -f "${HOME}/.config/starship.toml"

ln -sfn "${CURDIR}/starship.toml" "${HOME}/.config/starship.toml"
