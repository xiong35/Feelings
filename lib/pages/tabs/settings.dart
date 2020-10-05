import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';

import 'package:feelings/global/localization.dart';
import 'package:feelings/global/global.dart';

class SettingsView extends StatelessWidget {
  SettingsView({
    Key key,
  }) : super(key: key);

  final GlobalKey<ScaffoldState> _scaffoldKey =
      GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    var theme =
        Provider.of<ThemeModel>(context, listen: false).theme;
    var locale =
        Provider.of<LocaleModel>(context, listen: false).locale;

    var LIGHT =
        FeelingsLocalization.of(context).settingsThemeOpsLight;
    var DARK =
        FeelingsLocalization.of(context).settingsThemeOpsDark;
    var ZH =
        FeelingsLocalization.of(context).settingsLanguageOpsZH;
    var EN =
        FeelingsLocalization.of(context).settingsLanguageOpsEN;
    var AUTO = FeelingsLocalization.of(context)
        .settingsLanguageOpsAuto;

    return Scaffold(
      body: ListView(
        children: [
          Padding(
            padding: EdgeInsets.all(28),
            child: Row(
              children: [
                Text(
                  FeelingsLocalization.of(context)
                      .settingsSetTheme,
                  style: TextStyle(fontSize: 18),
                ),
                Selector(
                  contents: [LIGHT, DARK],
                  names: ['light', 'dark'],
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
                  FeelingsLocalization.of(context)
                      .settingsSetLanguage,
                  style: TextStyle(fontSize: 18),
                ),
                Selector(
                  contents: [AUTO, ZH, EN],
                  names: ['auto', 'zh_CN', 'en_US'],
                  initial: locale,
                  onChange: (newVal) =>
                      Provider.of<LocaleModel>(context,
                              listen: false)
                          .locale = newVal,
                )
              ],
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
            ),
          ),
          SizedBox(height: 40),
          Center(
            child: TextButton(
              onPressed: () async {
                await showDialog(
                    context: context,
                    child: AlertDialog(
                      content: Text(
                        FeelingsLocalization.of(context)
                            .settingsComfirmExit,
                      ),
                      actions: [
                        FlatButton(
                          child: Text(
                            FeelingsLocalization.of(context)
                                .settingsComfirmYes,
                            style: TextStyle(
                                color: Theme.of(context)
                                    .colorScheme
                                    .secondary),
                          ),
                          onPressed: () {
                            Provider.of<LoginModel>(context,
                                    listen: false)
                                .quit();
                            Navigator.pushNamed(
                                context, "mainPage");
                          },
                        ),
                        FlatButton(
                          child: Text(
                            FeelingsLocalization.of(context)
                                .settingsComfirmNo,
                            style: TextStyle(
                                color: Theme.of(context)
                                    .colorScheme
                                    .primary),
                          ),
                          onPressed: () {
                            Navigator.of(context,
                                    rootNavigator: true)
                                .pop();
                          },
                        ),
                      ],
                    ));
              },
              child: Text(
                FeelingsLocalization.of(context).settingsExit,
                style: TextStyle(
                  fontSize: 18,
                  color: Theme.of(context)
                      .colorScheme
                      .secondaryVariant,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class Selector extends StatefulWidget {
  const Selector({
    this.contents,
    this.initial,
    this.onChange,
    this.names,
  });

  final List<String> contents;
  final String initial;
  final Function onChange;
  final List<String> names;

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
    for (var i = 0; i < widget.contents.length; i++) {
      children[widget.names[i]] = Padding(
        child: Text(widget.contents[i]),
        padding: EdgeInsets.fromLTRB(10, 6, 10, 6),
      );
    }
    return CupertinoSlidingSegmentedControl<String>(
      children: children,
      onValueChanged: onValueChanged,
      groupValue: currentSegment,
    );
  }
}
