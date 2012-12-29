#!/usr/bin/env python
"""
usage: insert paper into scanner, then run ./scandoc.py
"""
import os

cmd = ' '.join([
#        'sudo',
        'scanimage',
#        '--device-name=fujitsu:libusb:007:030',
        '--source "ADF Duplex"',
        '--mode Color',
        '-v',
        '--resolution 200',
        '--y-resolution 200',
        '--batch',
        ])
os.system(cmd)
