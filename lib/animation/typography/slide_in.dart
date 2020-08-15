import 'package:flutter/cupertino.dart';

class SlideIn extends StatelessWidget {
  final AnimationController controller;

  SlideIn(this.controller)
      : slideIn = controller
            .drive(CurveTween(curve: Curves.easeInOut))
            .drive(Tween<Offset>(
              // 生成されるはずの場所からずらす.
              begin: const Offset(-1.2, 0),
              end: const Offset(0, 0),
            )) {
    // forward(),repeat(),reverse()
    // などを実行することでアニメーションが発火する
    // ここでは、constructと同時に発火する
    controller.forward().then((_) => controller.reset());
  }

  final Animation slideIn;

  @override
  Widget build(BuildContext context) {
    return SlideTransition(
      position: slideIn,
      child: Center(child: Text('this is test')),
    );
  }
}
