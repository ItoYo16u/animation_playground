import 'package:flutter/material.dart';
import 'package:interaction_playground/animation/lively/bounce.dart';
import 'package:interaction_playground/canvas_and_path/shape_divider/wavy_divider.dart';
import 'package:interaction_playground/guide/stateless_and_stateful.dart';
import 'package:interaction_playground/interaction/rolling_floating_button.dart';
import 'package:interaction_playground/interaction/spread_buttons.dart';
import 'package:interaction_playground/interaction/switch_buttons.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Flutter Interaction Playground',
        theme: ThemeData(
          backgroundColor: Colors.white,
        ),
        home: Scaffold(
          body: GridView(
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 4,
              mainAxisSpacing: 20,
            ),
            children: [
              Center(
                child: SwitchButtonA(),
              ),
              Center(
                child: SwitchButtonB(),
              ),
              Center(
                child: SwitchButtonC(),
              ),
              Center(
                child: SwitchButtonD(),
              )
            ],
          ),
        ));
    // home: Scaffold(body: SpreadButtons()));
  }
}

class ListPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            BounceBuilder(),
          ],
        ),
        //     child: ListView(
        //     children:
        //       Iterable<int>.generate(10).map((i) => HeroContainer(i)).toList(),
        //  ),
      ),
    );
  }
}

class DetailPage extends StatelessWidget {
  const DetailPage(this.value);

  final int value;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
            child: GestureDetector(
      onTap: () => Navigator.of(context).pop(),
      child: Hero(
        tag: 'hero_container_$value',
        child: Container(
          width: 100,
          height: 100,
          color: HSVColor.fromAHSV(1, value / 10 * 360, 1, 1).toColor(),
        ),
      ),
    )));
  }
}

class HeroContainer extends StatelessWidget {
  const HeroContainer(this.idx);

  final int idx;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Navigator.of(context)
          .push(MaterialPageRoute(builder: (_) => DetailPage(idx))),
      child: Hero(
        tag: 'hero_container_$idx',
        child: Container(
          color: HSVColor.fromAHSV(1, idx / 10 * 360, 1, 1).toColor(),
          height: MediaQuery.of(context).size.height / 10,
        ),
      ),
    );
  }
}
