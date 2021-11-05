#!/bin/bash

text=$(curl -s 'https://wttr.in/?format=1' | tr -d '+')
tooltip=$(curl -s 'https://wttr.in/?format=4')

echo "{\"text\":\"${text}\",\"tooltip\":\"${tooltip//$'\n'/\\n}\"}"
