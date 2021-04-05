#!/bin/bash

DOTFILESDIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"

# shellcheck disable=SC1090
source "${DOTFILESDIR}/detect-os.sh"

case "${OS_PLATFORM}" in
  linux)
    if [ -f /sys/devices/virtual/dmi/id/product_name ]; then
      HW_MODEL=$(< /sys/devices/virtual/dmi/id/product_name)
    elif [ -f /sys/firmware/devicetree/base/model ]; then
      HW_MODEL=$(< /sys/firmware/devicetree/base/model)
    fi
    ;;

  mac)
    HW_MODEL=$(sysctl -n hw.model)
    ;;
esac
export HW_MODEL
