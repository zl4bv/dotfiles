#!/bin/bash

if [ "${OS_PLATFORM}" != "mac" ]; then
  exit 0
fi

sudo xcode-select --install
sudo xcodebuild -license accept
