import 'package:audioplayers/audioplayers.dart';
import 'dart:math';

import 'package:feelings/global/http.dart';
import 'package:feelings/models/index.dart';

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

  togglePlay({String url = ""}) async {
    switch (audioPlayer.state) {
      case AudioPlayerState.PLAYING:
        audioPlayer.pause();
        break;
      case AudioPlayerState.PAUSED:
        audioPlayer.resume();
        break;
      default:
        int result = await audioPlayer.play(
            "https://luan.xyz/files/audio/nasa_on_a_mission.mp3");
        if (result == 1) {
          // success
          print('play success');
        } else {
          print('play failed');
        }
        break;
    }
  }

  int curPlayMode = 0;
  /*  0 repeat,
      1 repeat_one,
      2 shuffle   */

  List<int> musicList = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11];
  int curSongId = 0;
  List randList = [];
  int randSeed = Random().nextInt(RAND_RANGE);
  Random r = Random();

  void cutSong(SongChangeType type) {
    Function method =
        curPlayMode == 2 ? getRandSong : getOrderedSong;

    curSongId = method(type);

    print(curSongId);
  }

  int getOrderedSong(SongChangeType type) {
    int step = type == SongChangeType.forward ? 1 : -1;
    int ind = musicList.indexOf(curSongId);
    return (ind + step) % musicList.length;
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

  Song curSong;
  String curLyric;
  String curUrl;

  void refreshBySong(Song song, [int playlistId]) {
    // GET(path);
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
