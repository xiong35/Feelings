import 'package:flutter/material.dart';

class Profile {
  String locale;
  String theme = "light";
}

class Global {
  static Profile profile = Profile();

  static saveProfile() => {
        print(
          'locale: ${profile.locale}, theme: ${profile.theme}',
        )
      };
}

class ProfileChangeNotifier extends ChangeNotifier {
  Profile get _profile => Global.profile;

  @override
  void notifyListeners() {
    Global.saveProfile();
    super.notifyListeners();
  }
}

class LocaleModel extends ProfileChangeNotifier {
  Locale getLocale() {
    if (_profile.locale == null) return null;
    var t = _profile.locale.split("_");
    return Locale(t[0], t[1]);
  }

  String get locale => _profile.locale;

  set locale(String locale) {
    _profile.locale = locale;
    notifyListeners();
  }
}

class ThemeModel extends ProfileChangeNotifier {
  String get theme => _profile.theme;

  set theme(String newTheme) {
    _profile.theme = newTheme;
    notifyListeners();
  }
}
