import 'package:flutter/material.dart';
import 'package:bulbs/controller/device.dart';
import 'package:bulbs/model/device.dart';

class DeviceDeleteButton extends StatefulWidget {
  const DeviceDeleteButton({
    super.key,
    required this.device
  });

  final Device device;

  @override
  State<DeviceDeleteButton> createState() => _DeviceDeleteButtonState();
}

class _DeviceDeleteButtonState extends State<DeviceDeleteButton> {
  final DeviceController _ctl = DeviceController();

  @override
  Widget build(BuildContext context) {
    return IconButton(
        icon: const Icon(Icons.delete),
        onPressed: () {
          _ctl.delete(widget.device);

          Navigator.pop(context);
        }
    );
  }
}
