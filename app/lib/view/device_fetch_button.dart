import 'package:flutter/material.dart';
import 'package:bulbs/resources.dart';
import 'package:bulbs/controller/device.dart';

class DeviceFetchButton extends StatefulWidget {
  const DeviceFetchButton({super.key});

  @override
  State<DeviceFetchButton> createState() => _DeviceFetchButtonState();
}

class _DeviceFetchButtonState extends State<DeviceFetchButton> {
  final DeviceController _ctl = DeviceController();

  @override
  Widget build(BuildContext context) {
    return IconButton(
        icon: const Icon(Icons.download),
        onPressed: download
    );
  }

  void download() {
    _ctl.fetchAll();

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
          content: Text(R(context).strings.downloadDoneOk)
      ),
    );
  }
}
