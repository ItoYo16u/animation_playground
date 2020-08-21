import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class WavyClippedWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ClipPath(
      child: Container(
        child: Stack(
          children: [
            Positioned(
              top: MediaQuery
                  .of(context)
                  .size
                  .height / 3.5,
              left: MediaQuery
                  .of(context)
                  .size
                  .width / 16,
              child: Text(
                'Hello World!',
                style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.normal,
                    fontSize: Theme
                        .of(context)
                        .textTheme
                        .headline3
                        .fontSize),
              ),
            ),
            Positioned(
                top: MediaQuery
                    .of(context)
                    .size
                    .height / 2.7,
                left: MediaQuery
                    .of(context)
                    .size
                    .width / 16,
                child: Container(
                    width: MediaQuery
                        .of(context)
                        .size
                        .width * 0.9,
                    child: Text(
                      'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliqui.',
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: Theme
                              .of(context)
                              .textTheme
                              .headline6
                              .fontSize),
                    ),
                )
            ),
          ],
        ),
        color: Colors.indigo,
      ),
      clipper: BottomWaveClipper(),
    );
  }
}

class BottomWaveClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    final path = Path()
      ..lineTo(0, 5 * size.height / 6) // toLeftBottom
      ..cubicTo(size.width / 2, size.height - 100, 2 * size.width / 3,
          size.height, size.width, 3 * size.height / 4)
      ..lineTo(size.width, size.height/6)
      ..cubicTo(5*size.width/6, size.height/10, 4*size.width/5,5 , 2*size.width/4, 0)
      ..close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => oldClipper != this;
}
