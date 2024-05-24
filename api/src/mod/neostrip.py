from converter import rgb_to_hex, hex_to_rgb
from neopixel import NeoPixel
from time import sleep
from validator import validate_type, validate_range, validate_hex

class NeoStrip:
    """NeoPixel with custom features"""

    def __init__(self, conf, pin_led, pin_mosfet, auto_update=True):
        self._mosfet = pin_mosfet
        self._pixels = NeoPixel(pin_led, conf.get("led_n"))
        self._conf = conf
        self._auto_update = False

        self.set_brightness(conf.get("led_brightness"))
        self.set_color(conf.get("led_color"))
        self.set_power(conf.get("led_power"))
        self.update()

        self._auto_update = auto_update

    def set_power(self, power):
        validate_type(power, int)
        validate_range(power, 0.0, 1.0)

        self._power = power
        self._try_update()

    def get_power(self):
        return self._power

    def set_brightness(self, brightness):
        validate_type(brightness, float)
        validate_range(brightness, 0.0, 1.0)

        self._brightness = brightness
        self._try_update()

    def get_brightness(self):
        return self._brightness

    def set_color(self, color):
        validate_hex(color)

        self._color = hex_to_rgb(color)
        self._try_update()

    def get_color(self):
        return rgb_to_hex(self._color)

    def update(self):
        if self._power:
            if not self._mosfet.value():
                self._mosfet.on()
                sleep(0.01)

            color = self._add_brightness(self._color)

            self._pixels.fill(color)
            self._pixels.write()
        else:
            self._mosfet.off()

        self._conf.set({
            "led_brightness": self._brightness,
            "led_color": rgb_to_hex(self._color),
            "led_power": self._power
        })

    def _try_update(self):
        if self._auto_update:
            self.update()

    def _add_brightness(self, color):
        return tuple(
            int(color[i] * self._brightness) for i in range(self._pixels.bpp)
        )

