import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dart:math' as math;

class RollingFloatingButton extends StatefulWidget {
  @override
  RollingFloatingButtonState createState() => RollingFloatingButtonState();
}

class RollingFloatingButtonState extends State<RollingFloatingButton> {
  final _controller = PageController(viewportFraction: 0.7);

  // おそらくこれもanimatableなクラス
  // viewFraction(=k)を1以下にするとページの幅が画面のk割を占めるようになる
  // アクティブなコンテンツの隣の要素をz軸方向にゆがめたら3Dカルーセルが作れそう

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[300],
      body: PageView(
        controller: _controller,
        children: <Widget>[
          Transform(
              transform: Matrix4.identity()
                ..setEntry(3, 2, 0.001) // perspective
                ..rotateY(30 * 3.14 * 180)
                ..scale(0.9, 0.9),
              alignment: FractionalOffset.center,
              child: Container(
                height: MediaQuery.of(context).size.height * 0.5,
                width: MediaQuery.of(context).size.width * 0.5,
                color: Colors.transparent,
                child: Center(
                  child: Container(
                      width: MediaQuery.of(context).size.height * 0.4,
                      height: 400,
                      color: Colors.teal),
                ),
              ) //ColoredBox(color: Colors.blueGrey.shade100),
              ),
          Transform(
              transform: Matrix4.identity()
                ..setEntry(3, 2, 0.003) // perspective
                ..rotateY(0 * 3.14 * 180),
              alignment: FractionalOffset.center,
              child: Container(
                height: MediaQuery.of(context).size.height * 0.5,
                width: MediaQuery.of(context).size.width * 0.5,
                color: Colors.transparent,
                child: Center(
                  child: Container(
                      width: MediaQuery.of(context).size.height * 0.4,
                      height: 400,
                      color: Colors.teal),
                ),
              ) //ColoredBox(color: Colors.blueGrey.shade100),
              ),
          Transform(
              transform: Matrix4.identity()
                ..setEntry(3, 2, 0.001) // perspective
                ..rotateY(-30 * 3.14 * 180)
                ..scale(0.9, 0.9),
              alignment: FractionalOffset.center,
              child: Container(
                height: MediaQuery.of(context).size.height * 0.5,
                width: MediaQuery.of(context).size.width * 0.5,
                color: Colors.transparent,
                child: Center(
                  child: Container(
                      width: MediaQuery.of(context).size.height * 0.4,
                      height: 400,
                      color: Colors.teal),
                ),
              ) //ColoredBox(color: Colors.blueGrey.shade100),
              ),
        ],
      ),
      extendBody: true,
      // extendBodyをしていしないと、pageViewはbottomAppBarの上までしか広がらない.
      bottomNavigationBar: FloatingBottomBar(
        controller: _controller,
        items: [
          FloatingBottomBarItem(Icons.library_books, label: 'Page1'),
          FloatingBottomBarItem(Icons.add_box, label: 'Page2'),
          FloatingBottomBarItem(Icons.business, label: 'Page3'),
        ],
        activeItemColor: Colors.green.shade700,
        enableIconRotation: true,
        onTap: (index) {
          _controller.animateToPage(
            index,
            duration: const Duration(milliseconds: 400),
            curve: Curves.elasticOut,
          );
        },
      ),
    );
  }

  Widget _image(String url) {
    return Image.network(
      url,
      loadingBuilder: (_, child, progress) => progress == null
          ? FittedBox(fit: BoxFit.cover, child: child)
          : const Center(child: CircularProgressIndicator()),
    );
  }
}

const marginOfBottomAppbar = 14.0;
const heightOfBottomAppBar = 62.0;
const iconCircleRadius = 30.0;
const iconCircleMargin = 8.0;
const outerCircleRadius = 10.0;
const borderRadiusOfAppBarBottomCorner = 28.0;
const sizeOfAppBarItem = 30.0;
const _kPi = math.pi;

class FloatingBottomBarItem {
  const FloatingBottomBarItem(this.iconData, {this.label});

  final IconData iconData;
  final String label;
}

class FloatingBottomBar extends StatefulWidget {
  const FloatingBottomBar({
    @required this.controller,
    @required this.items,
    @required this.onTap,
    this.color,
    this.itemColor,
    this.activeItemColor,
    this.enableIconRotation,
  });

