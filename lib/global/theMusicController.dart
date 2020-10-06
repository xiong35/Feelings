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
        int result = await audioPlayer
            .play(curUrl.replaceFirst("http://", "https://"));
        if (result == 1) {
          print('play success');
        } else {
          print('play failed');
        }
        break;
    }
  }

  Future playCurSong() async {
    switch (audioPlayer.state) {
      case AudioPlayerState.PLAYING:
      case AudioPlayerState.PAUSED:
        await audioPlayer.stop();
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
  List<Song> get curPlaylist => _musicList;

  int curSongIndex = 0;
  List<num> randList = [];
  int randSeed = Random().nextInt(RAND_RANGE);
  Random r = Random();

  Future<int> cutSong(SongChangeType type) async {
    Function method =
        curPlayMode == 2 ? getRandSong : getOrderedSong;

    curSongIndex = method(type);

    return await refreshBySong(curSong);
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

  Future<int> refreshBySong(Song song,
      [List<Song> playlist]) async {
    if (song == null) {
      print("song is null");
      return 1;
    } else {
      print("not null: ${song.name}");
    }

    if (playlist != _musicList && playlist != null) {
      _musicList = playlist;
    }
    curSongIndex = _musicList.indexOf(song);

    if (curSongIndex == -1) {
      curSongIndex = 0;
    }

    Requests.getSongLyric("${song.id}")
        .then((value) => curLyric = value);

    curUrl = await Requests.getSongUrl("${song.id}");
    await playCurSong();
    return 0;
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
