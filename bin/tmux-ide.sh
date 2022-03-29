#!/bin/bash

targetdir="${1}"

if [ -z "${targetdir}" ]; then
  echo "usage: ${0} targetdir" >&2
  exit 1
elif [ ! -d "${targetdir}" ]; then
  echo "error: target directory does not exist" >&2
  exit 1
fi

windowname=$(basename "${targetdir}")
abspath=$(readlink "${targetdir}")

tmux new-window -S -c "${targetdir}" -n "${windowname}" -e "TERM=${TERM}" "vim ${abspath}" \;\
     split-window -d -v -l 20% -c "${targetdir}"
