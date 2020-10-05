import 'dart:convert';
import 'dart:io';

import 'package:path_provider/path_provider.dart';

import 'package:audioplayers/audioplayers.dart';
import 'package:feelings/models/index.dart';
import 'package:flutter/material.dart';
import 'package:feelings/global/theMusicController.dart';

class GlobalProfile {
  String locale = 'auto';
  String theme = "dark";
}

class Global {
  static initState() async {
    Directory documentsDir =
        await getApplicationDocumentsDirectory();
    String documentsPath = documentsDir.path;

    File file = File('$documentsPath/global.json');
    if (!file.existsSync()) {
      file.createSync();
    }

    String data = await file.readAsString();

    GlobalSettings settings =
        GlobalSettings.fromJson(json.decode(data));

    Global.loginData = settings.loginData;
    Global.profile.theme = settings.theme;
    Global.profile.locale = settings.locale;
    theMusicController.refreshBySong(
        settings.curSong, settings.curPlaylist);
    theMusicController.curPlayMode = settings.curPlayMode;
  }

  static GlobalProfile profile = GlobalProfile();

  static Login loginData;

  static saveProfile() async {
    Directory documentsDir =
        await getApplicationDocumentsDirectory();

    String documentsPath = documentsDir.path;

    File file = File('$documentsPath/global.json');

    if (!file.existsSync()) {
      file.createSync();
    }

    GlobalSettings settings = GlobalSettings.fromData(
      curPlayMode: theMusicController.curPlayMode,
      curPlaylist: theMusicController.curPlaylist,
      curSong: theMusicController.curSong,
      locale: Global.profile.locale,
      loginData: Global.loginData,
      theme: Global.profile.theme,
    );

    File file1 =
        await file.writeAsString(json.encode(settings));
    if (file1.existsSync()) {
      print('保存成功');
    }
  }
}

class ProfileChangeNotifier extends ChangeNotifier {
  GlobalProfile get _profile => Global.profile;

  @override
  void notifyListeners() {
    Global.saveProfile();
    super.notifyListeners();
  }
}

class LoginModel extends ProfileChangeNotifier {
  Profile get user => Global.loginData.profile;
  String get cookie => Global.loginData.cookie;
  bool get didLogin => Global.loginData?.cookie != null;

  set loginData(Login loginData) {
    Global.loginData = loginData;
    notifyListeners();
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

  togglePlay() async {
    await theMusicController.togglePlay();
    notifyListeners();
  }

  MusicPlayModel() {
    theMusicController.audioPlayer.onDurationChanged
        .listen((Duration d) {
      _curDuration = d;
      notifyListeners();
    });
    theMusicController.audioPlayer.onAudioPositionChanged
        .listen((Duration p) {
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
      if (newMode == 2) {
        theMusicController.randList.clear();
      }
    }

    notifyListeners();
    return newMode;
  }

  get playMode => theMusicController.curPlayMode;

  Duration _curDuration = Duration.zero;
  Duration _curPosition = Duration.zero;

  Future<int> refreshBySong(Song song,
      [List<Song> playlist]) async {
    int res =
        await theMusicController.refreshBySong(song, playlist);
    notifyListeners();
    Global.saveProfile();
    return res;
  }

  Future<int> cutSong(SongChangeType type) async {
    int res = await theMusicController.cutSong(type);
    notifyListeners();
    return res;
  }

  String get curSongUrl => theMusicController.curUrl == null
      ? ""
      : theMusicController.curUrl;
  String get curSongLyric => theMusicController.curLyric == null
      ? ""
      : theMusicController.curLyric;
  Song get curSong {
    Song song = theMusicController.curSong;
    if (song == null) {
      song = Song.fromJson({
        "name": "布拉格广场",
        "id": 210049,
        "ar": [
          {"id": 7219, "name": "蔡依林"}
        ],
        "al": {
          "id": 21349,
          "name": "看我72变",
          "picUrl":
              "https://p2.music.126.net/lsMlFshdJ96aTGFFgayh4Q==/109951163611523278.jpg",
          "tns": []
        },
        "mv": 186025
      });
    }
    return song;
  }
}
