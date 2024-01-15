import 'dart:io';

import 'package:battery_info/battery_info_plugin.dart';
import 'package:flutter/material.dart';
import 'package:location/location.dart';

// Import package
import 'package:battery_info/model/android_battery_info.dart';
import 'package:battery_info/enums/charging_status.dart';
import 'package:battery_info/model/iso_battery_info.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: LocationScreen(),
    );
  }
}

class LocationScreen extends StatefulWidget {
  @override
  _LocationScreenState createState() => _LocationScreenState();
}

class _LocationScreenState extends State<LocationScreen> {
  Location location = Location();
  LocationData? locationData;
  late Duration time;

  @override
  void initState() {
    super.initState();
  }

  Future<void> initLocation() async {
    try {
      // Access current battery health - Android
      print(
          "Battery level: ${(await BatteryInfoPlugin().androidBatteryInfo)?.batteryLevel}");

      print(
          "Battery level: ${(await BatteryInfoPlugin().androidBatteryInfo)?.chargeTimeRemaining!}");

      // // Access current battery level - IOS
      // print(
      //     "Battery Level: ${(await BatteryInfoPlugin().iosBatteryInfo).batteryLevel}");

      // Calculate estimated charging time by listener
      // BatteryInfoPlugin().androidBatteryInfoStream.listen((AndroidBatteryInfo? batteryInfo) {
      //   print("Charge time remaining: ${(batteryInfo!.chargeTimeRemaining! / 1000 / 60).truncate()} minutes");
      // });

      var _locationData;


      _locationData = await location.getLocation();

      setState(() {
        locationData = _locationData;
        print("### ${locationData?.latitude},${locationData?.longitude}");
      });
    } catch (e) {
      print("Error: $e");
    }
  }

  Future<void> fetchLocation() async {
    try {
      final startTime = DateTime.now();
      // Access current battery health - Android
      print(
          "Battery level: ${(await BatteryInfoPlugin().androidBatteryInfo)?.batteryLevel}");

      print(
          "Battery level: ${(await BatteryInfoPlugin().androidBatteryInfo)?.chargeTimeRemaining!}");

      var _locationData;


      _locationData = await location.getLocation();
      

      final endTime = DateTime.now();

      setState(() {
        locationData = _locationData;
        time = endTime.difference(startTime);

        print("### ${locationData?.latitude},${locationData?.longitude}");
        print('Elapsed time: ${time.inMilliseconds} milliseconds');
      });
    } catch (e) {
      print("Error: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Location Example'),
      ),
      body: Center(
        child: locationData == null
            ? const CircularProgressIndicator()
            : Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    'Latitude: ${locationData?.latitude}\nLongitude: ${locationData?.longitude}',
                  ),
                  Text("Elapsed time: ${time.inMilliseconds} milliseconds")
                ],
              ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          fetchLocation();
        },
        tooltip: 'Get Location',
        child: Icon(Icons.location_on),
      ),
    );
  }
}
