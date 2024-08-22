import 'package:bulbs/resources.dart';
import 'package:bulbs/controller/device.dart';
import 'package:bulbs/model/device.dart';
import 'package:flutter/material.dart';

class DeviceAddForm extends StatefulWidget {
  const DeviceAddForm({super.key});

  @override
  State<DeviceAddForm> createState() => _DeviceAddFormState();
}

class _DeviceAddFormState extends State<DeviceAddForm> {
  final DeviceController _ctl = DeviceController();
  final _key = GlobalKey<FormState>();
  String? _ip;
  String? _name;

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _key,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: Column(
          children: [
            TextFormField(
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return R(context).strings.deviceAddFormEmpty;
                }

                _ip = value;

                return null;
              },
              decoration: InputDecoration(
                label: Text(
                    R(context).strings.deviceAddFormIpLabel
                )
              )
            ),
            TextFormField(
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return R(context).strings.deviceAddFormEmpty;
                }

                _name = value;

                return null;
              },
              decoration: InputDecoration(
                label: Text(
                    R(context).strings.deviceAddFormNameLabel
                )
              )
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 16.0),
              child: SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    if (_key.currentState!.validate()) {
                      _ctl.fetch(
                        Device(ip: _ip!, name: _name!)
                      );

                      Navigator.pop(context);
                    }
                  },
                  child: Text(
                    R(context).strings.deviceAddFormSubmit
                  )
                ),
              )
            )
          ]
        )
      )
    );
  }
}
