import 'package:bulbs/controller/device.dart';
import 'package:bulbs/model/device.dart';
import 'package:bulbs/resources.dart';
import 'package:bulbs/view/device_list_item.dart';
import 'package:flutter/material.dart';

class DeviceList extends StatefulWidget {
  const DeviceList({super.key});

  @override
  State<DeviceList> createState() => _DeviceListState();
}

class _DeviceListState extends State<DeviceList> {
  final DeviceController _ctl = DeviceController();

  List<Device> _devices = [];

  @override
  Widget build(BuildContext context) {
    return IndexedStack(
        index: _devices.isNotEmpty ? 1 : 0,
        children: [
          Center(
              child: Text(R(context).strings.deviceListEmpty)
          ),
          ListView(
              children: List.generate(
                  _devices.length, (i) => DeviceItem(device: _devices[i])
              )
          )
        ]
    );
  }

  @override
  void initState() {
    super.initState();

    _ctl.addObserver(update);
    _ctl.fetchAll();
  }

  void update() async {
    List<Device> devices = await _ctl.getAll();

    setState(() {
      _devices = devices;
    });
  }
}
