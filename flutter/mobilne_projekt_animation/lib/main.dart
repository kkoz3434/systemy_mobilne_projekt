import 'package:battery_info/battery_info_plugin.dart';
import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: AnimationScreen(),
    );
  }
}

class AnimationScreen extends StatefulWidget {
  @override
  _AnimationScreenState createState() => _AnimationScreenState();
}

class _AnimationScreenState extends State<AnimationScreen> with TickerProviderStateMixin{
  late DateTime startAnimationTime;
  late DateTime endAnimationTime;
  
  bool beforeAnimation = true;
  bool animationCompleted = false;
  bool animationStarted = false;

  late final AnimationController _controller;

  late final Animation<double> _animation;

  @override
  void initState() {
    super.initState();
  }

  void initAnimationWidgets(){
    _controller = AnimationController(
      duration: const Duration(seconds: 5),
      vsync: this,
    );

    _animation = CurvedAnimation(
      parent: _controller,
      curve: Curves.linear,
    );
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
  
  getAnimationWidget(){
    if(beforeAnimation && !animationCompleted && animationStarted){
      return  RotationTransition(
        turns: _animation,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Wrap(
            children: [
              Container(
                width: 150,
                height: 150,
                decoration: const BoxDecoration(
                    color: Colors.amber, shape: BoxShape.circle),
              ),
              Container(
                width: 150,
                height: 150,
                decoration: const BoxDecoration(
                    color: Colors.green, shape: BoxShape.circle),
              ),
              Container(
                width: 150,
                height: 150,
                decoration: const BoxDecoration(
                    color: Colors.indigo, shape: BoxShape.circle),
              ),
              Container(
                width: 150,
                height: 150,
                decoration: const BoxDecoration(
                    color: Colors.red, shape: BoxShape.circle),
              )
            ],
          ),
        ),
      );
    }
    if (!beforeAnimation && animationCompleted){
      var duration = endAnimationTime.difference(startAnimationTime);
      return Text("Elapsed time: ${duration.inMilliseconds}");
    }

    if(!animationStarted){
      return const Text("Click to start animation");
    }
    
  }


  Future<void> printBatteryLevel() async {
    try {
      // Access current battery health - Android
      print(
          "Battery level: ${(await BatteryInfoPlugin().androidBatteryInfo)?.batteryLevel}");
      print(
          "Battery level: ${(await BatteryInfoPlugin().androidBatteryInfo)?.chargeTimeRemaining!}");
    } catch (e) {
      print("Error: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Animation Example'),
      ),
      body: Center(
        child: getAnimationWidget()
        ),
      floatingActionButton: FloatingActionButton(
        onPressed: (){
            setState(() {
              printBatteryLevel();
              initAnimationWidgets();
              animationStarted = true;
              startAnimationTime = DateTime.now();

              _animation.addListener(() {
                if(_animation.isCompleted){
                  setState(() {
                    _controller.dispose();
                    beforeAnimation = false;
                    animationCompleted = true;
                    endAnimationTime = DateTime.now();
                  });
                }
              });

              if (!_controller.isAnimating) {
                _controller.forward(); // Start the animation
              }

            });

        },
        tooltip: 'Get Location',
        child: const Icon(Icons.access_alarm),
      ),
    );
  }
}