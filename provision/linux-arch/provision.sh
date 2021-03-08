#!/bin/bash

THISDIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"

# shellcheck disable=SC1090
source "${THISDIR}/../../detect-hw.sh"

sudo pacman-mirrors --geoip
sudo pacman -Sy

sudo pacman -S \
  code \
  neofetch \
  ttf-fira-code

case "${HW_MODEL}" in
  "XPS 13 9310") # https://wiki.archlinux.org/index.php/Dell_XPS_13_(9310)

    # Use built-in Intel graphics driver (requires reboot)
    sudo pacman -R xf86-video-intel

    [ -f /etc/X11/xorg.conf.d/20-intel-gpu.conf ] && mv /etc/X11/xorg.conf.d/20-intel-gpu.conf{,.bak}
    [ -d /etc/X11/xorg.conf.d/ ] && echo -e 'Section "Device"\n\tIdentifier "Intel"\n\tDriver "modesetting"\nEndSection' | sudo tee /etc/X11/xorg.conf.d/20-intel-gpu.conf

    # Adjust scaling for UHD display (requires reboot)
    echo 'QT_AUTO_SCREEN_SCALE_FACTOR=1' | sudo tee -a /etc/environment
    echo 'PLASMA_USE_QT_SCALING=1' | sudo tee -a /etc/environment

    [ -f /etc/sddm.conf.d/hidpi.conf ] && mv /etc/sddm.conf.d/hidpi.conf{,.bak}
    [ -d /etc/sddm.conf.d ] && echo -e '[X11]\nServerArguments=-nolisten tcp -dpi 192\nEnableHiDPI=true' | sudo tee /etc/sddm.conf.d/hidpi.conf

    ;;
esac
