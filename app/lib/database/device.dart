import 'package:sqflite/sqflite.dart';
import 'package:bulbs/model/device.dart';

class DeviceDatabase {
  static const _name = 'devices';
  static const _path = 'devices.db';
  static final _observers = <Function>[];

  final _database = openDatabase(
      _path,
      onCreate: (db, version) {
        return db.execute(
          'CREATE TABLE IF NOT EXISTS $_name('
            'ip TEXT PRIMARY KEY,'
            'name TEXT,'
            'color INTEGER,'
            'brightness DOUBLE,'
            'isOn INTEGER,'
            'isConnected INTEGER'
            ')'
        );
      },
      version: 1
  );

  Future<void> insert(Device device) async {
    final db = await _database;

    await db.insert(
      _name,
      device.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace
    );

    _notifyObservers();
  }

  Future<void> delete(Device device) async {
    final db = await _database;

    await db.delete(
      _name,
      where: 'ip = ?',
      whereArgs: [device.ip]
    );

    _notifyObservers();
  }

  Future<List<Device>> selectAll() async {
    final db = await _database;
    final List<Map<String, dynamic>> maps = await db.query(_name);

    return List.generate(maps.length, (i) {
      return Device(
        ip: maps[i]['ip'],
        name: maps[i]['name'],
        color: maps[i]['color'],
        brightness: maps[i]['brightness'],
        isOn: maps[i]['isOn'],
        isConnected: maps[i]['isConnected'],
      );
    });
  }

  void addObserver(Function update) {
    _observers.add(update);
  }

  void removeObserver(Function update) {
    _observers.remove(update);
  }

  void _notifyObservers() {
    for (Function update in _observers) {
      update();
    }
  }
}
