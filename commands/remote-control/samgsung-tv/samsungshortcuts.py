"""
SamsungTVWS - Samsung Smart TV WS API wrapper

"""

class SamsungTVShortcuts:
    def __init__(self, remote):
        self.remote = remote

    # power
    def power(self):
        self.remote.send_key('KEY_POWER')