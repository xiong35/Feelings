import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:feelings/global/theMusicController.dart';

class Profile {
  String locale = 'auto';
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
    if (_profile.locale == 'auto') return null;
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

class MusicPlayModel extends ChangeNotifier {
  bool get isPlaying => theMusicController.isPlaying;

  togglePlay({String url = ""}) {
    theMusicController.togglePlay(url: url);
    notifyListeners();
  }

  MusicPlayModel() {
    theMusicController.audioPlayer.onDurationChanged
        .listen((Duration d) {
      print('Max duration: ${d.inSeconds}');
      _curDuration = d;
      notifyListeners();
    });
    theMusicController.audioPlayer.onAudioPositionChanged
        .listen((Duration p) {
      print(
          'Current position: ${p.toString().substring(2, 7)}');
      _curPosition = p;
      notifyListeners();
    });
  }

  get curPosition => _curPosition;
  get curDuration => _curDuration;
  get percent =>
      _curPosition.inMilliseconds /
      (_curDuration.inMilliseconds + 0.0001);

  set percent(double percent) {
    theMusicController.audioPlayer.seek(_curDuration * percent);
    notifyListeners();
  }

  int togglePlayMode() {
    int newMode = (theMusicController.curPlayMode + 1) % 3;
    theMusicController.curPlayMode = newMode;

    if (newMode == 1) {
      theMusicController.audioPlayer
          .setReleaseMode(ReleaseMode.LOOP);
    } else {
      theMusicController.audioPlayer
          .setReleaseMode(ReleaseMode.STOP);
    }

    notifyListeners();

    return newMode;
  }

  get playMode => theMusicController.curPlayMode;

  Duration _curDuration = Duration.zero;
  Duration _curPosition = Duration.zero;
}
