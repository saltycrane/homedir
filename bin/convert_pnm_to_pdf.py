#!/usr/bin/env python
"""
requires: PIL
usage: ./convert_pnm_to_pdf.py filename.pnm
"""
import os
import sys

import Image


filename = sys.argv[1]
try:
    newfilename = os.path.splitext(filename)[0] + ".pdf"
    Image.open(filename).save(newfilename)
    print "Converted " + newfilename
except IOError:
    print "Cannot convert" + newfilename
