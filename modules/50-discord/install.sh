#!/bin/bash

if [ -f /usr/share/applications/discord.desktop ] && [ ! -f ${HOME}/.local/share/applications/discord.desktop ] && [ -n "${IS_WAYLAND}" ]; then
  echo "Fixing Discord for Wayland..."
  mkdir -p ${HOME}/.local/share/applications
  cp /usr/share/applications/discord.desktop ${HOME}/.local/share/applications/discord.desktop
  sed -i 's/Exec=\/usr\/bin\/discord/& --enable-features=UseOzonePlatform --ozone-platform=wayland/' ${HOME}/.local/share/applications/discord.desktop
fi
