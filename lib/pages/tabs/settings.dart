import 'package:flutter/material.dart';

import 'package:feelings/utils/eventBus.dart';

class SettingsView extends StatelessWidget {
  const SettingsView({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IconButton(
        icon: Icon(Icons.add),
        color: Colors.red,
        onPressed: () => eventBus.emit('toggleTheme', null),
      ),
    );
  }
}
