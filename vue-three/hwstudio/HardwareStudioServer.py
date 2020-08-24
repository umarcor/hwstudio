#!/usr/bin/env python3

"""
A Flask server as bridge between hwstudio's web frontend and tools for simulation and/or implementation
"""

from pathlib import Path
from sys import argv
from flask import Flask, jsonify, request


class HardwareStudioServer(object):
    """
    Web simulator server
    """

    def __init__(
        self, dist=(Path(__file__).parent.parent / "dist")
    ):
        app = Flask("hwstudio", static_folder=dist)
        self._app = app

        def index():
            return app.send_static_file("index.html")

        def favicon():
            return app.send_static_file("favicon.ico")

        def serve_js(path):
            return app.send_static_file("js/" + path)

        def serve_img(path):
            return app.send_static_file("img/" + path)

        def serve_css(path):
            return app.send_static_file("css/" + path)

        def alive():
            """
            Check if the backend API is alive
            """
            return "ALIVE!"

        def genbit():
            """
            [PLACEHOLDER] Generate a bitstream from a HWD tarball
            """
            # TODO: receive binary (encoded) stream; a tarball; instead of JSON content
            print(request.json)
            return jsonify({"exitcode": 0})

        self.add_url_rules([
            ["/favicon.ico", "favicon", favicon],
            ["/", "index", index],
            ["/js/<path>", "js", serve_js],
            ["/img/<path>", "img", serve_img],
            ["/css/<path>", "css", serve_css],
            ["/api/alive", "alive", alive, ["GET", "POST"]],
            ["/api/genbit", "genbit", genbit, ["GET", "POST"]],
        ])

    def add_url_rules(self, lst):
        """
        Add URL rules to the web server
        """
        for item in lst:
            if len(item) > 3:
                self._app.add_url_rule(item[0], item[1], item[2], methods=item[3])
            else:
                self._app.add_url_rule(item[0], item[1], item[2])

    def run(self, host="0.0.0.0", port=80):
        self._app.run(host=host, port=port)
