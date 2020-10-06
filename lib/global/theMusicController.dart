import 'package:audioplayers/audioplayers.dart';
import 'dart:math';

import 'package:feelings/global/http.dart';
import 'package:feelings/models/index.dart';
import 'package:feelings/global/requests.dart';

enum SongChangeType {
  forward,
  backward,
}

const RAND_RANGE = 996996;
const RAND_LIST_LEN = 50;
const RAND_POINTER = 30;

class TheMusicController {
  TheMusicController._constructor();

  static TheMusicController _singleton =
      TheMusicController._constructor();

  factory TheMusicController() => _singleton;

  final AudioPlayer audioPlayer = AudioPlayer()
    ..setReleaseMode(ReleaseMode.STOP);

  bool get isPlaying {
    return audioPlayer.state == AudioPlayerState.PLAYING;
  }

  togglePlay() async {
    switch (audioPlayer.state) {
      case AudioPlayerState.PLAYING:
        await audioPlayer.pause();
        break;
      case AudioPlayerState.PAUSED:
        await audioPlayer.resume();
        break;
      default:
        num result = await audioPlayer.play(curUrlSecure);
        if (result == 1) {
          print('play success');
        } else {
          print('play failed');
        }
        break;
    }
  }

  Future playCurSong() async {
    await stopCurSong();

    num result = await audioPlayer.play(curUrlSecure);
    if (result == 1) {
      print('play success');
    } else {
      print('play failed');
    }
  }

  Future stopCurSong() async {
    switch (audioPlayer.state) {
      case AudioPlayerState.PLAYING:
      case AudioPlayerState.PAUSED:
        await audioPlayer.stop();
        break;
      default:
        break;
    }
  }

  num curPlayMode = 0;
  /*  0 repeat,
      1 repeat_one,
      2 shuffle   */

  List<num> musicIdList;

  num curSongIndex = 0;
  List<num> randList = [];
  Random r = Random();

  Future<num> cutSong(SongChangeType type) async {
    await stopCurSong();
    Function method =
        curPlayMode == 2 ? _getRandSongInd : _getOrderedSongInd;

    curSongIndex = method(type);

    num res = await refreshById(curSongId);

    return res;
  }

  num _getOrderedSongInd(SongChangeType type) {
    num step = type == SongChangeType.forward ? 1 : -1;
    return (curSongIndex + step) % musicIdList.length;
  }

  num _getRandSongInd(SongChangeType type) {
    if (randList.length < RAND_LIST_LEN) {
      for (num i = randList?.length ?? 0;
          i < RAND_LIST_LEN;
          i++) {
        addWithoutDuplicates(
          randList,
          musicIdList.length,
          SongChangeType.forward,
        );
      }
    }

    addWithoutDuplicates(
      randList,
      musicIdList.length,
      type,
    );
    if (type == SongChangeType.forward) {
      randList.removeAt(0);
    } else {
      randList.removeAt(randList.length - 1);
    }

    return randList[RAND_POINTER];
  }

  String curLyric;

  Song curSong;

  num get curSongId =>
      musicIdList == null ? null : musicIdList[curSongIndex];

  String curUrl;
  String get curUrlSecure =>
      curUrl?.replaceFirst("http://", "https://") ?? "";

  Future<num> refreshById(num id, [List<num> playlist]) async {
    id = id ?? -1;
    if (playlist != null &&
        !intListIsEqual(playlist, musicIdList)) {
      musicIdList = playlist;
    }

    curSongIndex = musicIdList?.indexOf(id) ?? -1;
    if (curSongIndex == -1) {
      if (curPlayMode == 2) {
        curSongIndex = r.nextInt(musicIdList.length);
      } else {
        curSongIndex = 0;
      }
    }

    Requests.getSongLyric("$id")
        .then((value) => curLyric = value);

    var retList = await Future.wait([
      Requests.getSongDetail(["$curSongId"]),
      Requests.getSongUrl("$id"),
    ]);

    curSong = (retList[0] as List<Song>)[0];
    curUrl = retList[1] as String;

    await playCurSong();

    return 0;
  }
}

var theMusicController = TheMusicController();

void addWithoutDuplicates(
    List list, num totalLen, SongChangeType type) {
  num listLength = list.length;
  num range = totalLen ~/ 2;
  List consideredList;

  if (listLength <= range) {
    consideredList = list;
  } else {
    if (type == SongChangeType.forward) {
      consideredList = list.sublist(listLength - range);
    } else {
      consideredList = list.sublist(0, range);
    }
  }

  num next;

  do {
    next = Random().nextInt(RAND_RANGE) % totalLen;
  } while (consideredList.contains(next));

  if (type == SongChangeType.forward) {
    list.add(next);
  } else {
    list.insert(0, next);
  }
}

bool intListIsEqual(List<num> l1, List<num> l2) {
  Set<num> s1 = Set.from(l1 ?? []);
  Set<num> s2 = Set.from(l2 ?? []);
  if (s1.length != s2.length) return false;

  return s1.difference(s2).length == 0;
}
