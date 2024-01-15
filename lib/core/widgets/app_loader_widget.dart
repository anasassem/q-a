import 'dart:math' as math;

import 'package:testqa/res.dart';
import 'package:flutter/material.dart';


class AppLoaderWidget extends StatefulWidget {
  const AppLoaderWidget({super.key});

  @override
  State<AppLoaderWidget> createState() => _AppLoaderWidgetState();
}

class _AppLoaderWidgetState extends State<AppLoaderWidget> with SingleTickerProviderStateMixin {
  late final AnimationController _controller =
  AnimationController(vsync: this, duration: const Duration(milliseconds: 800))..repeat();

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    const double size= 128;
    Widget animationBuilder = AnimatedBuilder(
      animation: _controller,
      builder: (_, child) {
        return Transform.rotate(
          angle: -_controller.value * 2 * math.pi,
          child: child,
        );
      },
      child: Image.asset(
        Res.appLoaderBg ,
        height: size,
        width: size,
        fit: BoxFit.fill,
      ),
    );
    return Center(
      child: SizedBox(
        height: size,
        width: size,
        child: Stack(
          children: [
            Align(
              alignment: Alignment.center,
              child: Image.asset(
                Res.logo,
                height: size / 1.7,
                width: size / 1.7,
              ),
            ),
            animationBuilder
          ],
        ),
      ),
    );
  }
}
