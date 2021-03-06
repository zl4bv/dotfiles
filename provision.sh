#!/bin/bash

DOTFILESDIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"

# shellcheck disable=SC1090
source "${DOTFILESDIR}/detect-os.sh"

if [ -f "${DOTFILESDIR}/provision/_all/provision.sh" ]; then
  "${DOTFILESDIR}"/provision/_all/provision.sh
fi

if [ -f "${DOTFILESDIR}/provision/${OS_PLATFORM}/provision.sh" ]; then
  "${DOTFILESDIR}"/provision/"${OS_PLATFORM}"/provision.sh
fi

for like in ${OS_ID_LIKE}; do
  if [ -f "${DOTFILESDIR}/provision/${OS_PLATFORM}-${like}/provision.sh" ]; then
    "${DOTFILESDIR}"/provision/"${OS_PLATFORM}"-"${like}"/provision.sh
  fi
done

if [ -f "${DOTFILESDIR}/provision/${OS_PLATFORM}-${OS_ID}/provision.sh" ]; then
  "${DOTFILESDIR}"/provision/"${OS_PLATFORM}"-"${OS_ID}"/provision.sh
fi
