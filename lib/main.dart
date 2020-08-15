import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Flutter Interaction Playground',
        theme: ThemeData(
          backgroundColor: Colors.white,
          // This is the theme of your application.
          //
          // Try running your application with "flutter run". You'll see the
          // application has a blue toolbar. Then, without quitting the app, try
          // changing the primarySwatch below to Colors.green and then invoke
          // "hot reload" (press "r" in the console where you ran "flutter run",
          // or simply save your changes to "hot reload" in a Flutter IDE).
          // Notice that the counter didn't reset back to zero; the application
          // is not restarted.
          primarySwatch: Colors.blue,
          // This makes the visual density adapt to the platform that you run
          // the app on. For desktop platforms, the controls will be smaller and
          // closer together (more dense) than on mobile platforms.
        ),
        home: Scaffold(body: ListPage()));
  }
}

class ListPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: ListView(
          children:
              Iterable<int>.generate(10).map((i) => HeroContainer(i)).toList(),
        ),
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
      onTap: () => Navigator.of(context)
          .pop(),
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
