import 'package:covid_app/view/world_state_screen.dart';
import 'package:flutter/material.dart';
import 'dart:math' as math;

import '../Service/utils/assets_path/assets_path.dart';


class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with TickerProviderStateMixin {
  late final AnimationController _controller =
      AnimationController(duration: Duration(seconds: 3), vsync: this)
        ..repeat();
  @override
  void initState() {
    super.initState();
    Future.delayed(Duration(seconds: 5),
        () => Navigator.push(context,
          MaterialPageRoute(builder: (context) => WorldStateScreen(),),
        )
    );
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            spacing: 40,
            children: [
              AnimatedBuilder(
                animation: _controller,
                builder: (BuildContext context, Widget? child) {
                  return Transform.rotate(
                    angle: _controller.value * 2.0 * math.pi,
                    child: SizedBox(
                      height: 200,
                      width: 200,
                      child: Image(
                        image: AssetImage(AssetsPath.logoImage),
                          errorBuilder: (context, error, stackTrace) =>
                          const Icon(Icons.error, size: 100) ,
                      ),
                    ),
                  );
                },
              ),
              Text("Covid-Tracker App",
              style: Theme.of(context).textTheme.bodyMedium),
            ],
          ),
        ),
      ),
    );
  }
}
