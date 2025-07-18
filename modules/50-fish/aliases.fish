#!/usr/bin/env fish

if command -v wezterm > /dev/null
  alias meow='curl -fsSL "https://api.thecatapi.com/v1/images/search?format=src" | wezterm imgcat'
  alias woof='curl -fsSL "https://api.thedogapi.com/v1/images/search?format=src" | wezterm imgcat'
end

function cdp
  if test -z $argv[1]
    return
  end
  cd "$HOME/projects/$argv[1]"
end
complete -c cdp -a '(ls $HOME/projects)'
