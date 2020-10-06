// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'globalSettings.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GlobalSettings _$GlobalSettingsFromJson(
    Map<String, dynamic> json) {
  return GlobalSettings()
    ..locale = json['locale'] as String
    ..theme = json['theme'] as String
    ..curPlayMode = json['curPlayMode'] as num
    // ..loginData = json['loginData'] as Login
    ..loginData = json['loginData'] == null
        ? null
        : Login.fromJson(
            json['loginData'] as Map<String, dynamic>)
    // ..curSong = json['curSong'] as Song
    ..curSongId = json['curSongId'] == null
        ? null
        : num.parse(json['curSongId'])
    // ..curPlaylist = json['curPlaylist'] as List<Song>;
    ..curPlaylist = (json['curPlaylist'] as List)
        ?.map((e) => e == null ? null : num.parse(e))
        ?.toList();
}

Map<String, dynamic> _$GlobalSettingsToJson(
        GlobalSettings instance) =>
    <String, dynamic>{
      'locale': instance.locale,
      'theme': instance.theme,
      'curPlayMode': instance.curPlayMode,
      'loginData': instance.loginData,
      'curSongId': instance.curSongId,
      'curPlaylist': instance.curPlaylist
    };
