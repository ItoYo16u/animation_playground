import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class ResizableContainerChild extends StatelessWidget {
  ResizableContainerChild(this.controller)
      : animation = controller.drive(Tween<double>(begin: 0, end: 100.0)) {
    controller
      ..animateTo(1, curve: Curves.ease)
          .then((_) => controller..animateTo(2, curve: Curves.decelerate));
  }

  final AnimationController controller;
  final Animation animation;

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
        animation: animation,
        builder: (_, __) {
          return Center(
            child: Container(
              width: animation.value,
              height: animation.value,
              color: Theme.of(context).primaryColor,
              child: Text(animation.value.toString()),
            ),
          );
        });
  }
}
