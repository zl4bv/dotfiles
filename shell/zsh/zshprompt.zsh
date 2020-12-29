#!/bin/zsh

if [ -f "${HOME}/.cargo/bin/starship" ]; then
  eval "$("${HOME}"/.cargo/bin/starship init zsh)"
  return
elif command -v starship >/dev/null 2>&1; then
  eval "$(starship init zsh)"
  return
fi
