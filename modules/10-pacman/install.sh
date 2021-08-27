#!/bin/bash

if [ "${PKG_MGR}" != "pacman" ]; then
  exit 0
fi

sudo pacman-mirrors --geoip
