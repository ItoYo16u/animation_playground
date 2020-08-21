import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dart:math' as math;

class SpreadButtons extends StatefulWidget {
  @override
  SpreadButtonsState createState() => SpreadButtonsState();
}

class SpreadButtonsState extends State<SpreadButtons>
    with SingleTickerProviderStateMixin {
  AnimationController controller;
  bool isReverse = false;

  @override
  void initState() {
    controller =
        AnimationController(duration: Duration(milliseconds: 350), vsync: this)
          ..addStatusListener((status) {
            if (status == AnimationStatus.completed) {
              setState(() {
                isReverse = true;
              });
            } else {
              setState(() {
                isReverse = false;
              });
            }
          });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    print(controller.value);
    return Scaffold(
        body: AnimatedBuilder(
            animation: controller,
            builder: (_, __) => Container(
                  child: Stack(
                    children: [
                      Center(
                        child: FloatingActionButton(
                          child: Icon(Icons.add),
                          onPressed: () => isReverse
                              ? controller.reverse()
                              : controller.forward(),
                        ),
                      ),

                      Positioned(
                          left: MediaQuery.of(context).size.width / 2 -
                              28 +
                              controller.drive(CurveTween(curve: Curves.easeOut)).value * 112 * math.cos(-math.pi / 4),
                          top: MediaQuery.of(context).size.height / 2 -
                              12 +
                              controller.value * 112 * math.sin(-math.pi / 4),
                          child: Transform.rotate(
                            angle: controller
                                .drive(
                                    Tween<double>(begin: 0, end: 4 * math.pi))
                                .value,
                            child: ScaleTransition(
                                scale: controller
                                    .drive(
                                        CurveTween(curve: Curves.elasticInOut))
                                    .drive(Tween(begin: 0, end: 0.95)),
                                child: FloatingActionButton(
                                  child: Icon(Icons.code),
                                  backgroundColor: Colors.teal,


                                )),
                          )),
                      Positioned(
                        left: MediaQuery.of(context).size.width / 2 -
                            28 +
                            controller.value * 112 * math.cos(-math.pi / 2),
                        top: MediaQuery.of(context).size.height / 2 -
                            12 +
                            controller.value * 112 * math.sin(-math.pi / 2),
                        child: Transform.rotate(
                          angle: controller
                              .drive(Tween<double>(begin: 0, end: 4 * math.pi))
                              .value,
                          child: ScaleTransition(
                              scale: controller
                                  .drive(CurveTween(curve: Curves.elasticInOut))
                                  .drive(Tween(begin: 0, end: 1.01)),
                              child: FloatingActionButton(
                                child: Icon(Icons.edit),
                                backgroundColor: Colors.indigo,
                              )),
                        ),
                      ),
                      Positioned(
                        left: MediaQuery.of(context).size.width / 2 -
                            28 +
                            controller.value * 112 * math.cos(-3 * math.pi / 4),
                        top: MediaQuery.of(context).size.height / 2 -
                            12 +
                            controller.value * 112 * math.sin(-3 * math.pi / 4),
                        child: Transform.rotate(
                          angle: controller
                              .drive(Tween<double>(begin: 0, end: 4 * math.pi))
                              .value,
                          child: ScaleTransition(
                              scale: controller
                                  .drive(CurveTween(curve: Curves.elasticInOut))
                                  .drive(Tween(begin: 0, end: 0.95)),
                              child: FloatingActionButton(
                                child: Icon(Icons.all_out),
                                backgroundColor: Colors.deepPurple,
                              )),
                        ),
                      ),

                    ],
                  ),
                )));
  }
}
