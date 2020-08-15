import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'dart:math' as math;

class DrawArcWrap extends HookWidget {
  @override
  Widget build(BuildContext context) {
    final controller = useAnimationController(duration: Duration(seconds: 2));
    return DrawArc(controller);
  }
}

class DrawArc extends StatelessWidget {
  final AnimationController controller;

  DrawArc(this.controller)
      : draw = controller.drive(Tween<double>(begin: 0, end: 2 * math.pi)) {
    controller.repeat(reverse: false);
  }

  final Animation draw;

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: draw,
      builder: (context, _) => CustomPaint(
        painter: WavePainter(draw.value, context),
      ),
    );
  }
}

class ArcsPainter extends CustomPainter {
  ArcsPainter(this.angle);

  final double angle;

  @override
  void paint(Canvas canvas, Size size) {
    print(size);
    Paint paint = Paint()
      // hue rotateをつかうことでよしなに色を繰り返し変えている
      ..color = HSVColor.fromAHSV(1, angle * 180 / math.pi, 1, 1).toColor()
      ..style = PaintingStyle.stroke
      ..strokeWidth = 8.0;

    Path path = Path();

    path.arcTo(Rect.fromLTWH(0, 0, 100, 100), 0 + angle * 0.8, angle, true);
    canvas.drawPath(path, paint);
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => true;
}

class WavePainter extends CustomPainter {
  WavePainter(this.angle, this.context)
      : points = [
          Offset(0, 100 + 50 * math.sin(angle - math.pi / 4)),
          Offset(50, 100 + 50 * math.sin(angle - 2 * math.pi / 4)),
          Offset(100, 100 + 50 * math.sin(angle - 3 * math.pi / 4)),
          Offset(150, 100 + 50 * math.sin(angle - 4 * math.pi / 4)),
          Offset(200, 100 + 50 * math.sin(angle - 5 * math.pi / 4)),
          Offset(250, 100 + 50 * math.sin(angle - 6 * math.pi / 4)),
          Offset(300, 100 + 50 * math.sin(angle - 7 * math.pi / 4)),
          Offset(350, 100 + 50 * math.sin(angle - 8 * math.pi / 4)),
          Offset(400, 100 + 50 * math.sin(angle - 9 * math.pi / 4)),
        ],
        width = MediaQuery.of(context).size.width,
        height = MediaQuery.of(context).size.height {
    for (var i = 0; i < 180; i++) {
      wavepoints.add(Offset(
          i * width / 179, 100 + 50 * math.sin(angle - i * math.pi / 180)));
    }
  }

  final double angle;
  final BuildContext context;
  final List<Offset> points;
  final double width, height;
  List<Offset> wavepoints = [];

  @override
  void paint(Canvas canvas, Size size) {
    print(size);
    Paint paint = Paint()
      // hue rotateをつかうことでよしなに色を繰り返し変えている
      ..color = HSVColor.fromAHSV(1, angle * 180 / math.pi, 1, 1).toColor()
      ..style = PaintingStyle.fill // fill inside closed path;
      // painting style.stroke => show only path;
      ..strokeWidth = 5.0;

    Path path = Path();
    path
      ..moveTo(0, 100) // change wave points to points to check simple version;
      ..addPolygon(wavepoints, false)
      ..lineTo(width, height)
      ..lineTo(0, height)
      ..close();
    canvas.drawPath(path, paint);
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => true;
}
