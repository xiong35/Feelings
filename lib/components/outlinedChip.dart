import 'package:flutter/material.dart';

class OutlinedChip extends StatelessWidget {
  const OutlinedChip({Key key, this.color, this.text})
      : super(key: key);

  final Color color;
  final String text;

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
        border: Border.all(
          color: color,
        ),
        borderRadius: BorderRadius.circular(999),
      ),
      child: Padding(
        padding: EdgeInsets.fromLTRB(10, 5, 10, 5),
        child: Text(
          text,
          style: TextStyle(color: color, fontSize: 14),
        ),
      ),
    );
  }
}
