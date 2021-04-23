#!/usr/bin/env python3

import sys
import urllib.request

CSP_HEADER = 'Content-Security-Policy'
CSP_REPORT_ONLY_HEADER = 'Content-Security-Policy-Report-Only'


def main(argv):
    url = argv[0]

    if not (url.startswith('http://') or url.startswith('https://')):
        url = 'https://' + url

    with urllib.request.urlopen(url) as response:
        if response.headers[CSP_HEADER]:
            csp = response.headers[CSP_HEADER]
            disposition = 'enforce'
        elif response.headers[CSP_REPORT_ONLY_HEADER]:
            csp = response.headers[CSP_REPORT_ONLY_HEADER]
            disposition = 'report-only'
        else:
            print('error: CSP header not found in response')
            return

        directives = {}
        for policy_directive in csp.split(';'):
            parts = policy_directive.strip().split(' ')
            directives[parts[0]] = parts[1:]

        print('disposition: %s' % disposition)
        for directive, values in directives.items():
            print(directive)
            for value in sorted(values):
                print("\t%s" % value)


def usage(argv):
    print('usage: %s url')


if __name__ == '__main__':
    if len(sys.argv) != 2:
        usage(sys.argv)
        exit(1)

    main(sys.argv[1:])
