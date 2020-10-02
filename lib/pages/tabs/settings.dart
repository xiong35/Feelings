import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';

import 'package:feelings/global/localization.dart';
import 'package:feelings/global/global.dart';

class SettingsView extends StatelessWidget {
  const SettingsView({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var theme =
        Provider.of<ThemeModel>(context, listen: false).theme;
    var locale =
        Provider.of<LocaleModel>(context, listen: false).locale;

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
                  initial: theme,
                  onChange: (_) => Provider.of<ThemeModel>(
                              context,
                              listen: false)
                          .theme =
                      theme == "light" ? "dark" : "light",
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
                  contents: ['zh_CN', 'en_US'],
                  initial: locale,
                  onChange: (_) => Provider.of<LocaleModel>(
                              context,
                              listen: false)
                          .locale =
                      locale == 'en_US' ? 'zh_CN' : 'en_US',
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
