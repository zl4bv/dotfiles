#!/bin/bash

readonly CURDIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd)"
readonly LINKNAME="${HOME}/.dotfiles"
readonly DOTFILESDIR="$( cd "${CURDIR}/../.." > /dev/null 2>&1 && pwd )"

realdir="$(cd "${LINKNAME}" && pwd -P)"
if [ ! -L "${LINKNAME}" ] || [ "${realdir}" != "${DOTFILESDIR}" ]; then
  rm -f "${LINKNAME}"
  ln -sn "${DOTFILESDIR}" "${LINKNAME}"
fi
