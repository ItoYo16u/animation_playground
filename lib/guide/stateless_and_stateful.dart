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
      values.add(values.last + 1);
    });
  }

  @override
  void dispose() {
    super.dispose();
  }

  // stateful widgetではsetStateを用いて状態を変更するとbuildメソッドが再度呼ばれ画面が再描画される
  // イメージは以下
  // StatefulListPage() コンストラクタ
  //   - >  initState()
  //    - > build()
  //      - > add() -> setState() -> build()
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
        onPressed: () => add(),
      ),
    );
  }
}

@immutable
class StatelessListPage extends StatelessWidget {
  final List<int> values = Iterable<int>.generate(100).toList();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView.builder(
        itemBuilder: (_, idx) {
          print('item builder runs at $idx');
          // item builderは画面に入った要素をビルドする(画面をスクロールしてprintされる様子を確認されたし)
          // 画面に入っていない要素は描画されないので、リストの長さが十分に大きい場合はbuilderを使うことで
          // パフォーマンスを改善できる
          // リストの要素が少ないときはchildren: List<Widget>を使っても良い
          return ListTile(
            title: Text(values[idx].toString()),
          );
        },
        itemCount: values.length,
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () => add(),
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
