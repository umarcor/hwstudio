from wsgiref.simple_server import make_server

import falcon

from pyHWS.lib import BOARDS

class ThingsResource:
    def on_get(self, req, resp):
        """Handles GET requests"""
        resp.status = falcon.HTTP_200
        resp.content_type = falcon.MEDIA_TEXT  # Default is JSON, so override
        resp.text = ('\nTwo things awe me most, the starry sky above me and the moral law within me.\n'
                     '    ~ Immanuel Kant\n')

# A CORS policy is required for <umarcor.github.io/hwstudio> to work with a backend served at <127.0.0.1>.
# - https://github.com/godotengine/godot/pull/40542
# - https://developer.mozilla.org/en-US/docs/Web/HTTP/CORS
# - https://developer.mozilla.org/en-US/docs/Web/HTTP/CORS/Errors/CORSMissingAllowOrigin
# Enable a simple CORS policy for all responses.
# - https://falcon.readthedocs.io/en/3.0.1/api/cors.html
app = falcon.App(cors_enable=True)

app.add_route('/things', ThingsResource())
