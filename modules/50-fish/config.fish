#!/usr/bin/env fish

function bind_bang
    switch (commandline -t)[-1]
        case "!"
            commandline -t -- $history[1]
            commandline -f repaint
        case "*"
            commandline -i !
    end
end

# Bash-friendly alternative to Alt + Up
function bind_dollar
    switch (commandline -t)[-1]
        case "!"
            commandline -f backward-delete-char history-token-search-backward
        case "*"
            commandline -i '$'
    end
end

function fish_user_key_bindings
    bind ! bind_bang
    bind '$' bind_dollar
end

# enable programmable completion features (you don't need to enable
# this, if it's already enabled in /etc/bash.bashrc and /etc/profile
# sources /etc/bash.bashrc).
if test -r /opt/homebrew/bin/brew
  # macOS Apple Silicon
  set -gx HOMEBREW_PREFIX "/opt/homebrew"
  set -gx HOMEBREW_CELLAR "/opt/homebrew/Cellar"
  set -gx HOMEBREW_REPOSITORY "/opt/homebrew"
  set -gx PATH "/opt/homebrew/bin" "/opt/homebrew/sbin" $PATH
  set -q MANPATH; or set MANPATH ''
  set -gx MANPATH "/opt/homebrew/share/man" $MANPATH
  set -q INFOPATH; or set INFOPATH ''
  set -gx INFOPATH "/opt/homebrew/share/info" $INFOPATH
else if test -r /usr/local/bin/brew
  # macOS Intel
  set -gx HOMEBREW_PREFIX "/usr/local"
  set -gx HOMEBREW_CELLAR "/usr/local/Cellar"
  set -gx HOMEBREW_REPOSITORY "/usr/local/Homebrew"
  set -gx PATH "/usr/local/bin" "/usr/local/sbin" $PATH
  set -q MANPATH; or set MANPATH ''
  set -gx MANPATH "/usr/local/share/man" $MANPATH
  set -q INFOPATH; or set INFOPATH ''
  set -gx INFOPATH "/usr/local/share/info" $INFOPATH
end

if test -e "$HOME/.cargo/bin/starship"
  "$HOME/.cargo/bin/starship" init fish | source
else if command -v starship >/dev/null 2>&1
  starship init fish | source
end

if test -r "$HOME/.dotfiles/modules/50-fish/exports.fish"
  source "$HOME/.dotfiles/modules/50-fish/exports.fish"
end

if test -r "$HOME/.dotfiles/modules/50-fish/path.fish"
  source "$HOME/.dotfiles/modules/50-fish/path.fish"
end

if test -r "$HOME/.dotfiles/modules/50-fish/aliases.fish"
  source "$HOME/.dotfiles/modules/50-fish/aliases.fish"
end

if test -r "$HOME/.config/fish/extra.fish"
  source "$HOME/.config/fish/extra.fish"
end
