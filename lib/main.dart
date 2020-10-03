import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

import 'package:feelings/global/colors.dart';
import 'package:feelings/global/localization.dart';
import 'package:feelings/global/global.dart';

import 'package:feelings/pages/mainPage.dart';
import 'package:feelings/pages/playList.dart';

var routes = <String, WidgetBuilder>{
  "mainPage": (context) => MainPage(),
  "playlist": (context) => PlaylistView(),
};

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => LocaleModel()),
        ChangeNotifierProvider(create: (_) => ThemeModel()),
      ],
      child: Feelings(),
    ),
  );
}

class Feelings extends StatefulWidget {
  Feelings({Key key}) : super(key: key);

  @override
  _FeelingsState createState() => _FeelingsState();
}

class _FeelingsState extends State<Feelings> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Feelings',
      theme: FeelingsThemeData.getTheme(
        Provider.of<ThemeModel>(context, listen: true).theme,
      ),
      initialRoute: "playlist",
      localizationsDelegates: [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        FeelingsLocalizationsDelegate(),
      ],
      supportedLocales: [
        const Locale('en', 'US'), // English, no country code
        const Locale('zh', 'CN'), // Hebrew, no country code
      ],
      locale: context.watch<LocaleModel>().getLocale(),
      routes: routes,
    );
  }
}
