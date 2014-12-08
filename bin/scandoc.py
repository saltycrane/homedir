#!/usr/bin/env python
"""
usage: insert paper into scanner, then run ./scandoc.py
"""
import optparse
import os


def main():
    parser = optparse.OptionParser()
    parser.add_option(
        "-p", "--topdf",
        action="store_true",
        dest="topdf",
        default=False,
        help="convert to PDF (default False)",
    )
    parser.add_option(
        "-o", "--output",
        action="store",  # optional because action defaults to "store"
        dest="outputfile",
        default="out.pnm",
        help="output file name",)
    (options, args) = parser.parse_args()

    cmd = ' '.join([
    #        'sudo',
            'scanimage',
    #        '--device-name=fujitsu:libusb:007:030',
            # '--source "ADF Duplex"',
            '--mode Color',
            '-v',
            '--resolution 200',
            # '--y-resolution 200',
            '--batch',
            ])
    os.system(cmd)

    if options.topdf:
        os.system('~/bin/convert_pnm_to_pdf.py out1.pnm')

        if options.outputfile:
            os.system('mv out1.pdf %s' % options.outputfile)


if __name__ == '__main__':
    main()
