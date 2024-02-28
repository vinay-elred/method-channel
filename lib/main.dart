import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main(List<String> args) {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  String batteryStatus = 'Not found';
  final methodChannel = const MethodChannel('battery_status');

  void getBatteryStatus() async {
    try {
      final res = await methodChannel.invokeMethod<int>('battery-level');
      batteryStatus = 'Battery level at $res % .';
    } catch (e) {
      batteryStatus = "Failed to get battery level";
    } finally {
      setState(() {});
    }
  }

  @override
  void initState() {
    getBatteryStatus();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text("Battery Status"),
        ),
        body: Center(
          child: Text(batteryStatus),
        ),
      ),
    );
  }
}
