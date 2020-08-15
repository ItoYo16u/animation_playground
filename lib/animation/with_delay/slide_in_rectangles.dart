import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'dart:math' as math;

/// curveにインターバルを与えることでアニメーションの開始を遅らせることができる

class SlideInRectBuilder extends HookWidget {
  @override
  Widget build(BuildContext context) {
    final controller = useAnimationController(duration: Duration(seconds: 2));
    return SlideInRects(controller);
  }
}

class SlideInRects extends StatelessWidget {
  SlideInRects(this.controller) {
    for (var i = 0; i < 10; i++) {
      final anime = controller.drive(Tween<double>(begin: 0, end: 1)).drive(
          CurveTween(
              curve: Interval(i / 10, 1.0, curve: Curves.fastOutSlowIn)));
      delayedAnimations.add(anime);
    }
    controller
      ..reset()
      ..forward();
  }

  final AnimationController controller;
  List<Animation> delayedAnimations = [];

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: controller,
      builder: (context, _) => Align(
          alignment: Alignment.center,
          child: Container(
            child: Center(
              child: ListView(
                  children: delayedAnimations
                      .map((e) => Transform(
                            transform: Matrix4.translationValues(
                                (e.value - 1) *
                                    MediaQuery.of(context).size.width,
                                0.0,
                                0.0),
                            child: Center(
                              child: Container(
                                height: MediaQuery.of(context).size.height / 10,
                                padding: const EdgeInsets.all(25.0),
                                color: HSVColor.fromAHSV(
                                        1,
                                        math.Random().nextInt(360).toDouble(),
                                        1,
                                        1)
                                    .toColor(),
                              ),
                            ),
                          ))
                      .toList()),
            ),
          )),
    );
  }
}
