#!/bin/zsh

if command -v starship 2>&1 >/dev/null; then
  eval "$(starship init zsh)"
  return
fi
