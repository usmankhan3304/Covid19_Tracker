import 'dart:async';

import 'package:covid_api/View/world_states.dart';
import 'package:flutter/material.dart';
import 'dart:math' as math;

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with TickerProviderStateMixin {
  late final AnimationController _controller =
  AnimationController(duration: const Duration(seconds: 10), vsync: this)
    ..repeat();

  @override
  void dispose(){
    super.dispose();
    _controller.dispose();
  }
  void initState()
  {
    // TODO: implement initState
    super.initState();
    Timer(
        Duration(seconds: 3),
            () => Navigator.push(context,
            MaterialPageRoute(builder:(contex) => WorldStatesScreen())));
  }

  @override
  Widget build(BuildContext context) {
    var _mediaquery = MediaQuery.of(context);
    return Scaffold(
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            AnimatedBuilder(
                animation: _controller,
                child: Container(
                  width: _mediaquery.size.width *0.7,
                  height: _mediaquery.size.height *0.7,
                  child: Center(
                    child: Center(
                        child: Image(
                          image: AssetImage('images/virus.png'),
                        )),
                  ),
                ),
                builder: (context, Widget? child) {
                  return Transform.rotate(
                    angle: _controller.value *.1 * math.pi,
                    child: child,
                  );
                }),
            SizedBox(
              // height: MediaQuery.of(context).size.height *08,
              height: 10,
            ),
            Align(
              alignment: Alignment.center,
              child: Text(
                "COvid-19/Tracker app",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 25,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