  final PageController controller;
  final List<FloatingBottomBarItem> items;
  final ValueChanged<int> onTap;
  final Color color;
  final Color itemColor;
  final Color activeItemColor;
  final bool enableIconRotation;

  @override
  _FloatingBottomBarState createState() => _FloatingBottomBarState();
}

class _FloatingBottomBarState extends State<FloatingBottomBar> {
  double _screenWidth;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _screenWidth = MediaQuery.of(context).size.width;
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final width = size.width;
    const height = heightOfBottomAppBar + marginOfBottomAppbar * 2;

    return AnimatedBuilder(
      animation: widget.controller,
      builder: (_, child) {
        var scrollPosition = 0.0;
        var currentIndex = 0;
        if (widget.controller?.hasClients ?? false) {
          // print(widget.controller.page);
          // widget.controller.pageは0-nまでの少数,画面のスクロールに合わせて変化する
          // pageViewにcontrollerを渡した場合は自分でページのインデックスを管理する
          scrollPosition = widget.controller.page;
          currentIndex = (widget.controller.page + 0.5).toInt();
        }

        return Stack(
          overflow: Overflow.visible,
          children: <Widget>[
            CustomPaint(
              size: Size(width, height),
              painter: _Painter(
                // xは円の場所、
                x: _itemXByScrollPosition(scrollPosition),
                color: widget.color,
              ),
            ),
            for (var i = 0; i < widget.items.length; i++) ...[
              if (i == currentIndex)
                Positioned(
                  top: marginOfBottomAppbar - iconCircleRadius + 8.0,
                  left:
                      iconCircleMargin + _itemXByScrollPosition(scrollPosition),
                  child: _ActiveItem(
                    i,
                    iconData: widget.items[i].iconData,
                    color: widget.activeItemColor,
                    scrollPosition: scrollPosition,
                    enableRotation: widget.enableIconRotation,
                    onTap: widget.onTap,
                  ),
                ),
              if (i != currentIndex)
                Positioned(
                  top: marginOfBottomAppbar +
                      (heightOfBottomAppBar - iconCircleRadius * 2) / 2,
                  left: iconCircleMargin + _itemXByIndex(i),
                  child: _Item(
                    i,
                    iconData: widget.items[i].iconData,
                    label: widget.items[i].label,
                    color: widget.itemColor,
                    onTap: widget.onTap,
                  ),
                ),
            ],
          ],
        );
      },
    );
  }

  double _firstItemX() {
    return marginOfBottomAppbar +
        (_screenWidth - marginOfBottomAppbar * 2) * 0.1;
  }

  double _lastItemX() {
    return _screenWidth -
        marginOfBottomAppbar -
        (_screenWidth - marginOfBottomAppbar * 2) * 0.1 -
        (iconCircleRadius + iconCircleMargin) * 2;
  }

  double _itemDistance() {
    return (_lastItemX() - _firstItemX()) / (widget.items.length - 1);
  }

  double _itemXByScrollPosition(double scrollPosition) {
    return _firstItemX() + _itemDistance() * scrollPosition;
  }

  double _itemXByIndex(int index) {
    return _firstItemX() + _itemDistance() * index;
  }
}

class _Item extends StatelessWidget {
  const _Item(this.index, {this.iconData, this.label, this.color, this.onTap});

  final int index;
  final IconData iconData;
  final String label;
  final Color color;
  final ValueChanged<int> onTap;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(0.0),
      child: SizedBox.fromSize(
        size: const Size(iconCircleRadius * 2, iconCircleRadius * 2),
        child: RawMaterialButton(
          shape: const CircleBorder(),
          padding: const EdgeInsets.all(0.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Icon(
                iconData,
                size: sizeOfAppBarItem - 4,
                color: color ?? Colors.grey.shade700,
              ),
              if (label != null) ...[
                const SizedBox(height: 3.0),
                Text(
                  label,
                  style: TextStyle(
                    color: color ?? Colors.grey.shade700,
                    fontSize: 12.0,
                  ),
                ),
              ],
            ],
          ),
          onPressed: () => onTap(index),
        ),
      ),
    );
  }
}

