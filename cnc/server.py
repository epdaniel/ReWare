from flask import Flask

logger = None


class ServerDecorator:
    _app = Flask(__name__)

    def __init__(self, logger):
        self.logger = logger
        logger.info("CNC Flask server configured")

    def start(self):
        self.logger.info("Starting flask server")
        self._app.run(host='127.0.0.1', port='42069')

    def stop(self):
        pass

    @_app.route('/', methods=['GET'])
    def root(self):
        return 'temp'