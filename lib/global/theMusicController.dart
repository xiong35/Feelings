import 'package:audioplayers/audioplayers.dart';

class TheMusicController {
  TheMusicController._constructor();

  static TheMusicController _singleton =
      TheMusicController._constructor();

  factory TheMusicController() => _singleton;

  final AudioPlayer audioPlayer = AudioPlayer();

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
}

var theMusicController = TheMusicController();
