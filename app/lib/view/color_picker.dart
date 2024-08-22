import 'package:bulbs/extension/color.dart';
import 'package:bulbs/util/converter.dart';
import 'package:flutter/material.dart';

class ColorPicker extends StatefulWidget {
  const ColorPicker({
    Key? key,
    required this.color,
    required this.onChange
  }) : super(key: key);

  final int color;
  final Function onChange;

  @override
  State<ColorPicker> createState() => _ColorPickerState();
}

class _ColorPickerState extends State<ColorPicker> {
  late int _color;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        SizedBox(
          width: 90.0,
          child: TextField(
            onChanged: _onTextFieldChange,
            decoration: InputDecoration(
              border: const OutlineInputBorder(),
              labelText: "#${Color(_color).toHexString()}"
            )
          )
        ),
        Icon(
          Icons.square_rounded,
          color: Color(_color),
          size: 80,
        )
      ]
    );
  }

  @override
  void initState() {
    super.initState();

    _color = widget.color;
  }

  void _onTextFieldChange(String input) {
    if (isHexString(input)) {
      int color = hexToInt("#$input");

      setState(() {
        _color = color;
      });

      widget.onChange(color);
    }
  }
}
