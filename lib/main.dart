import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

import 'package:feelings/global/colors.dart';
import 'package:feelings/global/localization.dart';
import 'package:feelings/global/global.dart';

import 'package:feelings/pages/mainPage.dart';
import 'package:feelings/pages/login.dart';
import 'package:feelings/pages/playList.dart';
import 'package:feelings/pages/musicPlay.dart';

var routes = <String, WidgetBuilder>{
  "mainPage": (context) => MainPage(),
  "playlist": (context) => PlaylistView(),
  "musicPlay": (context) => MusicPlayView(),
  "login": (context) => LoginView(),
};

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  try {
    await Global.initState();
  } catch (e) {
    print("oops");
    print(e);
  }
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => LocaleModel()),
        ChangeNotifierProvider(create: (_) => ThemeModel()),
        ChangeNotifierProvider(create: (_) => MusicPlayModel()),
        ChangeNotifierProvider(create: (_) => UserModel()),
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
    String initialRoute = "login";
    if (Global.loginData?.cookie != null)
      initialRoute = "mainPage";
    return MaterialApp(
      title: 'Feelings',
      theme: FeelingsThemeData.getTheme(
        Provider.of<ThemeModel>(context, listen: true).theme,
      ),
      // initialRoute: "mainPage",
      initialRoute: initialRoute,
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
      // onGenerateRoute: (RouteSettings settings) {
      //   String routeName = settings.name;
      //   switch (routeName) {
      //     case "mainPage":
      //       return MaterialPageRoute(builder: (context) {
      //         return MainPage();
      //       });
      //     case "playlist":
      //       return MaterialPageRoute(builder: (context) {
      //         return PlaylistView();
      //       });
      //     case "musicPlay":
      //       return MaterialPageRoute(builder: (context) {
      //         return MusicPlayView();
      //       });
      //     case "login":
      //       return MaterialPageRoute(builder: (context) {
      //         return LoginView();
      //       });
      //     default:
      //       return MaterialPageRoute(
      //           builder: (BuildContext context) {
      //         return Scaffold(
      //             body: Center(
      //           child: Text("Page not found"),
      //         ));
      //       });
      //   }
      // },
    );
  }
}
