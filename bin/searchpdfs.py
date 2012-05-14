#!/usr/bin/env python

"""
Example usage:

    searchpdfs.py scanned-mail 'hazard'

"""

import os
import subprocess
import sys


def main(directory, searchterm):
    filelist = unix_find(directory)
    for filepath in filelist:
        if filepath.endswith(('.pdf', '.PDF')):
            search_pdf(filepath, searchterm)


def search_pdf(filepath, searchterm):
    cmd = 'pdftotext "%s" - | grep -i %s' % (filepath, searchterm)
    results = backtick(cmd)
    if results:
        print
        print filepath
        print results


def backtick(cmd):
    p = subprocess.Popen(
        ['/bin/bash', '-c', cmd], stdin=subprocess.PIPE, stdout=subprocess.PIPE,
        stderr=subprocess.STDOUT, close_fds=True)
    stdouterr, unused = p.communicate()
    return stdouterr


def run(cmd):
    os.system(cmd)


def unix_find(pathin):
    """Return results similar to the Unix find command run without options
    i.e. traverse a directory tree and return all the file paths
    """
    return [os.path.join(path, file)
            for (path, dirs, files) in os.walk(pathin)
            for file in files]


if __name__ == '__main__':
    directory = sys.argv[1]
    searchterm = sys.argv[2]
    main(directory, searchterm)
