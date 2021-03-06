#!/bin/bash

kernel_name=$(uname -s)
case "${kernel_name}" in
  Linux*)
    OS_PLATFORM=linux

    if [ -f /etc/os-release ]; then
      OS_ID=$(bash -c 'source /etc/os-release; echo ${ID}')
      OS_ID_LIKE=$(bash -c 'source /etc/os-release; echo ${ID_LIKE}')
    fi
    ;;

  Darwin*)
    OS_PLATFORM=mac
    ;;

  *)
    OS_PLATFORM=unknown
    ;;
esac
export OS_PLATFORM
export OS_ID
export OS_ID_LIKE
