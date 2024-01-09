import 'package:battery_info/battery_info_plugin.dart';
import 'package:flutter/material.dart';

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
  late Duration time;
  int primeNumbers = 0;
  int start= 1;
  int end= 100000;

  @override
  void initState() {
    super.initState();
  }

  Future<void> initPrimes() async {
    try {
      // Access current battery health - Android
      print(
          "Battery level: ${(await BatteryInfoPlugin().androidBatteryInfo)
              ?.batteryLevel}");

      print(
          "Battery level: ${(await BatteryInfoPlugin().androidBatteryInfo)
              ?.chargeTimeRemaining!}");

      // // Access current battery level - IOS
      // print(
      //     "Battery Level: ${(await BatteryInfoPlugin().iosBatteryInfo).batteryLevel}");

      // Calculate estimated charging time by listener
      // BatteryInfoPlugin().androidBatteryInfoStream.listen((AndroidBatteryInfo? batteryInfo) {
      //   print("Charge time remaining: ${(batteryInfo!.chargeTimeRemaining! / 1000 / 60).truncate()} minutes");
      // });
    } catch(e){
      print(e);
    }
  }

  bool isPrime(int number) {
    if (number < 2) {
      return false;
    }
    for (int i = 2; i <= (number / 2); i++) {
      if (number % i == 0) {
        return false;
      }
    }
    return true;
  }

  List<int> findPrimesInRange(int start, int end) {
    List<int> primes = [];
    for (int i = start; i <= end; i++) {
      if (isPrime(i)) {
        primes.add(i);
      }
    }
    return primes;
  }


  Future<void> fetchLocation() async {
    try {
      final startTime = DateTime.now();
      // Access current battery health - Android
      print(
          "Battery level: ${(await BatteryInfoPlugin().androidBatteryInfo)?.batteryLevel}");

      print(
          "Battery level: ${(await BatteryInfoPlugin().androidBatteryInfo)?.chargeTimeRemaining!}");

      var _numbers;

      for (int i = 0; i < 100; i++) {
         _numbers = findPrimesInRange(start, end).length;
      }

      final endTime = DateTime.now();

      setState(() {
        primeNumbers = _numbers;
        time = endTime.difference(startTime);

        print("### Found ${_numbers} prime numbers");
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
        title: const Text('Calculation Example'),
      ),
      body: Center(
        child: primeNumbers == 0
            ? const CircularProgressIndicator()
            : Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              'Found $primeNumbers in given range: ($start, $end)',
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
        child: const Icon(Icons.account_tree_outlined),
      ),
    );
  }
}