#!/bin/sh

# Make vim the default editor
vimpath="$(command -v vim)"
[ -n "${vimpath}" ] && export EDITOR="${vimpath}"
#export TERMINAL="urxvt";

# Larger bash history (allow 32³ entries; default is 500)
export HISTSIZE=50000000;
export HISTFILESIZE=$HISTSIZE;
export HISTCONTROL=ignoredups;
# Make some commands not show up in history
#export HISTIGNORE=" *:ls:cd:cd -:pwd:exit:date:* --help:* -h:pony:pony add *:pony update *:pony save *:pony ls:pony ls *";

# Prefer US English and use UTF-8
export LANG="en_US.UTF-8";
export LC_ALL="en_US.UTF-8";

if [ -f /usr/libexec/java_home ] && [ -n "$(ls -A /Library/Java/JavaVirtualMachines 2>/dev/null)" ]; then
  JAVA_HOME="$(/usr/libexec/java_home)"
  export JAVA_HOME
fi
