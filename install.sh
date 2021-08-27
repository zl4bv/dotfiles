#!/bin/bash

find ./modules -name install.sh -print0 | sort -z | xargs -0 -n1 bash
