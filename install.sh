#!/bin/bash

source ./discovery/detect-hw.sh
source ./discovery/detect-os.sh
source ./discovery/detect-pkg-mgr.sh
source ./discovery/detect-display.sh

find ./modules -name install.sh -print0 | sort -z | xargs -0 -n1 bash
