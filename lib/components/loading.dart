import 'package:flutter/material.dart';

class Loading extends StatelessWidget {
  const Loading({
    Key key,
    this.child,
    this.isLoading,
  }) : super(key: key);

  final Widget child;
  final bool isLoading;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        child,
        if (isLoading)
          Container(
            color: Theme.of(context)
                .colorScheme
                .surface
                .withAlpha(200),
          ),
        if (isLoading)
          Center(
            child: CircularProgressIndicator(),
          ),
      ],
    );
  }
}
