import 'package:flutter/material.dart';

class PartDevider extends StatelessWidget {
  final double height;

  const PartDevider({Key key, this.height}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: height),
      color: Theme.of(context).colorScheme.surface,
    );
  }
}

class HeadingWithIcon extends StatelessWidget {
  const HeadingWithIcon({
    Key key,
    this.onPressed,
    this.iconData,
    this.heading,
  }) : super(key: key);

  final Function onPressed;
  final IconData iconData;
  final String heading;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.fromLTRB(18, 8, 16, 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            heading,
            style: TextStyle(
              fontSize: 20,
            ),
          ),
          IconButton(
            icon: Icon(
              iconData,
              color: Theme.of(context).colorScheme.secondary,
              size: 28,
            ),
            onPressed: onPressed,
          )
        ],
      ),
    );
  }
}
