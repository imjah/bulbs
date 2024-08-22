import 'dart:convert';
import 'package:bulbs/util/converter.dart';
import 'package:bulbs/database/device.dart';
import 'package:bulbs/model/device.dart';
import 'package:http/http.dart' as http;

class DeviceController {
  static final DeviceDatabase _db = DeviceDatabase();

  void setPower(Device device) async {
    final response = await http.put(
        Uri.parse("http://${device.ip}/led/${device.isOn == 1 ? "on" : "off"}")
    );

    if (response.statusCode == 200) {
      _db.insert(device.copyWith(isConnected: 1));
    }
    else {
      _db.insert(device.copyWith(isConnected: 0));

      print("setPower: ${device.ip} status ${response.statusCode}");
    }
  }

  void setColor(Device device) async {
    final response = await http.put(
        Uri.parse("http://${device.ip}/led/color/${intToHex(device.color)}")
    );

    if (response.statusCode == 200) {
      _db.insert(device.copyWith(isConnected: 1));
    }
    else {
      _db.insert(device.copyWith(isConnected: 0));

      print("setColor: ${device.ip} status ${response.statusCode}");
    }
  }

  void setBrightness(Device device) async {
    final response = await http.put(
        Uri.parse("http://${device.ip}/led/brightness/${device.brightness}")
    );

    if (response.statusCode == 200) {
      _db.insert(device.copyWith(isConnected: 1));
    }
    else {
      _db.insert(device.copyWith(isConnected: 0));

      print("setBrightness: ${device.ip} status ${response.statusCode}");
    }
  }

  void fetchAll() async {
    final devices = await _db.selectAll();

    for (final device in devices) {
      fetch(device);
    }
  }

  void fetch(Device device) async {
    _db.insert(device.copyWith(isConnected: 0));

    try {
      final response = await http.get(
          Uri.parse("http://${device.ip}/led")
      );

      if (response.statusCode == 200) {
        final body = jsonDecode(response.body);

        _db.insert(device.copyWith(
            color: hexToInt(body["color"]),
            brightness: body["brightness"],
            isOn: body["on"],
            isConnected: 1
        ));

        return;
      } else {
        print("Failed fetch ${device.ip}. Status code ${response.statusCode}");
      }
    } catch (e) {
      print(e);
    }
  }

  void put(Device device) {
    _db.insert(device);
  }

  void delete(Device device) {
    _db.delete(device);
  }

  Future<List<Device>> getAll() async {
    return await _db.selectAll();
  }

  void addObserver(Function update) {
    _db.addObserver(update);
  }

  void removeObserver(Function update) {
    _db.removeObserver(update);
  }
}
