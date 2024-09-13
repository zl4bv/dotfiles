#!/usr/bin/env fish

# Make vim the default editor
set vimpath "$(command -v vim)"
if test -n $vimpath 
  set -gx EDITOR $vimpath
end
set -u vimpath
