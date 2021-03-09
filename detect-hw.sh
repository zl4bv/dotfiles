#!/bin/bash

DOTFILESDIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"

# shellcheck disable=SC1090
source "${DOTFILESDIR}/detect-os.sh"

case "${OS_PLATFORM}" in
  linux)
    if [ -f /sys/devices/virtual/dmi/id/product_name ]; then
      HW_MODEL=$(< /sys/devices/virtual/dmi/id/product_name)
    fi
    ;;

  mac)
    HW_MODEL=$(sysctl -n hw.model)
    ;;
esac
export HW_MODEL
