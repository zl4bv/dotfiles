#!/bin/bash

text=$(curl -s 'https://wttr.in/?format=1' | tr -d '+')
tooltip=$(curl -s 'https://wttr.in/?format=4')
lastupdated=$(date +%R)

# shellcheck disable=SC2028
echo "{\"text\":\"${text}\",\"tooltip\":\"${tooltip//$'\n'/\\n}\\nLast updated: ${lastupdated}\"}"
