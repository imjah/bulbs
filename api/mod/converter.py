def rgb_to_hex(rgb):
    return "#%02x%02x%02x" % rgb

def hex_to_rgb(color):
    return tuple(
        int(color[i:i+2], 16) for i in (1, 3, 5)
    )
