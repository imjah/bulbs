import json

class Conf:
    def __init__(self):
        self._file = "conf.json"
        self._data = {
            "led_n": 1,
            "led_power": 1,
            "led_color": "#111111",
            "led_brightness": 1.0,
            "sta_password": "",
            "sta_ssid": ""
        }
        self._load()

    def get(self, key):
        return self._data[key]

    def set(self, data):
        self._delta(data)
        self._save()

    def _load(self):
        try:
            with open(self._file) as f:
                self._delta(json.loads(f.read()))
        except OSError:
            print("conf: file not found")

    def _save(self):
        with open(self._file, "w") as f:
            f.write(json.dumps(self._data))

    def _delta(self, data):
        for key in self._data.keys():
            try:
                self._data[key] = data[key]
            except KeyError:
                pass

