import 'package:bulbs/controller/device.dart';
import 'package:bulbs/view/color_picker.dart';
import 'package:flutter/material.dart';
import 'package:bulbs/resources.dart';
import 'package:bulbs/model/device.dart';
import 'package:bulbs/view/device_delete_button.dart';

class DeviceEditScreen extends StatefulWidget {
  const DeviceEditScreen({
    super.key,
    required this.device
  });

  final Device device;

  @override
  State<DeviceEditScreen> createState() => _DeviceEditScreenState();
}

class _DeviceEditScreenState extends State<DeviceEditScreen> {
  final DeviceController _ctl = DeviceController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          R(context).strings.deviceEditScreenTitle
        ),
        centerTitle: true,
        actions: [
          DeviceDeleteButton(device: widget.device)
        ]
      ),
      body: Container(
        padding: const EdgeInsets.all(10.0),
        child: Wrap(
          spacing: 25,
          runSpacing: 25,
          children: [
            Row(
              children: [
                Text(
                  R(context).strings.deviceEditNameLabel,
                  style: const TextStyle(fontSize: 16)
                ),
                const Spacer(),
                SizedBox(
                  width: 150.0,
                  child: TextField(
                    onChanged: _setName,
                    decoration: InputDecoration(
                      border: const OutlineInputBorder(),
                      labelText: widget.device.name,
                    )
                  )
                )
              ]
            ),
            Offstage(
              offstage: widget.device.isConnected == 0,
              child: Column(
                children: [
                  Row(
                      children: [
                        Text(
                            R(context).strings.deviceEditPowerLabel,
                            style: const TextStyle(fontSize: 16)
                        ),
                        const Spacer(),
                        Switch(
                          value: widget.device.isOn == 1,
                          onChanged: _setPower,
                        )
                      ]
                  ),
                  Row(
                      children: [
                        Text(
                            R(context).strings.deviceEditColorLabel,
                            style: const TextStyle(fontSize: 16)
                        ),
                        const Spacer(),
                        ColorPicker(color: widget.device.color, onChange: _setColor)
                      ]
                  ),
                  Row(
                      children: [
                        Text(
                            R(context).strings.deviceEditBrightnessLabel,
                            style: const TextStyle(fontSize: 16)
                        ),
                        const Spacer(),
                        Slider(
                            value: widget.device.brightness,
                            max: 1,
                            divisions: 10,
                            label: "${(widget.device.brightness * 100).round()}%",
                            onChanged: _setBrightness,
                            onChangeEnd: (value) => _ctl.setBrightness(widget.device)
                        )
                      ]
                  )
                ]
              )
            )
          ]
        )
      )
    );
  }

  void _setName(String input) {
    setState(() {
      widget.device.name = input;
    });

    _ctl.put(widget.device);
  }

  void _setPower(bool value) {
    setState(() {
      widget.device.isOn = value ? 1 : 0;
    });

    _ctl.setPower(widget.device);
  }

  void _setColor(int value) {
    setState(() {
      widget.device.color = value;
    });

    _ctl.setColor(widget.device);
  }

  void _setBrightness(double value) {
    setState(() {
      widget.device.brightness = value;
    });
  }
}
