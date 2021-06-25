#!/usr/bin/env python3

import pyqrcode
import sys

text = pyqrcode.create(sys.stdin.read())
print(text.terminal())

