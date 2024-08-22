import 'package:bulbs/util/converter.dart';
import 'package:flutter/material.dart';

extension ColorX on Color {
  String toHexString() => intToHex(value);
}
