import 'dart:ffi';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class StatefulListPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => StatefulListState();
}

class StatefulListState extends State<StatefulListPage> {
  List<int> values;

  @override
  void initState() {

    values = Iterable<int>.generate(3).toList();
    print(values);
    super.initState();
  }

  void add() {
    setState(() {
       values.add(values.last+1);
    });
  }

  @override
  void dispose() {
    super.dispose();
  }
  // stateful widgetではsetStateを用いて状態を変更するとbuildメソッドが再度呼ばれ画面さ再描画される。
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: values
            .map((e) => ListTile(
          title: Text(e.toString()),
          onTap: () => add(),
        ))
            .toList(),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: ()=>add(),
      ),
    );
  }
}



@immutable
class StatelessListPage extends StatelessWidget {
  final List<int> values = Iterable<int>.generate(3).toList();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:  ListView(
        children: values
            .map((e) => ListTile(
          title: Text(e.toString()),
        ))
            .toList(),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: ()=>add(),
      ),
    );
  }
  // listの中身は変わるが変更はuiに反映されない.
  // final な要素でも内部の状態は変更できてしまう点に注意
  void add() {
    values.add(values.last + 1);
    print(values);
  }
}
