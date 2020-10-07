import 'package:feelings/pages/tabs/search.dart';
import 'package:flutter/material.dart';

class RandBtn extends StatelessWidget {
  const RandBtn({Key key, this.p, this.onPressed})
      : super(key: key);

  final PositionInNum p;
  final Function onPressed;

  @override
  Widget build(BuildContext context) {
    return Positioned(
      child: TextButton(
        child: Text("中国新说唱 冷血"),
        onPressed: onPressed,
      ),
      right: p.right,
      left: p.left,
      top: p.top,
      bottom: p.bottom,
    );
  }
}
