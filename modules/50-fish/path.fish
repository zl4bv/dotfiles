#!/usr/bin/env fish

set -gx PATH $HOME/bin $PATH

# dotfiles
set -gx PATH $HOME/.dotfiles/bin $PATH

# golang
if test -d /usr/local/go/bin
  set -gx PATH /usr/local/go/bin $PATH
end

if test -d $HOME/go
  set -gx GOPATH $HOME/go
  set -gx PATH $HOME/go/bin $PATH
end

# cargo
if test -d $HOME/.cargo/bin
  set -gx PATH $HOME/.cargo/bin $PATH
end

# Kate - macOS
if test -d /Applications/kate.app
  set -gx PATH $PATH /Applications/kate.app/Contents/MacOS
end

# VS Code - macOS
if test -d "/Applications/Visual Studio Code.app"
  set -gx PATH $PATH "/Applications/Visual Studio Code.app/Contents/Resources/app/bin"
end

if test -d "/Applications/Visual Studio Code - Insiders.app"
  set -gx PATH $PATH "/Applications/Visual Studio Code - Insiders.app/Contents/Resources/app/bin"
end
