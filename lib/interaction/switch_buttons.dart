import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dart:math' as math;

class SwitchButtonA extends StatefulWidget {
  @override
  SwitchButtonAState createState() => SwitchButtonAState();
}

class SwitchButtonAState extends State<SwitchButtonA>
    with SingleTickerProviderStateMixin {
  bool on;

  @override
  void initState() {
    on = true;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => setState(() {
        on = on == false;
      }),
      child: AnimatedContainer(
        decoration: BoxDecoration(
          color: on ? Colors.blue[200] : Colors.red[200],
          borderRadius: BorderRadius.circular(18),
        ),
        curve: Curves.bounceInOut,
        padding: EdgeInsets.all(4),
        width: 80,
        height: 36,
        duration: const Duration(milliseconds: 200),
        alignment: on ? Alignment.centerLeft : Alignment.centerRight,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          width: 30,
          height: 30,
          child: Center(
            child: on
                ? Text(
                    'On',
                    style: TextStyle(
                        color: Colors.white, fontWeight: FontWeight.bold),
                  )
                : Text(
                    'Off',
                    style: TextStyle(
                        color: Colors.white, fontWeight: FontWeight.bold),
                  ),
          ),
          decoration: BoxDecoration(
            color: on ? Colors.blue[400] : Colors.red[400],
            borderRadius: BorderRadius.circular(15),
          ),
        ),
      ),
    );
  }
}

class SwitchButtonB extends StatefulWidget {
  @override
  SwitchButtonBState createState() => SwitchButtonBState();
}

class SwitchButtonBState extends State<SwitchButtonB>
    with SingleTickerProviderStateMixin {
  bool on;
  bool off;
  bool show;
  AnimationController controller;

  @override
  void initState() {
    on = true;
    off = false;
    show = false;
    controller =
        AnimationController(vsync: this, duration: Duration(milliseconds: 210));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => setState(() {
        if (on){
          controller.forward();
        }else {
          controller.reverse();
        }
        on = on == false;
      }),
      child: AnimatedContainer(
          decoration: BoxDecoration(
            color: on ? Colors.blue[200] : Colors.red[200],
            borderRadius: BorderRadius.circular(18),
          ),
          curve: Curves.bounceInOut,
          padding: EdgeInsets.all(4),
          width: 80,
          height: 36,
          duration: const Duration(milliseconds: 200),
          alignment: on ? Alignment.centerLeft : Alignment.centerRight,
          child: AnimatedBuilder(
            animation: controller,
            builder: (_, __) => Container(
              height: 30,
              width: f(controller.drive(CurveTween(curve: Curves.easeOutQuart)).value) * 60 + 30,
              decoration: BoxDecoration(
                color: controller.drive(ColorTween(begin: Colors.blue,end: Colors.red)).value,
                borderRadius: BorderRadius.circular(15),
              ),
            ),
          )),
    );
  }

  double f(x) {
    return -4 * (x - 1 / 2) * (x - 1 / 2) + 1;
  }
}
