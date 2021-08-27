"""

SamsungTVWS - Samsung Smart TV WS API wrapper

"""
import base64
import json
import time
import ssl
import logging
import websocket
import samsungexceptions as exceptions
import samsungshortcuts as shortcuts

_LOGGING = logging.getLogger(__name__)

class SamsungTVWS:
    _URL_FORMAT = 'ws://{host}:{port}/api/v2/channels/samsung.remote.control?name={name}'
    _SSL_URL_FORMAT = 'wss://{host}:{port}/api/v2/channels/samsung.remote.control?name={name}&token={token}'

    def __init__(self, host, port=8002, timeout=None, key_press_delay=1,
                 name='SamsungTvRemote',token=None,token_file=None):
        self.host = host
        self.port = port
        self.timeout = None if timeout == 0 else timeout
        self.token = token
        self.token_file = token_file
        self.key_press_delay = key_press_delay
        self.name = name
        self.connection = None

    def _get_token(self):
        if self.token_file is not None:
            try:
                with open(self.token_file, 'r') as token_file:
                    return token_file.readline()
            except:
                return ''
        else:
            return self.token

    def _set_token(self, token):
        _LOGGING.info('New token %s', token)
        if self.token_file is not None:
            _LOGGING.debug('Save token to file: %s', token)
            with open(self.token_file, 'w') as token_file:
                token_file.write(token)
        else:
            self.token = token

    def _serialize_string(self, string):
        if isinstance(string, str):
            string = str.encode(string)

        return base64.b64encode(string).decode('utf-8')

    def _is_ssl_connection(self):
        return self.port == 8002

    def _format_websocket_url(self):
        params = {
            'host': self.host,
            'port': self.port,
            'name': self._serialize_string(self.name),
            'token': self._get_token(),
        }

        if self._is_ssl_connection():
            return self._SSL_URL_FORMAT.format(**params)
        else:
            return self._URL_FORMAT.format(**params)

    def _ws_send(self, command, key_press_delay=None):
        if self.connection is None:
            self.open()
        payload = json.dumps(command)
        self.connection.send(payload)

        delay = self.key_press_delay if key_press_delay is None else key_press_delay
        time.sleep(delay)

    def _process_api_response(self, response):
        try:
            return json.loads(response)
        except json.JSONDecodeError:
            _LOGGING.debug('Failed to parse response from TV. response text: %s', response)
            raise exceptions.ResponseError('Failed to parse response from TV. Maybe feature not supported on this model')

    def open(self):
        url = self._format_websocket_url()
        sslopt = {'cert_reqs': ssl.CERT_NONE} if self._is_ssl_connection() else {}

        self.connection = websocket.create_connection(
            url,
            self.timeout,
            sslopt=sslopt,
            connection='Connection: Upgrade'
        )

        response = self._process_api_response(self.connection.recv())
        
        if response.get('data') and response.get('data').get('token'):
            token = response.get('data').get('token')
            _LOGGING.debug('Got token %s', token)
            self._set_token(token)

        if response['event'] != 'ms.channel.connect':
            self.close()
            raise exceptions.ConnectionFailure(response)

    def close(self):
        if self.connection:
            self.connection.close()

        self.connection = None
        _LOGGING.debug('Connection closed.')

    def send_key(self, key, times=1, key_press_delay=None, cmd='Click'):
        for _ in range(times):
            self._ws_send(
                {
                    'method': 'ms.remote.control',
                    'params': {
                        'Cmd': cmd,
                        'DataOfCmd': key,
                        'Option': 'false',
                        'TypeOfRemote': 'SendRemoteKey'
                    }
                },
                key_press_delay
            )

    def shortcuts(self):
        return shortcuts.SamsungTVShortcuts(self)