class _ActiveItem extends StatelessWidget {
  const _ActiveItem(
    this.index, {
    this.iconData,
    this.color,
    this.scrollPosition,
    this.enableRotation,
    this.onTap,
  });

  final int index;
  final IconData iconData;
  final Color color;
  final double scrollPosition;
  final bool enableRotation;
  final ValueChanged<int> onTap;

  @override
  Widget build(BuildContext context) {
    final icon = Icon(
      iconData,
      size: sizeOfAppBarItem,
      color: color ?? Colors.grey.shade700,
    );

    return InkWell(
      child: SizedBox.fromSize(
        size: const Size(iconCircleRadius * 2, iconCircleRadius * 2),
        child: enableRotation ?? false
            ? Transform.rotate(
                angle: _kPi * 2 * (scrollPosition % 1),
                child: icon,
              )
            : icon,
      ),
      onTap: () => onTap(index),
    );
  }
}

class _Painter extends CustomPainter {
  _Painter({@required this.x, this.color})
      : _paint = Paint()
          ..color = color ?? Colors.white
          ..isAntiAlias = true,
        _shadowColor = Colors.grey.withOpacity(0.4);

  final double x;
  final Color color;
  final Paint _paint;
  final Color _shadowColor;

  @override
  void paint(Canvas canvas, Size size) {
    _drawBar(canvas, size);
    _drawCircle(canvas);
  }

  @override
  bool shouldRepaint(_Painter oldDelegate) {
    return x != oldDelegate.x || color != oldDelegate.color;
  }

  void _drawBar(Canvas canvas, Size size) {
    const left = marginOfBottomAppbar;
    final right = size.width - marginOfBottomAppbar;
    const top = marginOfBottomAppbar;
    const bottom = top + heightOfBottomAppBar;

    final path = Path()
      ..moveTo(left + outerCircleRadius, top)
      ..lineTo(x - outerCircleRadius, top)
      ..relativeArcToPoint(
        const Offset(outerCircleRadius, outerCircleRadius),
        radius: const Radius.circular(outerCircleRadius),
      )
      ..relativeArcToPoint(
        const Offset((iconCircleRadius + iconCircleMargin) * 2, 0.0),
        radius: const Radius.circular(iconCircleRadius + iconCircleMargin),
        clockwise: false,
      )
      ..relativeArcToPoint(
        const Offset(outerCircleRadius, -outerCircleRadius),
        radius: const Radius.circular(outerCircleRadius),
      )
      ..lineTo(right - outerCircleRadius, top)
      ..relativeArcToPoint(
        const Offset(outerCircleRadius, outerCircleRadius),
        radius: const Radius.circular(outerCircleRadius),
      )
      ..lineTo(right, bottom - borderRadiusOfAppBarBottomCorner)
      ..relativeArcToPoint(
        const Offset(-borderRadiusOfAppBarBottomCorner,
            borderRadiusOfAppBarBottomCorner),
        radius: const Radius.circular(borderRadiusOfAppBarBottomCorner),
      )
      ..lineTo(left + borderRadiusOfAppBarBottomCorner, bottom)
      ..relativeArcToPoint(
        const Offset(-borderRadiusOfAppBarBottomCorner,
            -borderRadiusOfAppBarBottomCorner),
        radius: const Radius.circular(borderRadiusOfAppBarBottomCorner),
      )
      ..lineTo(left, top + outerCircleRadius)
      ..relativeArcToPoint(
        const Offset(outerCircleRadius, -outerCircleRadius),
        radius: const Radius.circular(outerCircleRadius),
      );

    canvas
      ..drawShadow(path, _shadowColor, 5.0, false)
      ..drawPath(path, _paint);
  }

  void _drawCircle(Canvas canvas) {
    final path = Path()
      ..addArc(
        Rect.fromCircle(
          center: Offset(
            x + iconCircleMargin + iconCircleRadius,
            marginOfBottomAppbar + iconCircleMargin,
          ),
          radius: iconCircleRadius,
        ),
        0,
        _kPi * 2,
      );

    canvas
      ..drawShadow(path, _shadowColor, 3.0, false)
      ..drawPath(path, _paint);
  }
}
