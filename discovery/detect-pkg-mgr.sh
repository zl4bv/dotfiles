#!/bin/bash

if command -v apt-get >/dev/null 2>&1; then
  PKG_MGR=apt-get
fi

if command -v brew >/dev/null 2>&1; then
  PKG_MGR=homebrew
fi

if command -v pacman >/dev/null 2>&1; then
  PKG_MGR=pacman
fi

export PKG_MGR
