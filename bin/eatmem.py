#!/usr/bin/env python

import os
import sys
if os.name != 'posix':
    sys.exit('platform not supported')

import psutil


BYTES_PER_CHAR = 1.0


def main():
    while True:
        # get input value
        size_mb = raw_input('enter size in mb and press <enter>: ')
        try:
            size_bytes = float(size_mb) * 1024.0 * 1024.0
        except ValueError:
            break

        # get overhead of program
        obj_that_eats_the_memory = ''
        overhead_bytes = _get_memory_used()

        # eat memory and report result
        obj_that_eats_the_memory = ' ' * int(
            (size_bytes - overhead_bytes) / BYTES_PER_CHAR)
        mem_used_bytes = _get_memory_used()
        print '%.1f mb eaten' % (mem_used_bytes / 1024.0 / 1024.0)


def _get_memory_used():
    """Return the RSS memory used by this process in bytes as int"""
    pid = os.getpid()
    p = psutil.Process(pid)
    m = p.get_memory_info()
    return m.rss


if __name__ == '__main__':
    main()
