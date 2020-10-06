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
  static List<num> likes;

  static Future initState() async {
    Directory documentsDir =
        await getApplicationDocumentsDirectory();
    String documentsPath = documentsDir.path;

    File file = File('$documentsPath/global.json');
    if (!file.existsSync()) {
      file.createSync();
      return;
    }

    String data = await file.readAsString();

    GlobalSettings settings =
        GlobalSettings.fromJson(json.decode(data));

    Global.loginData = settings.loginData;
    Global.profile.theme = settings.theme;
    Global.profile.locale = settings.locale;
    await theMusicController.refreshById(
        settings.curSongId, settings.curPlaylist);
    theMusicController.curPlayMode = settings.curPlayMode;
    await theMusicController.togglePlay();
  }

  static GlobalProfile profile = GlobalProfile();

  static Login loginData;

  static Future saveProfile() async {
    Directory documentsDir =
        await getApplicationDocumentsDirectory();

    String documentsPath = documentsDir.path;

    File file = File('$documentsPath/global.json');

    if (!file.existsSync()) {
      file.createSync();
    }

    GlobalSettings settings = GlobalSettings.fromData(
      curPlayMode: theMusicController.curPlayMode,
      curPlaylist: theMusicController.musicIdList,
      curSongId: theMusicController.curSongId,
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

class UserModel extends ProfileChangeNotifier {
  Profile get user => Global.loginData.profile;
  String get cookie => Global.loginData.cookie;
  bool get didLogin => Global.loginData?.cookie != null;
  List<num> get likes => Global.likes;

  set loginData(Login loginData) {
    Global.loginData = loginData;
    notifyListeners();
  }

  set likes(List<num> likes) {
    Global.likes = likes;
    notifyListeners();
  }

  quit() {
    Global.loginData = null;
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

  static MusicPlayModel _singleton =
      MusicPlayModel._constructor();

  MusicPlayModel._constructor() {
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

    theMusicController.audioPlayer.onPlayerCompletion
        .listen((event) {
      if (theMusicController.curPlayMode == 1) return;
      theMusicController.cutSong(SongChangeType.forward);
    });
  }

  factory MusicPlayModel() => _singleton;

  get curPosition => _curPosition;
  get curDuration => _curDuration + Duration(milliseconds: 200);
  get percent =>
      _curPosition.inMilliseconds /
      (_curDuration.inMilliseconds + 500);

  set percent(double percent) {
    if (theMusicController.audioPlayer.state ==
            AudioPlayerState.STOPPED ||
        theMusicController.audioPlayer.state ==
            AudioPlayerState.COMPLETED) return;
    try {
      theMusicController.audioPlayer
          .seek(_curDuration * percent);
    } catch (e) {
      print("oops");
      print(e);
    }
    notifyListeners();
  }

  num togglePlayMode() {
    num newMode = (theMusicController.curPlayMode + 1) % 3;
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
    Global.saveProfile();
    return newMode;
  }

  get playMode => theMusicController.curPlayMode;

  Duration _curDuration = Duration.zero;
  Duration _curPosition = Duration.zero;

  Future<num> refreshById(num id, [List<num> playlist]) async {
    num res =
        await theMusicController.refreshById(id, playlist);
    notifyListeners();
    await Global.saveProfile();
    return res;
  }

  Future<num> cutSong(SongChangeType type) async {
    num res = await theMusicController.cutSong(type);
    await Global.saveProfile();
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
        "name": "Lost Stars",
        "id": 28737747,
        "ar": [
          {"id": 196215, "name": "Adam Levine"}
        ],
        "al": {
          "id": 2883909,
          "name":
              "Begin Again (Music From and Inspired By the Original Motion Picture)",
          "picUrl":
              "https://p2.music.126.net/HfONoiydSxBFn2SMmyN3qg==/3235862724973369.jpg",
        },
        "mv": 285033
      });
    }
    return song;
  }
}
