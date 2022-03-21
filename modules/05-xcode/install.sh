#!/bin/bash

if [ "${OS_PLATFORM}" != "mac" ]; then
  exit 0
fi

if [ -z "$(xcode-select --print-path)" ]; then
  echo "Preparing Xcode..."
  sudo xcode-select --install
fi

# The following is only needed if full Xcode is installed
#sudo xcodebuild -license accept
