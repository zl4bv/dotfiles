#!/bin/bash

mkdir -p ~/.ssh

keys=$(curl -fsSL https://github.com/zl4bv.keys)
while IFS= read -r key; do
  grep -q "${key}" ~/.ssh/authorized_keys || echo "${key}" >> ~/.ssh/authorized_keys
done < <(printf '%s\n' "$keys")
