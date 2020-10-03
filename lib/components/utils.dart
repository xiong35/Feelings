import 'package:flutter/material.dart';

class PartDevider extends StatelessWidget {
  final double height;

  const PartDevider({Key key, this.height = 8})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: height),
      color: Theme.of(context).colorScheme.surface,
    );
  }
}
