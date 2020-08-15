import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:interaction_playground/animation/with_hook/resizable_container_child.dart';

class ResizeContainer extends HookWidget {
  @override
  Widget build(BuildContext context) {
    final controller =
        useAnimationController(upperBound: 2, duration: Duration(seconds: 3));
    controller.addListener(() {
      print(controller.value);
    });
    return ResizableContainerChild(controller);
  }
}
