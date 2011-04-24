#!/usr/bin/env python


import os
import sys
from datetime import datetime


def main():
    date = datetime.now().strftime('%Y-%m-%d')
    cmd = ' '.join(['sudo apt-get'] + sys.argv[1:])
    run('cd /etc && sudo git add -A .')
    run('cd /etc && sudo git status')
    run("cd /etc && sudo git commit -m '%s Before %s'" % (date, cmd))
    run(cmd)
    run('cd /etc && sudo git add -A .')
    run('cd /etc && sudo git status')
    run("cd /etc && sudo git commit -m '%s After %s'" % (date, cmd))


def run(cmd):
    print cmd
    os.system(cmd)


if __name__ == '__main__':
    main()
