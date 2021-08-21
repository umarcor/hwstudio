#!/usr/bin/env python3

from wsgiref.simple_server import make_server

from pyHWS.api import app

if __name__ == '__main__':
    with make_server('', 8000, app) as httpd:
        print('Serving on port 8000...')
        httpd.serve_forever()
