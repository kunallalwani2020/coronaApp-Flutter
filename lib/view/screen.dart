import 'dart:async';

import 'package:corona_app/view/worldState.dart';
import 'package:flutter/material.dart';
import 'dart:math' as math;

class Screen extends StatefulWidget {
  const Screen({Key? key}) : super(key: key);

  @override
  _ScreenState createState() => _ScreenState();
}

class _ScreenState extends State<Screen> with TickerProviderStateMixin {
  //animation work//
  late final AnimationController _controller =
      AnimationController(duration: const Duration(seconds: 3), vsync: this)
        ..repeat();
  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void initState() {
    super.initState();
    Timer(
      Duration(seconds: 3),
      () => Navigator.push(
          context, MaterialPageRoute(builder: (context) => WorldState())),
    );
  }

//animation work end
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
            //animation work strat//
            AnimatedBuilder(
              animation: _controller,
              child: Container(
                height: 200,
                width: 200,
                child: const Center(
                  child: Image(image: AssetImage("image/virus.png")),
                ),
              ),
              builder: (BuildContext context, Widget? child) {
                return Transform.rotate(
                  angle: _controller.value * 2.0 * math.pi,
                  child: child,
                );
              },
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.08,
            ),
            Align(
              alignment: Alignment.center,
              child: Text(
                'Covid19\nTracker App ',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 25,
                ),
              ),
            )
          ])),
    );
  }
}
