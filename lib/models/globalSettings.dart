import 'package:json_annotation/json_annotation.dart';
import 'music/song.dart';
import 'user/login.dart';
// import "login.dart";
// import "song.dart";
part 'globalSettings.g.dart';

@JsonSerializable()
class GlobalSettings {
  GlobalSettings.fromData({
    this.curPlayMode,
    this.curPlaylist,
    this.curSongId,
    this.locale,
    this.loginData,
    this.theme,
  });

  GlobalSettings();

  String locale;
  String theme;
  Login loginData;
  num curSongId;
  List<num> curPlaylist;
  num curPlayMode;

  factory GlobalSettings.fromJson(Map<String, dynamic> json) =>
      _$GlobalSettingsFromJson(json);
  Map<String, dynamic> toJson() => _$GlobalSettingsToJson(this);
}
