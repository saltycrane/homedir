#!/usr/bin/env python

'''
Grep a file for a given pattern and return a unique sorted list of matches
inside capturing parentheses

http://www.saltycrane.com/blog/2011/04/trying-use-unix-tools-instead-python-utility-scripts/

Example usage:
    $ grep2.py '^([^#<\s]+)' /etc/apache2/apache2.conf

    AccessFileName
    CustomLog
    DefaultType
    ErrorLog
    Group
    HostnameLookups
    Include
    KeepAlive
    KeepAliveTimeout
    LockFile
    LogFormat
    LogLevel
    MaxKeepAliveRequests
    PidFile
    ServerName
    ServerRoot
    Timeout
    User

'''
import re
import sys


def main():
    patt = sys.argv[1]
    filename = sys.argv[2]

    text = open(filename).read()
    # TODO: update to accept more than one group
    matchlist = set(m.group(1) for m in re.finditer(patt, text, re.MULTILINE))
    for m in sorted(matchlist):
        print m


if __name__ == '__main__':
    main()
