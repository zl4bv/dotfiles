#!/bin/bash

if [ -f /sys/devices/virtual/dmi/id/product_name ]; then
  HW_MODEL=$(< /sys/devices/virtual/dmi/id/product_name)
fi
export HW_MODEL
