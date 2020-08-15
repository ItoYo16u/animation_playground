import 'package:flutter/cupertino.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:interaction_playground/animation/typography/slide_in.dart';

class SlideInTextWrap extends HookWidget {
  // おそらくこのウィジェットは破棄されないのでホットリロードが効かない。
  // (forwardの場合、アニメーションが終わった状態を保持する)
  @override
  Widget build(BuildContext context){
    final controller = useAnimationController(duration: Duration(seconds: 1));
    return SlideIn(controller);
  }
}