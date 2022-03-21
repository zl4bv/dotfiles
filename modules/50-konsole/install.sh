#!/bin/bash

CURDIR="${HOME}/.dotfiles/modules/50-konsole"

if ! command -v konsole >/dev/null 2>&1; then
  echo "Installing Konsole..."
  case "${PKG_MGR}" in
  pacman)
    pacman -S konsole
    ;;
esac
fi

# Only continue if Konsole is already installed
if ! command -v konsole >/dev/null 2>&1; then
  exit 0
fi

mkdir -p "${HOME}/.local/share/konsole"

for file in "Night Owl.colorscheme" "zl4bv.profile"; do
  if [ -e "${HOME}/.local/share/konsole/${file}" ]; then
    cp "${HOME}/.local/share/konsole/${file}" "${HOME}/.local/share/konsole/${file}.bak"
  fi

  rm -f "${HOME}/.local/share/konsole/${file}"

  ln -sfn "${CURDIR}/${file}" "${HOME}/.local/share/konsole/${file}"
done
