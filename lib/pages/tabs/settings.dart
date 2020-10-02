import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

import 'package:feelings/utils/eventBus.dart';

class SettingsView extends StatelessWidget {
  const SettingsView({
    Key key,
    this.themeType,
  }) : super(key: key);

  final String themeType;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: [
          Padding(
            padding: EdgeInsets.all(28),
            child: Row(
              children: [
                Text(
                  '主题选择',
                  style: TextStyle(fontSize: 18),
                ),
                Selector(
                  contents: ['light', 'dark'],
                  initial: themeType,
                )
              ],
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
            ),
          )
        ],
      ),
    );
  }
}

// BEGIN cupertinoSegmentedControlDemo

class Selector extends StatefulWidget {
  const Selector({this.contents, this.initial});

  final List<String> contents;
  final String initial;

  @override
  _SelectorState createState() => _SelectorState();
}

class _SelectorState extends State<Selector> {
  String currentSegment;

  void onValueChanged(String newValue) {
    setState(() {
      currentSegment = newValue;
    });
    eventBus.emit("toggleTheme");
  }

  @override
  void initState() {
    currentSegment = widget.initial;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var children = Map<String, Widget>();
    widget.contents.forEach((content) {
      children[content] = Padding(
        child: Text(content),
        padding: EdgeInsets.fromLTRB(12, 8, 12, 8),
      );
    });

    return CupertinoSlidingSegmentedControl<String>(
      children: children,
      onValueChanged: onValueChanged,
      groupValue: currentSegment,
    );
  }
}
