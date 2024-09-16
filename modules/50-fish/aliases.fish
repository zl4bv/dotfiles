#!/usr/bin/env fish

if command -v wezterm > /dev/null
  alias meow='curl -fsSL "https://api.thecatapi.com/v1/images/search?format=src" | wezterm imgcat'
  alias woof='curl -fsSL "https://api.thedogapi.com/v1/images/search?format=src" | wezterm imgcat'
end
