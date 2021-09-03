#!/bin/bash

if [ "${OS_PLATFORM}" != "mac" ]; then
  exit 0
fi

[ -z "$(xcode-select --print-path)" ] && sudo xcode-select --install

# The following is only needed if full Xcode is installed
#sudo xcodebuild -license accept
