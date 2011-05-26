#!/usr/bin/env python

'''
#!/bin/sh
find . -iname "$1" -exec grep --color \
    --exclude='*/.hg/*' \
    --exclude='*/.svn/*' "$2" {} +
'''

import os

from optparse import OptionParser


def main():
    parser = OptionParser(
        usage="usage: %prog [options] search_pattern [file_pattern]",
        version="%prog 1.0")
    parser.add_option("-i", "--ignore-case",
                      action="store_true",
                      dest="ignore_case",
                      default=False,
                      help="Ignore case in grep command",
                      )
    (options, args) = parser.parse_args()

    if len(args) < 1 and len(args) > 2:
        parser.error("wrong number of arguments")

    searchterm = args[0]
    if len(args) == 2:
        glob = "'%s'" % args[1]
    else:
        glob = "'*'"
    grep_args = ['--color']
    if options.ignore_case:
        grep_args.append('-i')

    cmd = " ".join([
            "find .",
            "-path %s" % glob,
            "-type f",
            "! -regex '.*~$'",
            "! -regex '.*\.orig$'",
            "! -regex '.*\.bak$'",
            "! -regex '.*/#.*'",
            "! -regex '.*/\.svn/.*'",
            "-exec grep",
            " ".join(grep_args),
            "-E '%s'" % searchterm,
            "{} +",
            ])
    os.system(cmd)


if __name__ == '__main__':
    main()
