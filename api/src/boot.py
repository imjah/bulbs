import sys

sys.path.append("mod")

import conf
import gc
import network
import ubinascii

gc.collect()

def init_ap():
    ap = network.WLAN(network.AP_IF)
    mac = ubinascii.hexlify(ap.config("mac")).decode()

    ap.active(True)
    ap.config(essid=f'Bulb ({mac[-2:]})', password="bulbbulb")

def init_sta():
    c = conf.Conf()

    if not c.get("sta_ssid") or not c.get("sta_password"):
        return

    sta = network.WLAN(network.STA_IF)

    sta.active(True)
    sta.connect(c.get("sta_ssid"), c.get("sta_password"))

init_ap()
init_sta()

