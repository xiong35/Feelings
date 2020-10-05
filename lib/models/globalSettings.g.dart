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
    ..curSong = json['curSong'] == null
        ? null
        : Song.fromJson(json['curSong'] as Map<String, dynamic>)
    // ..curPlaylist = json['curPlaylist'] as List<Song>;
    ..curPlaylist = (json['curPlaylist'] as List)
        ?.map((e) => e == null
            ? null
            : Song.fromJson(e as Map<String, dynamic>))
        ?.toList();
}

Map<String, dynamic> _$GlobalSettingsToJson(
        GlobalSettings instance) =>
    <String, dynamic>{
      'locale': instance.locale,
      'theme': instance.theme,
      'curPlayMode': instance.curPlayMode,
      'loginData': instance.loginData,
      'curSong': instance.curSong,
      'curPlaylist': instance.curPlaylist
    };
