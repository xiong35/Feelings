import 'package:flutter/material.dart';
import 'package:event_bus/event_bus.dart';

import 'package:feelings/global/colors.dart';
import 'package:feelings/components/thePlayPanel.dart';

EventBus eventBus = EventBus();

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
    //注册eventBus事件，监听到变化的时候调用changeColor(color)
    eventBus.on<ThemeEvent>().listen((ThemeEvent data) {
      changeTheme(data.theme);
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

  changeTheme(ThemeData theme) {
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
    return Scaffold(
        appBar: AppBar(
          title: Text(widget.title),
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(
                'You have pushed the button this many times:',
              ),
              Text(
                '_counter',
                style: Theme.of(context).textTheme.headline4,
              ),
            ],
          ),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () => eventBus.fire(
              ThemeEvent(FeelingsThemeData.darkThemeData)),
          tooltip: 'Increment',
          child: Icon(Icons.add),
        ),
        bottomNavigationBar: ThePlayPanel(
            authorName: "author",
            musicName: "Feelings",
            musicCover: Image.network(
                "http://static.xiong35.cn/image/icons/open-doodles/15.png",
                fit: BoxFit.cover,
                height: 50.0,
                width: 50.0)));
  }
}

class ThemeEvent {
  ThemeData theme;
  ThemeEvent(this.theme);
}
