import 'package:flutter/material.dart';

import 'package:feelings/global/colors.dart';
import 'package:feelings/pages/mainPage.dart';
import 'package:feelings/utils/eventBus.dart';

void main() {
  runApp(Feelings());
}

class Feelings extends StatefulWidget {
  Feelings({Key key}) : super(key: key);

  @override
  _FeelingsState createState() => _FeelingsState();
}

class _FeelingsState extends State<Feelings> {
  String themeType = "light";

  @override
  void initState() {
    eventBus.on("toggleTheme", (_) {
      toggleTheme();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Feelings',
      theme: FeelingsThemeData.getTheme(themeType),
      home: MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }

  toggleTheme() {
    if (mounted) {
      setState(() {
        themeType = themeType == "dark" ? "light" : "dark";
      });
    }
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return MainPage();
  }
}

class ThemeEvent {
  ThemeData theme;
  ThemeEvent(this.theme);
}
