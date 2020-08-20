import 'dart:ffi';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class StatefulListPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => StatefulListState();
}

class ListItemState {
  ListItemState(this.idx, this.visible);

  final int idx;
  bool visible;
}

class StatefulListState extends State<StatefulListPage>
    with TickerProviderStateMixin {
  List<ListItemState> values;
  List<AnimationController> animationControllers = [];

  @override
  void initState() {
    values = Iterable<int>.generate(100)
        .map((i) => ListItemState(i, false))
        .toList();
    for (var i = 0; i < values.length; i++) {
      animationControllers.add(AnimationController(
          duration: Duration(milliseconds: 400), vsync: this));
    }
    print(values);
    super.initState();
  }

  /*
  void add() {
    setState(() {
      values.add(ListItemState(values.last.idx + 1, false));
    });
  }
*/
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
      body: ListView.builder(
        itemBuilder: (_, idx) {
          print('item builder runs at $idx');
          return SlideTransition(
            position: idx < 15
                ? Tween<Offset>(begin: Offset(-1, 0), end: Offset(0, 0)).chain(CurveTween(
                curve:
                Interval(idx/15, 1, curve: Curves.easeIn)))
                    .animate(animationControllers[idx]..forward()
                      )
                : Tween<Offset>(begin: Offset(-1, 0), end: Offset(0, 0))
                    .animate(animationControllers[idx]..forward()),
            child: Container(
              padding: EdgeInsets.all(10),
              child: Container(
                padding: EdgeInsets.all(24),
                color: Colors.grey[200],
                child: Text(values[idx].idx.toString()),
              ),
            ),
          );

          /*
              *
              * ScaleTransition(
            scale: CurvedAnimation(
                parent: AnimationController(
                    duration: Duration(seconds: 1), vsync: this)
                  ..forward(),
                curve: Curves.easeOutCirc),
            child: Container(
              decoration: BoxDecoration(
                color: Colors.grey[200],
                border:
                    Border(bottom: BorderSide(width: 0.5, color: Colors.grey)),
              ),
              child: ListTile(
                title: Text(values[idx].idx.toString()),
              ),
            ),
          );
              *
              * */
        },
        itemCount: values.length,
      ),
     /* floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        //   onPressed: () => add(),
      ),*/
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
