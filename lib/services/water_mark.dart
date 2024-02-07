import 'dart:math';

import 'package:flutter/material.dart';
import 'package:itecc_member/style/color.dart';

class Watarmark extends StatelessWidget {
  final int rowCount;
  final int columnCount;
  final String text;

  const Watarmark(
      {Key? key,
      required this.rowCount,
      required this.columnCount,
      required this.text})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return IgnorePointer(
      child: Container(
          child: Column(
        children: creatColumnWidgets(),
      )),
    );
  }

  List<Widget> creatRowWdiges() {
    List<Widget> list = [];
    for (var i = 0; i < rowCount; i++) {
      final widget = Expanded(
          child: Center(
              child: Transform.rotate(
        angle: -pi / 18,
        child: Text(
          overflow: TextOverflow.fade,
          
          softWrap: false,
          text,
          style: TextStyle(
              color: Colors.black12, // Color(0x08000000),
              fontSize: 10,
              decoration: TextDecoration.none),
        ),
      )));
      list.add(widget);
    }
    return list;
  }

  List<Widget> creatColumnWidgets() {
    List<Widget> list = [];
    for (var i = 0; i < columnCount; i++) {
      final widget = Expanded(
          child: Row(
        children: creatRowWdiges(),
      ));
      list.add(widget);
    }
    return list;
  }
}
