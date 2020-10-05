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

abstract class CutSongController {
  int getNext();
  int getPrevious();
}

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
        audioPlayer.pause();
        break;
      case AudioPlayerState.PAUSED:
        audioPlayer.resume();
        break;
      default:
        int result = await audioPlayer.play(curUrl);
        if (result == 1) {
          print('play success');
        } else {
          print('play failed');
        }
        break;
    }
  }

  playCurSong(String _) async {
    switch (audioPlayer.state) {
      case AudioPlayerState.PLAYING:
      case AudioPlayerState.PAUSED:
        audioPlayer.stop();
        break;
      default:
        break;
    }

    int result = await audioPlayer.play(curUrl);
    if (result == 1) {
      print('play success');
    } else {
      print('play failed');
    }
  }

  int curPlayMode = 0;
  /*  0 repeat,
      1 repeat_one,
      2 shuffle   */

  List<Song> _musicList;
  List<num> get musicList =>
      _musicList?.map((e) => e.id)?.toList();

  int curSongIndex = 0;
  List<num> randList = [];
  int randSeed = Random().nextInt(RAND_RANGE);
  Random r = Random();

  void cutSong(SongChangeType type) {
    Function method =
        curPlayMode == 2 ? getRandSong : getOrderedSong;

    curSongIndex = method(type);
    print(_musicList);
    print(curSongIndex);
    refreshBySong(curSong);
  }

  int getOrderedSong(SongChangeType type) {
    int step = type == SongChangeType.forward ? 1 : -1;
    return (curSongIndex + step) % musicList.length;
  }

  int getRandSong(SongChangeType type) {
    if (randList.length < RAND_LIST_LEN) {
      for (int i = 0; i < RAND_LIST_LEN; i++) {
        addWithoutDuplicates(
          randList,
          musicList.length,
          SongChangeType.forward,
        );
      }
    }

    addWithoutDuplicates(
      randList,
      musicList.length,
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
  Song get curSong =>
      _musicList == null ? null : _musicList[curSongIndex];
  String curUrl;

  void refreshBySong(Song song, [List<Song> playlist]) {
    if (song == null) {
      print("song is null");
      return;
    } else {
      print("not null: ${song.name}");
    }
    Requests.getSongUrl("${song.id}")
        .then((value) => curUrl = value)
        .then(playCurSong);
    Requests.getSongLyric("${song.id}")
        .then((value) => curLyric = value);

    if (playlist != _musicList && playlist != null) {
      _musicList = playlist;
      curSongIndex = _musicList.indexOf(song) - 1;
      cutSong(SongChangeType.forward);
    }
  }
}

var theMusicController = TheMusicController();

void addWithoutDuplicates(
    List list, int totalLen, SongChangeType type) {
  int listLength = list.length;
  int range = totalLen ~/ 2;
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

  int next;

  do {
    next = Random().nextInt(RAND_RANGE) % totalLen;
  } while (consideredList.contains(next));

  if (type == SongChangeType.forward) {
    list.add(next);
  } else {
    list.insert(0, next);
  }
}
