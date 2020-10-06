import 'dart:math';

import 'package:flutter/material.dart';

class ImgPlaceHolder extends StatelessWidget {
  const ImgPlaceHolder({
    Key key,
    this.url,
    this.width,
    this.height,
  }) : super(key: key);

  final String url;
  final double width;
  final double height;

  @override
  Widget build(BuildContext context) {
    if (url != null && url != "") {
      return Image.network(
        url.replaceFirst("http://", "https://"),
        fit: BoxFit.cover,
        width: width,
        height: height,
      );
    }

    int randID = Random().nextInt(3);
    return Image.asset(
      "images/ph$randID.png",
      fit: BoxFit.cover,
      height: height,
      width: width,
    );
  }
}
