import 'package:bulbs/resources.dart';
import 'package:bulbs/screen/device_add.dart';
import 'package:bulbs/screen/scene_add.dart';
import 'package:bulbs/view/device_list.dart';
import 'package:bulbs/view/device_fetch_button.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(R(context).strings.title),
        centerTitle: true,
        actions: const [
          DeviceFetchButton()
        ]
      ),
      body: IndexedStack(
        index: _selectedIndex,
        children: [
          const DeviceList(),
          Container()
        ]
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: [
          BottomNavigationBarItem(
            icon: const Icon(Icons.devices),
            label: R(context).strings.navigationLabelDevices
          ),
          BottomNavigationBarItem(
              icon: const Icon(Icons.list),
              label: R(context).strings.navigationLabelScenes
          )
        ],
        currentIndex: _selectedIndex,
        onTap: _setNavigationTap,
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: _onFloatingButtonTap,
        icon: const Icon(Icons.add),
        label: IndexedStack(
            index: _selectedIndex,
            children: [
              Text(R(context).strings.floatingButtonLabelDevice),
              Text(R(context).strings.floatingButtonLabelScene)
            ]
        )
      )
    );
  }

  void _setNavigationTap(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  void _onFloatingButtonTap() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) {
          if (_selectedIndex == 1) {
            return const SceneAddScreen();
          }

          return const DeviceAddScreen();
        }
      )
    );
  }
}
