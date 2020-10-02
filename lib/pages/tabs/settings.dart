import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

import 'package:feelings/utils/eventBus.dart';
import 'package:feelings/global/localization.dart';

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
                  FeelingsLocalization.of(context).title,
                  style: TextStyle(fontSize: 18),
                ),
                Selector(
                  contents: ['light', 'dark'],
                  initial: themeType,
                  onChange: (_) => eventBus.emit("toggleTheme"),
                )
              ],
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
            ),
          ),
          Padding(
            padding: EdgeInsets.all(28),
            child: Row(
              children: [
                Text(
                  FeelingsLocalization.of(context).title,
                  style: TextStyle(fontSize: 18),
                ),
                Selector(
                  contents: ['zh', 'en'],
                  initial: FeelingsLocalization.of(context).isZh
                      ? 'zh'
                      : 'en',
                  onChange: (_) => {},
                )
              ],
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
            ),
          ),
        ],
      ),
    );
  }
}

// BEGIN cupertinoSegmentedControlDemo

class Selector extends StatefulWidget {
  const Selector({
    this.contents,
    this.initial,
    this.onChange,
  });

  final List<String> contents;
  final String initial;
  final Function onChange;

  @override
  _SelectorState createState() => _SelectorState();
}

class _SelectorState extends State<Selector> {
  String currentSegment;

  void onValueChanged(String newValue) {
    setState(() {
      currentSegment = newValue;
    });

    widget.onChange(newValue);
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
