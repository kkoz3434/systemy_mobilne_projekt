import 'dart:io';

import 'package:battery_info/battery_info_plugin.dart';
import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: VideoScreen(),
    );
  }
}

class VideoScreen extends StatefulWidget {
  @override
  _VideoScreenState createState() => _VideoScreenState();
}

class _VideoScreenState extends State<VideoScreen> {
  bool loadedVideo = false;
  late Duration time;

  late VideoPlayerController _controller;

  Future<void> printBatteryLevel() async {
    try {
      // Access current battery health - Android
      print(
          "Battery level: ${(await BatteryInfoPlugin().androidBatteryInfo)?.batteryLevel}");

      print(
          "Battery level: ${(await BatteryInfoPlugin().androidBatteryInfo)?.chargeTimeRemaining!}");

      // // Access current battery level - IOS
      // print(
      //     "Battery Level: ${(await BatteryInfoPlugin().iosBatteryInfo).batteryLevel}");
    } catch (e) {
      print("Error: $e");
    }
  }

  Future<dynamic> loadVideoPlayer() async {
    _controller =
        VideoPlayerController.asset('assets/videos/video_example.mp4');
    await _controller.initialize();
    _controller.seekTo(Duration.zero);
  }

  Future<void> loadAndPlayVideo() async {
    final startTime = DateTime.now();

    // Access current battery health - Android
    print(
        "Battery level: ${(await BatteryInfoPlugin().androidBatteryInfo)?.batteryLevel}");

    print(
        "Battery level: ${(await BatteryInfoPlugin().androidBatteryInfo)?.chargeTimeRemaining!}");

    try {
      // ### Main feature ###
      await loadVideoPlayer();
    } catch (e) {
      print("Error: $e");
    }

    _controller.play();
    final endTime = DateTime.now();
    setState(() {
      loadedVideo = true;
      time = endTime.difference(startTime);
      print('Elapsed time: ${time.inMilliseconds} milliseconds');
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Video Example'),
      ),
      body: Center(
        child: loadedVideo == false
            ? const CircularProgressIndicator()
            : Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  AspectRatio(
                    aspectRatio: _controller.value.aspectRatio,
                    child: VideoPlayer(_controller),
                  ),
                  Text(
                    'Video size: ${_controller.value.size.width} X ${_controller.value.size.height}',
                  ),
                  Text("Elapsed time: ${time.inMilliseconds} milliseconds")
                ],
              ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          loadAndPlayVideo();
        },
        tooltip: 'Get Location',
        child: Icon(Icons.play_circle_outline),
      ),
    );
  }
}
