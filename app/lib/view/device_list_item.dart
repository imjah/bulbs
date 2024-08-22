import 'package:bulbs/model/device.dart';
import 'package:bulbs/resources.dart';
import 'package:bulbs/extension/color.dart';
import 'package:bulbs/view/text_icon.dart';
import 'package:bulbs/screen/device_edit.dart';
import 'package:flutter/material.dart';

class DeviceItem extends StatefulWidget {
  const DeviceItem({
    super.key,
    required this.device
  });

  final Device device;

  @override
  State<DeviceItem> createState() => _DeviceItemState();
}

class _DeviceItemState extends State<DeviceItem> {
  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          children: [
            Row(
              children: [
                Text(
                  widget.device.name,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold
                  )
                ),
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 5.0),
                  child: Icon(Icons.circle, size: 4)
                ),
                IndexedStack(
                  index: widget.device.isConnected,
                  children: [
                    Text(
                      R(context).strings.offline,
                      style: const TextStyle(
                        color: Colors.redAccent
                      )
                    ),
                    Text(
                      R(context).strings.online,
                      style: const TextStyle(
                          color: Colors.greenAccent
                      )
                    )
                  ]
                ),
                const Spacer(),
                ElevatedButton(
                  onPressed: _openEditScreen,
                  child: Text(R(context).strings.deviceItemButtonEdit),
                )
              ]
            ),
            Offstage(
              offstage: widget.device.isConnected == 0,
              child: Padding(
                padding: const EdgeInsets.only(top: 10.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    TextIcon(
                        text: widget.device.isOn == 1
                            ? R(context).strings.on
                            : R(context).strings.off,
                        icon: Icons.power
                    ),
                    TextIcon(
                      text: "${(widget.device.brightness * 100.0).round()}%",
                      icon: Icons.brightness_5
                    ),
                    TextIcon(
                      text: "#${Color(widget.device.color).toHexString()}",
                      icon: Icons.square_rounded,
                      iconColor: Color(widget.device.color),
                    )
                  ]
                )
              )
            )
          ]
        )
      )
    );
  }

  void _openEditScreen() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => DeviceEditScreen(device: widget.device)
      )
    );
  }
}
