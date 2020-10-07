import 'package:feelings/pages/tabs/search.dart';
import 'package:flutter/material.dart';

class RandBtn extends StatelessWidget {
  const RandBtn({
    Key key,
    this.p,
    this.onPressed,
    this.text,
    this.color,
  }) : super(key: key);

  final PositionInNum p;
  final Function onPressed;
  final String text;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Positioned(
      child: TextButton(
        child: Text(
          text,
          style: TextStyle(color: color),
        ),
        onPressed: onPressed,
      ),
      right: p.right,
      left: p.left,
      top: p.top,
      bottom: p.bottom,
    );
  }
}
