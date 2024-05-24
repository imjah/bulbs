def validate_type(value, expected_type, msg=""):
    """Raise TypeError when value is not expected type"""

    if type(value) != expected_type:
        raise TypeError(msg or f"{type(value)} is not {expected_type}")

def validate_range(value, start, end, msg=""):
    """Raise ValueError when value is out of CLOSED range"""

    if value < start or value > end:
        raise ValueError(msg or f"{value} not in <{start},{end}>")

def validate_hex(color):
    validate_type(color, str)

    error_message = f"{color} is not HEX color"

    if len(color) != 7 or color[0] != "#":
        raise ValueError(error_message)

    for c in color[1:].lower():
        try:
            validate_range(ord(c), 48, 57)
        except ValueError:
            validate_range(ord(c), 97, 102, error_message)
