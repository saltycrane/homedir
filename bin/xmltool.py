#!/usr/bin/env python

"""
Example usage:

    $ cat tmp.xml | xmltool.py

References:
    https://twitter.com/#!/aisipos/status/192376583099650048
    https://github.com/andrewwatts/dotfiles/blob/master/.aliases
    http://stackoverflow.com/questions/749796/pretty-printing-xml-in-python

"""
import re
import sys
import xml.dom.minidom


s = sys.stdin.read()
s = xml.dom.minidom.parseString(s).toprettyxml(indent='  ')
regex = re.compile('>\n\s+([^<>\s].*?)\n\s+</', re.DOTALL)
print regex.sub('>\g<1></', s)
