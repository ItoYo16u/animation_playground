import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'dart:math' as math;

class BounceBuilder extends HookWidget {
  @override
  Widget build(BuildContext context) {
    final controller = useAnimationController(duration: Duration(seconds: 1));
    return Bounce(controller);
  }
}


class Bounce extends StatelessWidget {
  final AnimationController controller;

  Bounce(this.controller)
      : draw = controller
            .drive(CurveTween(curve: Curves.linear))
            .drive(Tween<double>(begin: 0, end: math.pi)) {
    controller..forward()..repeat(reverse: true);
  }

  final Animation draw;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        AnimatedBuilder(
            animation: draw,
            builder: (_, __) => Transform.translate(
              offset: Offset(0,-88*math.sin(draw.value)),
              child: Center(
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(50),
                      color: Colors.black,

                    ),
                    child: Stack(
                      children: [
                        Positioned(
                          left: 36,
                          top: 16,
                          child: Container(
                            decoration: BoxDecoration(
                                color: Colors.black,
                                borderRadius: BorderRadius.circular(8),
                                border: Border.all(color: Colors.white,width: 4)
                            ),
                            width: 16 + math.sin(draw.value),
                            height: 16,
                          ),
                        ),
                        Positioned(
                          left: 56,
                          top: 20,
                          child: Container(
                            decoration: BoxDecoration(
                                color: Colors.black54,
                                borderRadius: BorderRadius.circular(8),
                                border: Border.all(color: Colors.white,width: 4)
                            ),
                            width: 15,
                            height: 15,
                          ),
                        )
                      ],
                    ),
                    width: 96 + 4*math.cos(draw.value).abs()*3*math.cos(draw.value).abs(),
                    height: 100 + 3*math.sin(draw.value)*4*math.sin(draw.value),
                  )),
            )),

      ],
    );
  }
}
